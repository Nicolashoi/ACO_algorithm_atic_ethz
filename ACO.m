function [Aprob, Atrail, Atrail_cycles, Aprob_cycles] = ACO(plotfigure)
    %% Implementation of the ACO Algorithm %%
    % https://www.researchgate.net/publication/308953674_Ant_Colony_Optimization
    % https://ieeexplore.ieee.org/document/484436?arnumber=484436
%     clc
%     clear
%     close all
    %% Parameters Definition
    param = aco_base_parameters;
    pathTable = repmat({0}, param.Ncycles, param.M_ants); % cell array to store all paths
    if nargin < 1
        plotfigure = true;
    end
% plotfigure = true
    %% Create Graphs
    %global Adist Anij
    [Gdist, Adist]= initGraph('dist', plotfigure);
    [~, Anij] = initGraph('inverse_dist',false);
    [G_trail, Atrail] = initGraph('pheromone_begin',false);
    %Trail_update = zeros(size(Atrail));
    %% Start ACO
    % outter loop on group of ants
    % inner loop on ants in the current group
    % A new group is sent into the network once all ants of the previous group
    % have found the food node
    disp("The shortest path in distance to node 4 is supposed to be: ");
    disp(shortestpath(Gdist,1,4));
    Atrail_cycles = zeros(length(param.nodes), length(param.nodes),param.Ncycles+1);
    Aprob_cycles = zeros(length(param.nodes), length(param.nodes),param.Ncycles+1);
    Aprob_cycles(:,:,1) = probabilitiesMatrix(Atrail, Anij, Gdist);
    Atrail_cycles(:,:,1) = Atrail;
    for i=1:param.Ncycles

        currentNode = repmat({param.startNode},param.M_ants,1);
        nextNode = repmat({param.startNode}, param.M_ants,1);
        %nodesFromStart = nearest(Gdist, param.startNode, Inf, 'Method', 'unweighted'); %% do this at each node ?
         %setOfNextNodes = repmat({nodesFromStart},param.M_ants,1); % initial
        %probSetOfNextNodes = repmat({zeros(size(nodesFromStart))}, param.M_ants,1);
        path = repmat({param.startNode},param.M_ants,1);
        pathLength = zeros(param.M_ants,1);%repmat(0, param.M_ants,1);
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
        Atrail = updatePheromone(Atrail, path, pathLength, 'AS');
        Atrail_cycles(:,:,i+1) = Atrail;
        Aprob_cycles(:,:,i+1) = probabilitiesMatrix(Atrail, Anij, Gdist);
    end
%     disp("Pheromone level matrix = ");
%     disp(Atrail);
    Aprob = probabilitiesMatrix(Atrail, Anij, Gdist);
    assignin('base','pathTable',pathTable);
%     disp("Transition probability matrix is = ");
%     disp(Aprob)
%     initGraph('pheromone_end',plotfigure, Atrail);
%     initGraph('probabilities', plotfigure, Aprob);

%     path1 = zeros(size(pathTable,1),1);
%     path2 = zeros(size(pathTable,1),1);
%     for i=1:size(pathTable,1)
%         pathMat = cell2mat(pathTable(i,:)');
%         [uniquePath, ~, x] = unique(pathMat,'rows');
%         occurence = histc(x, 1:size(uniquePath,1));
%         group(i).paths = uniquePath;
%         group(i).path_occurence = occurence;
%         if length(occurence) == 1 && isequal(uniquePath,[1 2 4])
%             path1(i) = occurence;
%         elseif length(occurence) == 1 && isequal(uniquePath,[1 3 4])
%              path2(i) = occurence;
%         else
%         path1(i) = occurence(1);
%         path2(i) = occurence(2);
%         end
%     end
%     data = [path1 path2];
%     % bar(path1,'r')
%     % hold on
%     % bar(path2,'y')
%     % hold off
%     figure()
%     b = bar(data, 'FaceColor', 'flat');
%     b(1).CData = [0 0.4470 0.7410];
%     b(2).CData = [1 1 0];
%     legend('Path [1 2 4]', 'Path [1 3 4]')
%     ylim([0 101.5])
%     xlabel('Cycles')
%     ylabel('Ants number per path')
%     grid on
%     set(gca,'FontWeight','bold','FontSize',18)
%     title('Number of ants in each path of the Wheatstone bridge')
end
