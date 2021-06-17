
function Aprob = probabilitiesMatrix(Atrail, Adist, nodes)
    next_nodes = nodes;
    Aprob = zeros(size(Atrail));
    for i = 1:length(nodes)
        % allowed next nodes (no self loops)
        idxCurrent = find(nodes(i) == next_nodes);
        next_nodes(idxCurrent) = []; % remove current node from list of nextnodes
        sumprob = sum(Atrail(nodes(i), next_nodes).*Adist(nodes(i), next_nodes));
        for j = next_nodes
            Aprob(nodes(i), j) = Atrail(nodes(i),j)*Adist(nodes(i),j)/sumprob;
        end

    end
end 
