function [pr_rank,P] = my_dynamic_RankSVM_g_multimodal(train_set,test_set,modality)
if modality == "audio"
    train_feature = cell2mat(train_set.audio);
    test_feature = cell2mat(test_set.audio);
elseif modality == "video"
    train_feature = cell2mat(train_set.video);
    test_feature = cell2mat(test_set.video);
else
    train_feature = cell2mat(train_set.a_v);
    test_feature = cell2mat(test_set.a_v);
end
    
    XXall(1).X = train_feature;
    for i = 1:length(train_set.rank)
        YYall(1).Y{i} = train_set.rank{i}(:,1);
    end

    for i = 1:length(test_set.audio)
        if modality == "audio"
            XXall(i).Xt = test_set.audio{i};
        elseif modality == "video"
            XXall(i).Xt = test_set.video{i};
        else
            XXall(i).Xt = test_set.a_v{i};
        end
        temp{1} = test_set.rank{i}(:,1);
        YYall(i).Yt = temp;
    end
%%
    [w,rank] = test_ranksvm2(XXall, YYall);

    for i = 1:length(test_set.rank)
        pred_rank{i} = XXall(i).Xt*w;
        [~,pr_rank{i}] = sort(pred_rank{i});
        [~,pr_rank{i}] = sort(pr_rank{i});
    end
    for i =1:length(test_set.rank)
        [P.P_at_k_top,P.P_at_k_bottom,P.P_at_k{i},P.tau(i),P.p] = RankSVM_performance(pr_rank{i},YYall,i);
    end

end

