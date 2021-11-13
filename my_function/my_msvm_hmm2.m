function [pred] = my_msvm_hmm2(rank,window,predict_Posterior,start_p,predict_class,test_label,rater,data)
    %rank = test_rank{4}(:,1);
   
    for i = 1:length(rank)-1
        delta(i) = rank(i,1) - rank(i+1,1);
    end
    emit_p = predict_Posterior(window,:)';
    states = {'1','2','3'};

    [total,argmax,valmax] = my_viterbi_decoding(states,start_p,emit_p,rank,rater,data);

    if length(argmax) == 0
        pred = 2*ones(1,length(rank)-1);
    else
        pred = zeros(1,length(argmax));
        for i = 1:length(argmax)
            pred(i) = str2num(argmax{i});
        end
    end
end

