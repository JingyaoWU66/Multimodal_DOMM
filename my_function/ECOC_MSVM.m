function [predict_class,predict_Posterior] = ECOC_MSVM(train_feataure,test_feature,traing_label,test_label)
t = templateSVM('Standardize',true);
Mdl = fitcecoc(train_feataure,traing_label,'Learners',t,'FitPosterior',true,...
    'ClassNames',{'1','2','3'},...
    'Verbose',2, 'Coding','ordinal');

%%
[predict_label,~,~,predict_Posterior] = predict(Mdl,test_feature);
predict_class = cell2mat(predict_label);
predict_class = str2num(predict_class);

cerror = 0;
for i = 1:length(predict_class)
    error(i) = abs(predict_class(i)-test_label(i));
    if(predict_class(i) ~=test_label(i))
        cerror = cerror+1;
    end
end



%ME = sum(error)/length(error) %mean error
%CC = corr(predict_class,test_label)
%cerror = cerror/length(predict_class) %misclassify rate
%matrix = crosstab(predict_class,test_label);


end

