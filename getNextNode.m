function [nextNode, setOfNextNodes, probSetOfNextNodes] = getNextNode(currentNode,...
                                                            setOfNextNodes, probSetOfNextNodes)
    global Atrail Anij
    param = aco_base_parameters;
    idxCurrentNode = find(currentNode == setOfNextNodes);
    setOfNextNodes(idxCurrentNode) = []; % remove current node from next possible nodes
    probSetOfNextNodes(idxCurrentNode) = [];
    % if only allowed move (no backward moves) is end node
    if length(setOfNextNodes) ==1
        nextNode = setOfNextNodes;
    else
        % compute probability among possible nodes
        sum_p = sum((Atrail(currentNode, setOfNextNodes).^param.alpha).*...
                    (Anij(currentNode, setOfNextNodes).^param.beta));
        for j = 1:length(setOfNextNodes)
            probSetOfNextNodes(j) = (Atrail(currentNode,setOfNextNodes(j))^param.alpha *...
                                     Anij(currentNode, setOfNextNodes(j))^param.beta)/sum_p;  
        end
        nextNode = randsample(setOfNextNodes, 1, true, probSetOfNextNodes);  % pick next node based on computed probabilities
    end
 
end    