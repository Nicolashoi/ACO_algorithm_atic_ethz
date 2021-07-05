
function Aprob = probabilitiesMatrix(Atrail, Anij, Gdist)
    %next_nodes = nearest(Gdist, currentNode, Inf, 'Method', 'unweighted');
    param = aco_base_parameters;
    %next_nodes = nodes;
    Aprob = zeros(size(Atrail));
    Atrail = triu(Atrail);
    for i = 1:length(param.nodes)
      
        next_nodes = nearest(Gdist,param.nodes(i), Inf, 'Method', 'unweighted');
        sumprob = sum((Atrail(param.nodes(i), next_nodes).^param.alpha).*...
                      Anij(param.nodes(i), next_nodes).^param.beta);
        

        for j = 1:length(next_nodes)
            if sumprob==0
                Aprob(param.nodes(i), next_nodes(j)) = 1;
            else
            Aprob(param.nodes(i), next_nodes(j)) = Atrail(param.nodes(i),next_nodes(j))^param.alpha...
                                                  *Anij(param.nodes(i),next_nodes(j))^param.beta/sumprob;
            end
        end
    end
end 
