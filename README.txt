********* INSTRUCTIONS TO USE ACO ***********

-Place all files in the same folder


### To run the algorithm please use "runACO.m":
- first section: runs one instance of the ACO algorithm
- 2nd section: runs multiple instances of the ACO algorithm
- 3rd section: compares level of pheromone and probabilites between "AS" and "MMAS" for an edge 

### Change parameters:
- Change parameters in "aco_base_parameters.m" (alpha, beta etc...)
- Graph is imported from graph_construction.mat (choose between graph1...graph4,....)
- graph used in the paper are wheatstone1, wheatstone2, wheatstone_new
- possibility to create new graphs using the script "save_graph.m" which saves new graphs to "graph_construction.mat"

### Brief summary of function/files roles
- "initGraph.m": initialize graphs from given weights, edges, plot the graph (optional) and returns the adjacency matrix
   -> used for pheromone, distance and probability graphs
- "getNextNode.m": for a current node, picks a next node given the probability of the allowed next nodes
- "updatePheromone.m": update the pheromones of the edges at the end, once each ant of the group has found the food node
- "probabilitesMatrix.m": returns the probability matrix given the pheromone level of the edges and the heuristic distance information