function [G, Adj] = initGraph(type, plotGraph, A)
    param = aco_base_parameters;
    highlight_path = false;
    %condensation_graph = false;
    switch type
        case 'dist'
            G = digraph(param.s,param.t,param.w,param.names);
            str_title = "Graph of distances";
            %condensation_graph = true;
            %bins = conncomp(G);
        case 'inverse_dist'
            G = graph(param.s,param.t,param.nij,param.names);
            str_title = "Graph of inverse distances";
        case 'pheromone_begin'
            G = graph(param.s,param.t,param.trail,param.names);
            str_title = "Starting level of pheromone";
        case 'pheromone_end'
            G = graph(A);
            str_title = "End level of pheromone";
        case 'probabilities'
            G = digraph(A);
            str_title = "Graph with probabilities on the edges";
            highlight_path = true;
%             Ashortest = ones(size(A))-A;
%             Gshortest = digraph(Ashortest);
%             path = shortestpath(Gshortest,param.startNode, param.idxFood);
%             [V,J] = jordan(A);
%             Ainf = V*J*V';
            idx_node = param.startNode;
            path = param.startNode;
            while ~any(idx_node== param.idxFood)
                x0 = zeros(size(A,1),1);
                x0(idx_node) = 1;
                xinf = A'*x0;
                [~, idx_node] = max(xinf);
                path = [path idx_node];
            end
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
        end     
    end
end