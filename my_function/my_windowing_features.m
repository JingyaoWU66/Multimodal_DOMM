function [ave_train_features,ave_test_features] = my_windowing_features(features,win,overlap)
%% ave features
    train_feature = features.train_features;
    test_feature = features.test_features;
    for i = 1:9
        k = 1;
        t = 1;
        while t <= length(train_feature{i})-win+1
            ave_train_features{i,1}(k,:) = mean(train_feature{i}(t:t+win-1,:));
            ave_test_features{i,1}(k,:) = mean(test_feature{i}(t:t+win-1,:));
            k = k + 1;
            t = t+overlap;
        end
    end
end