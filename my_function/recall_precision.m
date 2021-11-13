function [recall,precision,UAR,wkappa] = recall_precision(test_label,pred)
    matrix2 = confusionmat(test_label,pred(1:length(test_label))');
   [~,wkappa] = kappa(matrix2,1);
    accuracy2 = sum(diag(matrix2))/sum(sum(matrix2));

    for i = 1:3
        recall(i) = matrix2(i,i)/sum(matrix2(i,:));
    end
    UAR = mean(recall);

    for i = 1:3
        precision(i) = matrix2(i,i)/sum(matrix2(:,i));
    end
    UWP = mean(precision);
end

