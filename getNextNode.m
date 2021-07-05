function [nextNode] = getNextNode(currentNode,Gdist, Atrail, Anij, path)

    param = aco_base_parameters;
    allowedNodes = ismember(param.s,currentNode); %get Nodes where ant can move
    setOfNextNodes = param.t(allowedNodes);
    visitedNodesIdx = ismember(setOfNextNodes, path);
    setOfNextNodes(visitedNodesIdx) = [];
    if length(setOfNextNodes) ==1
        nextNode = setOfNextNodes;
    else
        % compute probability among possible nodes
        sum_p = sum((Atrail(currentNode, setOfNextNodes).^param.alpha).*...
                    (Anij(currentNode, setOfNextNodes).^param.beta));
        probSetOfNextNodes = zeros(length(setOfNextNodes),1);
        for j = 1:length(setOfNextNodes)
            probSetOfNextNodes(j) = (Atrail(currentNode,setOfNextNodes(j))^param.alpha *...
                                     Anij(currentNode, setOfNextNodes(j))^param.beta)/sum_p;  
        end
        nextNode = randsample(setOfNextNodes, 1, true, probSetOfNextNodes);  % pick next node based on computed probabilities
    end
 
end    