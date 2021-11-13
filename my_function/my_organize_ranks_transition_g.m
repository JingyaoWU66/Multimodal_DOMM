function [new_Tran,total_Tran,P] = my_organize_ranks_transition_g(abs_train,train_rank)
    for i = 1:length(abs_train)%9
        abs_label = abs_train{i};
        rank = train_rank{i};
        [Tran{i},k{i}] = my_count_transitions(abs_label,rank);
    end
      total_k = zeros(1,9);
      total_k = sum(cell2mat(k'));
    for transition = 1:9
        new_Tran{transition} = Tran{1}{transition};
        for utternace = 2:length(abs_train)
            new_Tran{transition} = cat(2,new_Tran{transition},Tran{utternace}{transition});
        end
    end
    for i =1:3
        total_Tran{i} = cat(2,new_Tran{(i-1)*3+1},new_Tran{(i-1)*3+2});
        total_Tran{i} = cat(2,total_Tran{i},new_Tran{i*3});
    end

    for i = 1:9
        if i <= 3
            P(i) = (total_k(i))/(length(total_Tran{1}));
        elseif i > 3 && i <= 6
            P(i) = (total_k(i))/(length(total_Tran{2}));
        else
            P(i) = (total_k(i))/(length(total_Tran{3}));
        end
    end
end

