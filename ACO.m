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
[Gdist, Adist]= initGraph('dist', plotfigure);
[~, Anij] = initGraph('inverse_dist',~plotfigure);
[G_trail, Atrail] = initGraph('pheromone',plotfigure);
Trail_update = zeros(size(Atrail));
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
    nodesFromStart = nearest(Gdist, param.startNode, Inf, 'Method', 'unweighted'); %% do this at each node ?
    setOfNextNodes = repmat({nodesFromStart},param.M_ants,1); % initial
    probSetOfNextNodes = repmat({zeros(size(nodesFromStart))}, param.M_ants,1);
    path = repmat({param.startNode},param.M_ants,1);
    pathLength = zeros(param.M_ants,1);%repmat(0, param.M_ants,1);
    finalNodeReached = false(param.M_ants,1);
  
    while ~all(finalNodeReached)
        for j = 1:param.M_ants
            if finalNodeReached(j) 
                continue
            end
            nextNode{j} = getNextNode(currentNode{j}, Gdist, Atrail, Anij);                                                        
            % store current node in an array to keep track of the path
            pathLength(j) = pathLength(j) + Adist(currentNode{j}, nextNode{j}); 
            path{j} = [path{j} nextNode{j}];
            currentNode{j} = nextNode{j};

            if nextNode{j} == param.idxFood % next node is food node (final state for the ant)
                pathTable{i,j} = path{j}; 
                finalNodeReached(j) = true;
            end
        end
    end
    Atrail = updatePheromone(Atrail, path, pathLength, 'AS');
end
disp("Path  chosen by the last ant in the network is = ")
disp(path)
disp("Pheromone level matrix = ");
disp(Atrail);
Aprob = probabilitiesMatrix(Atrail, Anij, Gdist);
disp("Transition probability matrix is = ");
disp(Aprob)
initGraph('probabilities', plotfigure, Aprob);

 
