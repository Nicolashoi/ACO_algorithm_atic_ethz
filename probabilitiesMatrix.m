
function Aprob = probabilitiesMatrix(Atrail, Adist, Gdist)
    %next_nodes = nearest(Gdist, currentNode, Inf, 'Method', 'unweighted');
    param = aco_base_parameters;
    %next_nodes = nodes;
    Aprob = zeros(size(Atrail));
    for i = 1:length(param.nodes) % should iterate in the order of the nodes how to infer that 4->5 and not 5-> 4
        % allowed next nodes (no self loops)
        %idxCurrent = find(nodes(i) == next_nodes);
        %next_nodes(idxCurrent) = []; % remove current node from list of nextnodes
        next_nodes = nearest(Gdist,param.nodes(i), Inf, 'Method', 'unweighted');
        sumprob = sum(Atrail(param.nodes(i), next_nodes).*Adist(param.nodes(i), next_nodes));
        for j = 1:length(next_nodes)
            Aprob(param.nodes(i), next_nodes(j)) = Atrail(param.nodes(i),next_nodes(j))^param.alpha...
                                                  *Adist(param.nodes(i),next_nodes(j))^param.beta/sumprob;
        end

    end
end 
