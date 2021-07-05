function [Aprob, Atrail, Atrail_cycles, Aprob_cycles] = ACO(plotfigure, algorithm)
    %% Implementation of the ACO Algorithm %%
    % https://www.researchgate.net/publication/308953674_Ant_Colony_Optimization
    % https://ieeexplore.ieee.org/document/484436?arnumber=484436
    %% Parameters Definition
    param = aco_base_parameters;
    pathTable = repmat({0}, param.Ncycles, param.M_ants); % cell array to store all paths
    if nargin < 1
        plotfigure = true;
    end

    %% Create Graphs
    [Gdist, Adist]= initGraph('dist', plotfigure);
    [~, Anij] = initGraph('inverse_dist',false);
    [~, Atrail] = initGraph('pheromone_begin',false);
  
    %% Start ACO
    % outter loop on group of ants
    % inner loop on ants in the current group
    % A new group is sent into the network once all ants of the previous group
    % have found the food node
%     disp("The shortest path in distance to node 4 is supposed to be: ");
%     disp(shortestpath(Gdist,1,4));
    Atrail_cycles = zeros(length(param.nodes), length(param.nodes),param.Ncycles+1);
    Aprob_cycles = zeros(length(param.nodes), length(param.nodes),param.Ncycles+1);
    Aprob_cycles(:,:,1) = probabilitiesMatrix(Atrail, Anij, Gdist);
    Atrail_cycles(:,:,1) = Atrail;
    for i=1:param.Ncycles

        currentNode = repmat({param.startNode},param.M_ants,1);
        nextNode = repmat({param.startNode}, param.M_ants,1);
        path = repmat({param.startNode},param.M_ants,1);
        pathLength = zeros(param.M_ants,1);
        finalNodeReached = false(param.M_ants,1);

        while ~all(finalNodeReached)
            for j = 1:param.M_ants
                if finalNodeReached(j) 
                    continue
                end
                nextNode{j} = getNextNode(currentNode{j}, Gdist, Atrail, Anij, path{j});                                                        
                % store current node in an array to keep track of the path
                pathLength(j) = pathLength(j) + Adist(currentNode{j}, nextNode{j}); 
                path{j} = [path{j} nextNode{j}];
                currentNode{j} = nextNode{j};

                if any(nextNode{j} == param.idxFood) % next node is food node (final state for the ant)
                    pathTable{i,j} = path{j}; 
                    finalNodeReached(j) = true;
                end
            end
        end
        Atrail = updatePheromone(Atrail, path, pathLength, algorithm);
        Atrail_cycles(:,:,i+1) = Atrail;
        Aprob_cycles(:,:,i+1) = probabilitiesMatrix(Atrail, Anij, Gdist);
    end
    Aprob = probabilitiesMatrix(Atrail, Anij, Gdist);
    assignin('base','pathTable',pathTable);
end
