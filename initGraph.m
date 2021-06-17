function [G, Adj] = initGraph(directed, plotGraph, str_title)
    param = aco_base_parameters;
    if directed
        G = digraph(param.s,param.t,param.w,param.names);
    else
        G = graph(param.s,param.t,param.w,param.names);
    end
    Adj = full(adjacency(G, 'weighted'));
    if plotGraph
        figure()
        P = plot(G, 'EdgeLabel', G.Edges.Weight)
        highlight(P,param.startNode,'NodeColor',"g", 'Markersize',7) %to highlight the start node
        highlight(P,param.idxFood,'NodeColor',"r",'Markersize',7) %to highlight the end node
        title(str_title);
    end
end