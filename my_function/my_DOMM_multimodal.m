function [final_prediction_ranksvm_g,DOMM_RS_UAR,DOMM_RS_wkappa] = my_DOMM_multimodal(win,overlap,sh1,sh2,audio,video,label,audio_name,video_name,emotion)
display("Start multimodal analysis for " + emotion + " with Audio: "+ audio_name + " Video: "+ video_name);

%% compensate delay
if emotion == "arousal"
delay = 25*4; 
else 
    delay = 25*2;
end
%win = 25;%0.04s*25 = 1s
for u = 1:9
    label.train{u}(1:delay,:) = [];
    label.test{u}(1:delay,:) = [];
end
for u = 1:9
    audio.train_features{u}((7501-delay+1):end,:)= [];
    audio.test_features{u}((7501-delay+1):end,:)= [];
    video.train_features{u}((7501-delay+1):end,:)= [];
    video.test_features{u}((7501-delay+1):end,:)= [];
end
for u = 1:9
    a_v.train_features{u,1} = [audio.train_features{u}  video.train_features{u}];
    a_v.test_features{u,1} = [ audio.test_features{u} video.test_features{u}];
end
%% Convert interval to ordinal labels
display("Start interval ordinal label conversion.")
[train_set7475,test_set7475] = my_num2ord(label,win,overlap,sh1,sh2);
train_set7475.interval = label.train;
test_set7475.interval = label.test;

[train_set7475.audio,test_set7475.audio] = my_windowing_features(audio,win,overlap);
[train_set7475.video,test_set7475.video] = my_windowing_features(video,win,overlap);
[train_set7475.a_v,test_set7475.a_v] = my_windowing_features(a_v,win,overlap);

%% Fit distribution for each rater
for rater = 1:6
    [data(rater).new_Tran,data(rater).total_Tran,data(rater).P] = organize_ranks_transition(train_set7475.abs,train_set7475.rank,rater);
end
%% Get global ordinal labels
train_set7475_g = train_set7475;
test_set7475_g = test_set7475;
for u = 1:9
    [global_train_abs{u,1}(:,1),num_votes{u}] = mode(train_set7475.abs{u}');
    [global_test_abs{u,1}(:,1),num_votes{u}] = mode(test_set7475.abs{u}');
end
train_set7475_g.abs = global_train_abs;
test_set7475_g.abs = global_test_abs;

%
%% Back to load the computed rank
if emotion == "arousal"
load("E:\0UNSW_PhD\Code\Ordinal_FSMM\RECOLA_final\good\arousal_0.14\change_window_size\arousal_global_rank_win"+win+".mat")
else
    load("E:\0UNSW_PhD\Code\Ordinal_FSMM\RECOLA_final\good\valence_0_0.17\change_window_size\valence_global_rank_win"+win+".mat")
end
%%
ssize = length(train_set7475.rank{1});

train_set7475_g.rank = mat2cell(global_rank_train',[ssize],[ones(9,1)])';
test_set7475_g.rank = mat2cell(global_rank_test',[ssize],[ones(9,1)])';
%%
[data_g.new_Tran,data_g.total_Tran,data_g.P] = my_organize_ranks_transition_g(train_set7475_g.abs,train_set7475_g.rank);
[data_g2.new_Tran,data_g2.total_Tran,data_g2.P] = my_organize_ranks_transition_g(test_set7475_g.abs,test_set7475_g.rank);
%%
    for i = 1:9
        data_total.new_Tran{i} = cat(2,data(1).new_Tran{i},data(2).new_Tran{i});
        for rater = 3:6
            data_total.new_Tran{i} = cat(2,data_total.new_Tran{i},data(rater).new_Tran{i});
        end
    end
    for i = 1:3
        data_total.total_Tran{i} = cat(2,data(1).total_Tran{i},data(2).total_Tran{i});
        for rater = 3:6
            data_total.total_Tran{i} = cat(2,data_total.total_Tran{i},data(rater).total_Tran{i});
        end
    end
 data_total.P = data_g.P;
 if length(data_total.new_Tran{7} == 0)
 data_total.new_Tran{7} = cat(2,-data_total.new_Tran{3}, data_total.new_Tran{7});
 end
%% RankSVM using three cues
display("Start processing Dynamic Model: RankSVM...")
display("RankSVM: Audio features")
[pr_rank_g.audio,P_g.audio] = my_dynamic_RankSVM_g_multimodal(train_set7475_g,test_set7475_g,"audio");
display("RankSVM: Video features")
[pr_rank_g.video,P_g.video] = my_dynamic_RankSVM_g_multimodal(train_set7475_g,test_set7475_g,"video");
display("RankSVM: Audio-Visual features")
[pr_rank_g.a_v,P_g.a_v] = my_dynamic_RankSVM_g_multimodal(train_set7475_g,test_set7475_g,"a_v");
%% OMSVM using three cues
display("Start processing Static Model: OMSVM...")
display("OMSVM: Audio features")
[predict_class_g.audio,predict_class_g.UAR_audio,predict_Posterior_g.audio,predict_class_g.wkappa_audio] = my_static_model_OMSVM_g_multimodal(train_set7475_g,test_set7475_g,"audio");
display("OMSVM: Video features")
[predict_class_g.video,predict_class_g.UAR_video,predict_Posterior_g.video,predict_class_g.wkappa_video] = my_static_model_OMSVM_g_multimodal(train_set7475_g,test_set7475_g,"video");
display("OMSVM: Audio-Visual features")
[predict_class_g.a_v,predict_class_g.UAR_a_v,predict_Posterior_g.a_v,predict_class_g.wkappa_a_v] = my_static_model_OMSVM_g_multimodal(train_set7475_g,test_set7475_g,"a_v");
%% DOMM_GT using three cues
% Yoou 
%display("Start Process DOMM...")
%[final_prediction_gt.audio,final_prediction_gt.UAR_audio,final_prediction_gt.wkappa_audio] = my_DOMM_GT_multimodal(train_set7475_g,test_set7475_g,predict_Posterior_g.audio,predict_class_g.audio,data_total);
%[final_prediction_gt.video,final_prediction_gt.UAR_video,final_prediction_gt.wkappa_video] = my_DOMM_GT_multimodal(train_set7475_g,test_set7475_g,predict_Posterior_g.video,predict_class_g.video,data_total);
%[final_prediction_gt.a_v,final_prediction_gt.UAR_a_v,final_prediction_gt.wkappa_a_v] = my_DOMM_GT_multimodal(train_set7475_g,test_set7475_g,predict_Posterior_g.a_v,predict_class_g.a_v,data_total);

%%
display("Start Process DOMM with 9 combinations...")
for cue1 = 1:3
    for cue2 = 1:3
    [final_prediction_ranksvm_g{cue1,cue2},DOMM_RS_UAR{cue1,cue2},DOMM_RS_wkappa{cue1,cue2}] = my_DOMM_RS_multimodal(train_set7475_g,test_set7475_g,predict_Posterior_g,data_total,pr_rank_g,cue1,cue2);
    end
end
%% You may want to save the variables in your local computer
%path = "E:\0UNSW_PhD\Code\Ordinal_FSMM\RECOLA_revised\pre_trained_matlab\DOMM_function\results2\";
%save(path+emotion+"Audio_"+audio_name+"_Video_"+video_name+sh1+"_"+sh2+".mat","predict_class_g","final_prediction_gt","final_prediction_ranksvm_g","DOMM_RS_UAR","DOMM_RS_wkappa","pr_rank_g");
end

