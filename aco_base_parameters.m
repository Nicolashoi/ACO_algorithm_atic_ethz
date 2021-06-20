function param = aco_base_parameters
    %% Graph Parameters
    load('graph_construction')
    g = graph3; % change which graph to use here
%     s = [1 1 1 1 2 2 3 3 5 5 6 6 7];
%     t = [2 3 4 5 4 3 4 7 4 6 8 7 8];
%     w = [2 1 5 1 1 5 1 4 2 3 2 1 5]; % edge weights
%     names = {'n1', 'n2', 'n3', 'n4','n5', 'n6', 'n7', 'n8'};
%     nodes = 1:1:8; %create nodes array
%     idxFood = [4, 8];
%     startNode = 1;
    alpha = 1;
    beta = 1;
    
    %% General Parameters
    N_ants = 20; % total group of ants
    M_ants = 50; % number of ants in a group
    % initialize trail to small constant https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=484436
    trail = repmat(0.1, size(g.w));
    nij = 1./g.w; % inverse of edge weights
    Q = 1; % constant, see paper, can be tuned
    evap_rate = 0.1;
    
    param.N_ants = N_ants;
    param.M_ants = M_ants;
    param.trail = trail;
    param.nij = nij;
    param.Q = Q;
    param.s = g.s;
    param.t = g.t;
    param.w = g.w;
    param.names = g.names;
    param.nodes = g.nodes;
    param.idxFood = g.idxFood;
    param.startNode = g.startNode;
    param.alpha = alpha;
    param.beta = beta;
    param.evap_rate = evap_rate;