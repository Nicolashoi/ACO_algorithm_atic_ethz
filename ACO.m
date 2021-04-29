%% Implementation of the ACO Algorithm %%
% https://www.researchgate.net/publication/308953674_Ant_Colony_Optimization
% https://ieeexplore.ieee.org/document/484436?arnumber=484436

%% Parameters Definition
N = 1; % number of ants
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

%% Create Graphs
[G_dist, Adist] = initGraph(false,s, t, nij, names, true);
[G_trail, Atrail] = initGraph(false,s,t,trail, names, true);

%% Start ACO
% outter loop on number of ants
% inner loop while ant finds the food
% array to keep track of the path for each ant
currentNode = startNode;
nextNode = startNode;
setOfNextNodes = nodes; % initial
probSetOfNextNodes = zeros(size(nodes));
path = currentNode;

while true
    idxcurrentNode = find(currentNode == setOfNextNodes);
    setOfNextNodes(idxcurrentNode) = []; % remove current node from next possible nodes
    probSetOfNextNodes(idxcurrentNode) = [];
    % pick next node based on probabilities
    if length(setOfNextNodes) ==1
        nextNode = setOfNextNodes;
    else
        % compute probability among possible nodes
        sum_p = sum(Atrail(currentNode, setOfNextNodes).*Adist(currentNode, setOfNextNodes));
        for i = 1:length(setOfNextNodes)
            probSetOfNextNodes(i) = (Atrail(currentNode,setOfNextNodes(i))*...
                                     Adist(currentNode, setOfNextNodes(i)))/sum_p;  
        end
    nextNode = randsample(setOfNextNodes, 1, true, probSetOfNextNodes);  % choose path based on this probabilities 
    end
    
    if nextNode == idxFood % next node is food node
        path = [path nextNode];
        for k = 1:length(path)-1
            Atrail(path(k), path(k+1)) = Q/Adist(path(k), path(k+1));
            Atrail(path(k+1), path(k)) = Atrail(path(k), path(k+1)); % symmetric matrix
        end
        currentNode = nextNode;
    break
    end
    % store current node in an array to keep track of the path
    path = [path nextNode];
    currentNode = nextNode;
end
disp("path is = ")
disp(path)
disp("Pheromone level matrix = ");
disp(Atrail);
Aprob = probabilitiesMat(Atrail, Adist, nodes);
disp("Transition probability matrix is = ");
disp(Aprob)
G_prob = digraph(Aprob);
figure()
plot(G_prob,'EdgeLabel', G_prob.Edges.Weight)


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
 
