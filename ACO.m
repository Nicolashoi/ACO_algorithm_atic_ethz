%% Implementation of the ACO Algorithm %%
% https://www.researchgate.net/publication/308953674_Ant_Colony_Optimization
% https://ieeexplore.ieee.org/document/484436?arnumber=484436
clc
clear
%% Parameters Definition
param = aco_base_parameters;
pathTable = repmat({0}, param.N_ants, param.M_ants); % cell array to store all paths
plotfigure = true;
%% Create Graphs
global Adist Atrail Anij
[Gdist, Adist]= initGraph(false,plotfigure,"Graph of distances");
[~, Anij] = initGraph(false,~plotfigure);
[G_trail, Atrail] = initGraph(false,plotfigure,...
                              "Graph representing pheromone levels on the edges");

%% Start ACO
% outter loop on group of ants
% inner loop on ants in the current group
% A new group is sent into the network once all ants of the previous group
% have found the food node
disp("The shortest path in distance is supposed to be: ");
disp(shortestpath(Gdist,1,4));
for i=1:param.N_ants
    
    currentNode = repmat({param.startNode},param.M_ants,1);
    nextNode = repmat({param.startNode}, param.M_ants,1);
    setOfNextNodes = repmat({param.nodes},param.M_ants,1); % initial
    probSetOfNextNodes = repmat({zeros(size(param.nodes))}, param.M_ants,1);
    path = repmat({param.startNode},param.M_ants,1);
    pathLength = repmat({0}, param.M_ants,1);
    finalNodeReached = false(param.M_ants,1);
  
    while ~all(finalNodeReached)
        for j = 1:param.M_ants
            if finalNodeReached(j) 
                continue
            end
            [nextNode{j}, setOfNextNodes{j}, probSetOfNextNodes{j}] = getNextNode(currentNode{j},...
                                                                    setOfNextNodes{j}, probSetOfNextNodes{j});
            % store current node in an array to keep track of the path
            pathLength{j} = pathLength{j} + Adist(currentNode{j}, nextNode{j}); 
            path{j} = [path{j} nextNode{j}];
            currentNode{j} = nextNode{j};

            if nextNode{j} == param.idxFood % next node is food node (final state for the ant)
                pathTable{i,j} = path{j}; 
                for k = 1:length(path{j})-1 % update the trail matrix
                    Atrail(path{j}(k), path{j}(k+1)) = Atrail(path{j}(k), path{j}(k+1))+ param.Q/pathLength{j}; 
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
Aprob = probabilitiesMatrix(Atrail, Anij, param.nodes);
disp("Transition probability matrix is = ");
disp(Aprob)
G_prob = digraph(Aprob);
figure()
plot(G_prob,'EdgeLabel', G_prob.Edges.Weight)
title("Graph with probabilities on the edges");

 
