function [G, Adj] = initGraph(type, plotGraph,A)
    param = aco_base_parameters;
    highlight_path = false;
    switch type
        case 'dist'
            G = digraph(param.s,param.t,param.w,param.names);
            str_title = "Graph of distances";
        case 'inverse_dist'
            G = graph(param.s,param.t,param.nij,param.names);
            str_title = "Graph of inverse distances";
        case 'pheromone'
            G = graph(param.s,param.t,param.trail,param.names);
            str_title = "Level of pheromone";
        case 'probabilities'
            G = digraph(A);
            str_title = "Graph with probabilities on the edges";
            highlight_path = true;
            Ashortest = ones(size(A))-A;
            Gshortest = digraph(Ashortest);
            path = shortestpath(Gshortest,param.startNode, param.idxFood);
        otherwise
            warning("Unexpected argument given")
    end
    Adj = full(adjacency(G, 'weighted'));
    if plotGraph
        figure()
        P = plot(G, 'EdgeLabel', G.Edges.Weight);
        highlight(P,param.startNode,'NodeColor',"g", 'Markersize',7) %to highlight the start node
        highlight(P,param.idxFood,'NodeColor',"r",'Markersize',7) %to highlight the end node
        title(str_title);
        if highlight_path
           highlight(P,path,'EdgeColor','m','Linewidth',1.5);
           % To do highlight path, most probable path ?
           % Jordan decomposition [V,J] = jordan(A)
           % Ainf = V*Jinf*V'
           % xinf = Ainf' * x0
           % find max xinf ?
        end
        
    end
end