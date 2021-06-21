function param = aco_base_parameters
    %% Graph Parameters
    load('graph_construction')
    g = wheatstone2; % change which graph to use here
    alpha = 1;
    beta = 1;
    
    %% General Parameters
    N_ants = 30; % total group of ants
    M_ants = 10; % number of ants in a group
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