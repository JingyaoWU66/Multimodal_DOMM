function [train_set7475,test_set7475] = my_num2ord(labels,win,overlap,sh1,sh2)
% %% ave features
%     train_feature = features.train;
%     test_feature = features.test;
%     for i = 1:9
%         k = 1;
%         t = 1;
%         while t <= length(train_feature{i})-win+1
%             ave_train_features{i,1}(k,:) = mean(train_feature{i}(t:t+win-1,:));
%             ave_test_features{i,1}(k,:) = mean(test_feature{i}(t:t+win-1,:));
%             k = k + 1;
%             t = t+overlap;
%         end
%     end
%% abs Training
    for i = 1:9
        for R = 2:7
          [train_absolute{i,1}{R-1},ave_train{i,1}{R-1}] = my_num2abs(labels.train{i}(:,R),win,sh1,sh2,overlap);
          [test_absolute{i,1}{R-1},ave_test{i,1}{R-1}] = my_num2abs(labels.test{i}(:,R),win,sh1,sh2,overlap);
        end
    end
    for i = 1:9
        for R = 1:6
            abs_train{i}(:,R) = train_absolute{i,1}{R};
            ave_rater_train{i}(:,R) = ave_train{i}{R};
            abs_test{i}(:,R) = test_absolute{i,1}{R};
            ave_rater_test{i}(:,R) = ave_test{i}{R};
        end
    end
    %% rank training
    for i = 1:9
        for rater = 1:6
            [~,rank_train{i}(:,rater)] = sort(ave_train{i}{rater});
            [~,rank_train{i}(:,rater)] = sort(rank_train{i}(:,rater));
        end
    end
    %% rank testing
    for i = 1:9
        for rater = 1:6
            [~,rank_test{i}(:,rater)] = sort(ave_test{i}{rater});
            [~,rank_test{i}(:,rater)] = sort(rank_test{i}(:,rater));
        end
    end

    train_set7475.abs = abs_train';
    train_set7475.rank = rank_train';
    train_set7475.meanlabel = ave_rater_train';
    %train_set7475.feature = AVEC2016_train_Audio;
   % train_set7475.feature = ave_train_features;

    test_set7475.abs = abs_test';
    test_set7475.rank = rank_test';
    test_set7475.meanlabel = ave_rater_test';
    %test_set7475.feature = AVEC2016_dev_Audio;
    %test_set7475.feature = ave_test_features;
end

