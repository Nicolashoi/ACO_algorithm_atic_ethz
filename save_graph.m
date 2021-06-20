
%% To save graph parameters
clear
%% graph1
 graph1.s = [1 1 1 2 2 3];
 graph1.t = [2 3 4 4 3 4];
 graph1.w = [2 3 5 1 5 1]; % edge weights
 graph1.names = {'n1', 'n2', 'n3', 'n4'};
 graph1.nodes = 1:1:4; %create nodes array
 graph1.idxFood = 4;
 graph1.startNode = 1;

%% graph2
 graph2.s = [1 1 1 1 2 2 3 5];
 graph2.t = [2 3 4 5 4 3 4 4];
 graph2.w = [2 1 5 4 1 5 1 2]; % edge weights
 graph2.names = {'n1', 'n2', 'n3', 'n4','n5'};
 graph2.nodes = 1:1:5; %create nodes array
 graph2.idxFood = 4;
 graph2.startNode = 1;

%% Graph3
graph3.s = [1 1 1 1 2 2 3 3 5 5 6 6 7];
graph3.t = [2 3 4 5 4 3 4 7 4 6 8 7 8];
graph3.w = [2 1 5 1 1 5 1 4 2 3 2 1 5]; % edge weights
graph3.names = {'n1', 'n2', 'n3', 'n4','n5', 'n6', 'n7', 'n8'};
graph3.nodes = 1:1:8; %create nodes array
graph3.idxFood = [4, 8];
graph3.startNode = 1;

%% 
if exist('graph_construction.mat', 'file')
    save('graph_construction.mat','-append')
else 
    save('graph_construction.mat')
end
