function [predict_class,UAR,predict_Posterior,wkappa] = my_static_model_OMSVM_g_multimodal(train_set,test_set,modality)
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

%train_feature = cell2mat(train_set.feature);
%test_feature = cell2mat(test_set.feature);
train_label = cell2mat(train_set.abs);
    test_label = cell2mat(test_set.abs);
    [predict_class,predict_Posterior] = ECOC_MSVM(train_feature,test_feature,train_label,test_label);
    [~,~,UAR,wkappa] = recall_precision(test_label,predict_class);
end

