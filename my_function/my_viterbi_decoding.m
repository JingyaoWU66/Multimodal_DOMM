function [total,argmax,valmax] = my_viterbi_decoding(states,start_p,emit_p,rank,rater,data)
%Translated from Python code available at:
%  http://en.wikipedia.org/wiki/Viterbi_algorithm
   T = {};
   for state = 1:length(states)
       %%          prob.           V. path  V. prob.
       T{state} = {start_p(state),states(state),start_p(state)};
   end
   for output = 1:length(emit_p)-1
       U = {};
       delta = rank(output+1)-rank(output);
       trans_p = my_transition_each_delta(delta,rater,data);
       for next_state = 1:length(states)
           total = 0;
           argmax = [];
           valmax = 0;
           for source_state = 1:length(states)
               Ti = T{source_state};
               prob = Ti{1}; v_path = Ti{2}; v_prob = Ti{3};
               p = emit_p(source_state,output) * trans_p(source_state,next_state);
               prob = prob*p;
               v_prob = v_prob*p;
               total = total + prob;
               if v_prob > valmax
                   argmax = [v_path, states(next_state)];
                   valmax = v_prob;
               end
           end
           U{next_state} = {total,argmax,valmax};
       end
       T = U;
   end
   %% apply sum/max to the final states:
   total = 0;
   argmax = [];
   valmax = 0;
   for state = 1:length(states)
       Ti = T{state};
       prob = Ti{1}; v_path = Ti{2}; v_prob = Ti{3};
       total = total + prob;
       if v_prob > valmax
           argmax = v_path;
           valmax = v_prob;
       end
   end
end