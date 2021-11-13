function Tran_p = my_transition_each_delta(delta,rater,data)

    new_Tran = data(rater).new_Tran;
    total_Tran = data(rater).total_Tran;
    P = data(rater).P;
    %data(6).P(1:3) = [0 0 0];
    %t = [-300:1:300];
%Tran_p = [0.75, 0.2, 0.05;0.1, 0.8, 0.1;0.05, 0.15, 0.8];

%% 这一段用ksdensity 算的probs, 还是这个最好
       for i = 1:3
        if length(new_Tran{i}) == 0
            A = 0;
        else
            [A,x]=ksdensity(new_Tran{i},delta);
           % [fi,xi]=ksdensity(new_Tran{i});
           % [N,center] = hist(new_Tran{i},t);
           % N = N/length(new_Tran{i}); 
           % ratio = max(fi)/max(N);
           % A = A/ratio;
        end
        
%         if length(total_Tran{1}) == 0
%             p_tran(i)= 1/3;
%          else
            % [B,x]=ksdensity(total_Tran{1},delta);
             p_tran(i) = A*P(i);
             %p_tran(i) = A;
       % end
       end
    sum1 = sum(p_tran(1:3));
    for i = 1:3
         if sum1 == 0
                Tran_p(1,i) = 1/3;
         else
            Tran_p(1,i) = p_tran(i)/sum1;
         end
    end
% if delta < 0 & Tran_p(1,1) < Tran_p(1,2)
%     Tran_p(1,1) = 1;
%     Tran_p(1,2) = 0;
%     Tran_p(1,3) = 0;
% end
    
    
    for i = 4:6
        if length(new_Tran{i}) == 0
            A = 0;
        else
           % [A,x]=ksdensity(new_Tran{i},delta);
             [A,x]=ksdensity(new_Tran{i},delta);
%             [N,center] = hist(new_Tran{i},t);
%             N = N/length(new_Tran{i}); 
%             ratio = max(A)/max(N);
%             A = A/ratio;
        end
        
%         if length(total_Tran{2}) == 0
%             p_tran(i) = 1/3;
%         else
           % [B,x]=ksdensity(total_Tran{2},delta);
            p_tran(i) = A*P(i);
            %p_tran(i) = A;
      %  end
        
    end
    sum2 = sum(p_tran(4:6));
    for i = 4:6
        Tran_p(2,i-3) = p_tran(i)/sum2;
    end

    for i = 7:9
        if length(new_Tran{i}) == 0
            A = 0;
             %[A,x]=ksdensity(-new_Tran{3},delta);
        else
           % [A,x]=ksdensity(new_Tran{i},delta);
             [A,x]=ksdensity(new_Tran{i},delta);
%             [N,center] = hist(new_Tran{i},t);
%             N = N/length(new_Tran{i}); 
%             ratio = max(A)/max(N);
%             A = A/ratio;
        end
        
%         if length(total_Tran{3} == 0)
%             p_tran(i) = 1/3;
%         else
           % [B,x]=ksdensity(total_Tran{3},delta);
            p_tran(i) = A*P(i);
            %p_tran(i) = A;
       % end
    end
    sum3 = sum(p_tran(7:9));
    for i = 7:9
        Tran_p(3,i-6) = p_tran(i)/sum3;
    end
    
%     if delta <= -300
%         Tran_p = zeros(3,3);
%         Tran_p(:,1) = 1;
%     end
%     for i = 1:3
%         if length(new_Tran{i}) == 0
%             A = 0;
%         else
%             [A,x]=ksdensity(new_Tran{i},delta);
%         end
%         
%         if length(total_Tran{1}) == 0
%             p_tran(i)= 1/3;
%         else
%             [B,x]=ksdensity(total_Tran{1},delta);
%             p_tran(i) = A*P(i)/B;
%         end
%        
%         Tran_p(1,i) = p_tran(i);
%     end
% 
%     for i = 4:6
%         if length(new_Tran{i}) == 0
%             A = 0;
%         else
%             [A,x]=ksdensity(new_Tran{i},delta);
%         end
%         
%         if length(total_Tran{2}) == 0
%             p_tran(i) = 1/3;
%         else
%             [B,x]=ksdensity(total_Tran{2},delta);
%             p_tran(i) = A*P(i)/B;
%         end
%         Tran_p(2,i-3) = p_tran(i);
%     end
%     for i = 7:9
%         if length(new_Tran{i}) == 0
%             A = 0;
%         else
%             [A,x]=ksdensity(new_Tran{i},delta);
%         end
%         
%         if length(total_Tran{3} == 0)
%             p_tran(i) = 1/3;
%         else
%             [B,x]=ksdensity(total_Tran{3},delta);
%             p_tran(i) = A*P(i)/B;
%         end
%         Tran_p(3,i-6) = p_tran(i);
%     end
%  
%% 这里用gaussian算的probs

%{
    for i = 1:3
        gm1 =fitgmdist(new_Tran{i}',1);
        A = pdf(gm1,delta);
        gm2 =fitgmdist(total_Tran{1}',1);
        B = pdf(gm2,delta);
        p_tran(i) = A*P(i)/B;
        Tran_p(1,i) = p_tran(i);
    end

    for i = 4:6
        gm1 =fitgmdist(new_Tran{i}',1);
        A = pdf(gm1,delta);
        gm2 =fitgmdist(total_Tran{2}',1);
        B = pdf(gm2,delta);
         p_tran(i) = A*P(i)/B;
        Tran_p(2,i-3) = p_tran(i);
    end
    for i = 7:9
        gm1 =fitgmdist(new_Tran{i}',1);
        A = pdf(gm1,delta);
        gm2 =fitgmdist(total_Tran{3}',1);
        B = pdf(gm2,delta);
        p_tran(i) = A*P(i)/B;
        Tran_p(3,i-6) = p_tran(i);
    end
%}
    
%% 这里fit了一个normal distribution
%{
    for i = 1:3
        pd1 = fitdist(new_Tran{i}','Normal');
        A = pdf(pd1,delta);
        pd2 =fitdist(total_Tran{1}','Normal');
        B = pdf(pd2,delta);
        p_tran(i) = A*P(i)/B;
        Tran_p(1,i) = p_tran(i);
    end

    for i = 4:6
        pd1 = fitdist(new_Tran{i}','Normal');
        A = pdf(pd1,delta);
        pd2 =fitdist(total_Tran{2}','Normal');
        B = pdf(pd2,delta);
        p_tran(i) = A*P(i)/B;
        Tran_p(2,i-3) = p_tran(i);
    end
    for i = 7:9
        pd1 = fitdist(new_Tran{i}','Normal');
        A = pdf(pd1,delta);
        pd2 =fitdist(total_Tran{3}','Normal');
        B = pdf(pd2,delta);
        p_tran(i) = A*P(i)/B;
        Tran_p(3,i-6) = p_tran(i);
    end
%}
%     
%         for i = 1:3
%             p_tran(i) = probability2(delta,f{i},f_set{1},P(i),xi{i},xi_set{1});
%             Tran_p(1,i) = p_tran(i);
%         end
%         for i = 4:6
%             p_tran(i) =  probability2(delta,f{i},f_set{2},P(i),xi{i},xi_set{2});
%             Tran_p(2,i-3) = p_tran(i);
%         end
%         for i = 7:9
%             p_tran(i) = probability2(delta,f{i},f_set{3},P(i),xi{i},xi_set{3});
%             Tran_p(3,i-6) = p_tran(i);
%         end

end

