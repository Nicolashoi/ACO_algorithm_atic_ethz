%% Implementation of the ACO Algorithm %%
% https://www.researchgate.net/publication/308953674_Ant_Colony_Optimization
% https://ieeexplore.ieee.org/document/484436?arnumber=484436
clc
clear all
%% Parameters Definition
Nants = 20; % number of ants
Mants = 3;
s = [1 1 1 2 2 3];
t = [2 3 4 4 3 4];
w = [2 3 5 1 5 1];
w_prob = repmat(1/3,size(w));
% initialize trail to small constant https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=484436
trail = repmat(0.1,size(w));
names = {'n1', 'n2', 'n3', 'n4'};
nodes = 1:1:4; %create nodes array
nij = 1./w;
idxFood = 4;
startNode = 1;
Q = 1; % constant, see paper, can be tuned
pathTable = repmat({0}, Nants, Mants); % cell array to store all paths
global alpha beta
alpha = 1;
beta = 1;
plotfigure = true;
%% Create Graphs
global Adist Atrail Anij
[Gdist, Adist]= initGraph(false,s, t,w, names, plotfigure);
[~, Anij] = initGraph(false,s, t, nij, names, false);
[G_trail, Atrail] = initGraph(false,s,t,trail, names, plotfigure);

%% Start ACO
% outter loop on number of ants
% inner loop while ant finds the food
% array to keep track of the path for each ant
% try with a set of ants in the network i.e. 3 ants
% they update pheromone matrix once one of them has reached the end node
% instead of while true use increment of time i.e k. For each increment
% update the position of the ants. If one of the ants has reached final
% node, update the pheromone matrix for the other ants. Remove ant from
% system. So can send a number of package of ants in the terrain
% use cell array A = {[2 3 4], [1 2]}
% access them as A{2} = [1 2]
% and A{2}(1,1) = 1
disp("The shortest path in distance is supposed to be: ");
disp(shortestpath(Gdist,1,4));
for i=1:Nants
    
    currentNode = repmat({startNode},Mants,1);
    nextNode = repmat({startNode}, Mants,1);
    setOfNextNodes = repmat({nodes},Mants,1); % initial
    probSetOfNextNodes = repmat({zeros(size(nodes))}, Mants,1);
    path = repmat({startNode},Mants,1);
    pathLength = repmat({0}, Mants,1);
    finalNodeReached = false(Mants,1);
  
    while ~all(finalNodeReached)
        for j = 1:Mants
            if all(finalNodeReached)
                break;
            end
            [nextNode{j}, setOfNextNodes{j}, probSetOfNextNodes{j}] = getNextNode(currentNode{j},...
                                                                    setOfNextNodes{j}, probSetOfNextNodes{j});
            % store current node in an array to keep track of the path
            pathLength{j} = pathLength{j} + Adist(currentNode{j}, nextNode{j}); 
            path{j} = [path{j} nextNode{j}];
            currentNode{j} = nextNode{j};

            if nextNode{j} == idxFood % next node is food node (final state for the ant)
                pathTable{i,j} = path{j}; 
                for k = 1:length(path)-1 % update the trail matrix
                    Atrail(path{j}(k), path{j}(k+1)) = Atrail(path{j}(k), path{j}(k+1))+ Q/pathLength{j}; 
                    Atrail(path{j}(k+1), path{j}(k)) = Atrail(path{j}(k), path{j}(k+1)); % symmetric matrix
                end
                finalNodeReached(j) = true;
            end
        end
    end    
end
disp("Path  chosen by the last ant in the network is = ")
disp(path)
disp("Pheromone level matrix = ");
disp(Atrail);
Aprob = probabilitiesMat(Atrail, Anij, nodes);
disp("Transition probability matrix is = ");
disp(Aprob)
G_prob = digraph(Aprob);
figure()
plot(G_prob,'EdgeLabel', G_prob.Edges.Weight)

function [nextNode, setOfNextNodes, probSetOfNextNodes] = getNextNode(currentNode,...
                                                            setOfNextNodes, probSetOfNextNodes)
    global Atrail Anij alpha beta
    idxCurrentNode = find(currentNode == setOfNextNodes);
    setOfNextNodes(idxCurrentNode) = []; % remove current node from next possible nodes
    probSetOfNextNodes(idxCurrentNode) = [];
    % if only allowed move (no backward moves) is end node
    if length(setOfNextNodes) ==1
        nextNode = setOfNextNodes;
    else
        % compute probability among possible nodes
        sum_p = sum((Atrail(currentNode, setOfNextNodes).^alpha).*...
                    (Anij(currentNode, setOfNextNodes).^beta));
        for j = 1:length(setOfNextNodes)
            probSetOfNextNodes(j) = (Atrail(currentNode,setOfNextNodes(j))^alpha *...
                                     Anij(currentNode, setOfNextNodes(j))^beta)/sum_p;  
        end
        nextNode = randsample(setOfNextNodes, 1, true, probSetOfNextNodes);  % pick next node based on computed probabilities
    end
 
end    


function Aprob = probabilitiesMat(Atrail, Adist, nodes)
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

function [G, Adj] = initGraph(directed,s, t, w, names, plotGraph)
    if directed
        G = digraph(s,t,w,names);
    else
        G = graph(s,t,w,names);
    end
    Adj = full(adjacency(G, 'weighted'));
    if plotGraph
        figure()
        plot(G, 'EdgeLabel', G.Edges.Weight)
    end
end
 
