
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

%% Graph4
graph4.s = [2 1 1 1 2 3 3 3 5 5 6 7];
graph4.t = [1 3 4 6 4 2 5 8 7 6 7 8];
graph4.w = [1 1 8 5 6 4 2 6 2 1 1 1]; % edge weights
graph4.names = {'n1', 'n2', 'n3', 'n4','n5', 'n6', 'n7', 'n8'};
graph4.nodes = 1:1:8; %create nodes array
graph4.idxFood = [4, 8];
graph4.startNode = 1;
%% Wheatstone
wheatstone1.s = [1 1 2 3];
wheatstone1.t = [2 3 4 4];
wheatstone1.w = [1 2 3 4];
wheatstone1.names = {'Start', 'n2', 'n3', 'Food'};
wheatstone1.nodes = 1:1:4; %create nodes array
wheatstone1.idxFood = 4;
wheatstone1.startNode = 1;

wheatstone2.s = [1 1 2 3];
wheatstone2.t = [2 3 4 4];
wheatstone2.w = [1 1 2 2];
wheatstone2.names = {'Start', 'n2', 'n3', 'Food'};
wheatstone2.nodes = 1:1:4; %create nodes array
wheatstone2.idxFood = 4;
wheatstone2.startNode = 1;

%%Modified Wheatstone
wheatstone_new.s = [1 3 2 2 3];
wheatstone_new.t = [2 1 4 3 4];
wheatstone_new.w = [2 1 1 1 3];
wheatstone_new.names = {'Start', 'n2', 'n3', 'Food'};
wheatstone_new.nodes = 1:1:4; %create nodes array
wheatstone_new.idxFood = 4;
wheatstone_new.startNode = 1;
%% 
if exist('graph_construction.mat', 'file')
    save('graph_construction.mat','-append')
else 
    save('graph_construction.mat')
end
