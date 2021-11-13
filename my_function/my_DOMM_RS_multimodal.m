function [final_prediction_rankSVM,UAR,wkappa] =  my_DOMM_RS_multimodal(train_set7475,test_set7475,predict_Posterior,data,pr_rank,cue1,cue2)
   if cue1 == 1
       posterior = predict_Posterior.audio;
   elseif cue1 == 2
       posterior = predict_Posterior.video;
   else
       posterior = predict_Posterior.a_v;
   end   

if cue2 == 1
       rank = pr_rank.audio;
   elseif cue2 == 2
       rank = pr_rank.video;
   else
       rank = pr_rank.a_v;
   end
%%
% calculate start_p for each utterance   
train_label = cell2mat(train_set7475.abs);
    test_label = cell2mat(test_set7475.abs);
     w = length(train_set7475.abs{1});
     rater = 1;
%% HMM+MSVM+Ranksvm

        train_label2 = train_label;
    test_label2 = test_label;
        for u = 1:length(test_set7475.abs)
    countL = 0;countM = 0;countH = 0;
    countL = length(find(train_set7475.abs{u} == 1));
    countM = length(find(train_set7475.abs{u} == 2));
    countH = length(find(train_set7475.abs{u} == 3));
     start_p{u} = [countL countM countH]/length(train_set7475.abs{1});
        end
    
    for i = 1:9
        window = [w*(i-1)+1:w*i];
        final_prediction_rankSVM{i} = my_msvm_hmm_revised(rank{i},window,posterior,start_p{i},rater,data);
    end

    good2 = cell2mat(final_prediction_rankSVM);

    new_test_label = test_label2;
    [recall3,precision3,UAR,wkappa] = recall_precision(new_test_label,good2');

end

