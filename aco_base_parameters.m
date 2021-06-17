function param = aco_base_parameters
    %% Graph Parameters
    s = [1 1 1 2 2 3];
    t = [2 3 4 4 3 4];
    w = [2 3 5 1 5 1]; % edge weights
    names = {'n1', 'n2', 'n3', 'n4'};
    nodes = 1:1:4; %create nodes array
    idxFood = 4;
    startNode = 1;
    alpha = 1;
    beta = 1;
    
    %% General Parameters
    N_ants = 20; % total group of ants
    M_ants = 3; % number of ants in a group
    % initialize trail to small constant https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=484436
    trail = repmat(0.1, size(w));
    nij = 1./w; % inverse of edge weights
    Q = 1; % constant, see paper, can be tuned
  
    
    param.N_ants = N_ants;
    param.M_ants = M_ants;
    param.trail = trail;
    param.nij = nij;
    param.Q = Q;
    param.s = s;
    param.t = t;
    param.w = w;
    param.names = names;
    param.nodes = nodes;
    param.idxFood = idxFood;
    param.startNode = startNode;
    param.alpha = alpha;
    param.beta = beta;