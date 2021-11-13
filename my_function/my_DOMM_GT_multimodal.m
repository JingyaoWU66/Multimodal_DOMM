function [final_prediction,UAR,wkappa] = my_DOMM_GT_multimodal(train_set7475,test_set7475,predict_Posterior,predict_class,data)
    %addpath('E:\0UNSW2_UG\ThesisB\HMM_system\test_hmm_bad_label')
    rater = 1; %% global labels
    train_label = cell2mat(train_set7475.abs);
    test_label = cell2mat(test_set7475.abs);
    train_label2 = train_label;
    test_label2 = test_label;
    for u = 1:length(test_set7475.abs)
    countL = 0;countM = 0;countH = 0;
    countL = length(find(test_set7475.abs{u} == 1));
    countM = length(find(test_set7475.abs{u} == 2));
    countH = length(find(test_set7475.abs{u} == 3));
     start_p{u} = [countL countM countH]/length(test_set7475.abs{1});
    end
   % start_p = [1 1 1]/3;
%% HMM+MSVM+True rank
    w = length(test_set7475.abs{1});
    for i = 1:length(test_set7475.abs)
        window = [w*(i-1)+1:w*i];
        final_prediction{i} = my_msvm_hmm2(test_set7475.rank{i},window,predict_Posterior,start_p{i},predict_class,test_label2,rater,data);
    end

    good = cell2mat(final_prediction);
    new_test_label = test_label2;
    [recall,precision,UAR,wkappa] = recall_precision(new_test_label,good');


end

