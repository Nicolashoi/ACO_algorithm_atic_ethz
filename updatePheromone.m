function Atrail = updatePheromone(Atrail, path, pathLength, mode)
    param = aco_base_parameters;
    delta = zeros(size(Atrail));
    
    switch mode
        case 'AS'
        % computes the sum of delta
            for k = 1:length(path) % number of ants in the group
                for i = 1:length(path{k})-1  
                    delta(path{k}(i), path{k}(i+1)) =  delta(path{k}(i), path{k}(i+1)) + ...
                                                       param.Q/pathLength(k);  
                    delta(path{k}(i+1), path{k}(i)) = delta(path{k}(i), path{k}(i+1));                              
                end
            end
        case 'MMAS'
            [~, idx_best]= min(pathLength);
             for i = 1:length(path{idx_best})-1  
                    delta(path{idx_best}(i), path{idx_best}(i+1)) =  delta(path{idx_best}(i), path{idx_best}(i+1)) + ...
                                                       param.Q/pathLength(idx_best);  
                    delta(path{idx_best}(i+1), path{idx_best}(i)) = delta(path{idx_best}(i), path{idx_best}(i+1));                              
             end
        otherwise
            warning("Unexpected argument given")
    end
    % update the trail matrix
    Atrail = (1-param.evap_rate) * Atrail + delta;
end