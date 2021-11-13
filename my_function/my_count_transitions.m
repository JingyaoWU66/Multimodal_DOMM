function [Tran,k] = my_count_transitions(abs_label,rank)
    k1 = 1;k2 = 1;k3 = 1;
    k4 = 1;k5 = 1;k6 = 1;
    k7 = 1;k8 = 1;k9 = 1;
    Tran = cell(1,9);
    for i = 1:length(abs_label)-1
        delta_r(i) = rank(i+1) - rank(i);
        if abs_label(i) == 1 && abs_label(i+1) == 1
            LL(k1) = rank(i+1) - rank(i);
            Tran{1}(k1) = delta_r(i);
            k1 = k1 + 1;
        elseif abs_label(i) == 1 && abs_label(i+1) == 2
            LM(k2) = rank(i+1) - rank(i);
            Tran{2}(k2) = delta_r(i);
            k2 = k2 + 1;
        elseif abs_label(i) == 1 && abs_label(i+1) == 3
            LH(k3) = rank(i+1) - rank(i);
            Tran{3}(k3) = delta_r(i);
            k3 = k3 + 1;
        end

        if abs_label(i) == 2 && abs_label(i+1) == 1
            ML(k4) = rank(i+1) - rank(i);
            Tran{4}(k4) = delta_r(i);
            k4 = k4 + 1;
        elseif abs_label(i) == 2 && abs_label(i+1) == 2
            MM(k5) = rank(i+1) - rank(i);
            Tran{5}(k5) = delta_r(i);
            k5 = k5 + 1;
        elseif abs_label(i) == 2 && abs_label(i+1) == 3
            MH(k6) = rank(i+1) - rank(i);
            Tran{6}(k6) = delta_r(i);
            k6 = k6 + 1;
        end

       if abs_label(i) == 3 && abs_label(i+1) == 1
            HL(k7) = rank(i+1) - rank(i);
            Tran{7}(k7) = delta_r(i);
            k7 = k7 + 1;
        elseif abs_label(i) == 3 && abs_label(i+1) == 2
            HM(k8) = rank(i+1) - rank(i);
            Tran{8}(k8) = delta_r(i);
            k8 = k8 + 1;
        elseif abs_label(i) == 3 && abs_label(i+1) == 3
            HH(k6) = rank(i+1) - rank(i);
            Tran{9}(k9) = delta_r(i);
            k9 = k9 + 1;
        end
    end
    k(1) = k1;k(2) = k2;k(3) = k3;k(4) = k4;k(5) = k5;
    k(6) = k6;k(7) = k7;k(8) = k8;k(9) = k9;
end

