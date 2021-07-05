%% Run ACO once
clear
close all
plotfigure = true;
[Aprob, Atrail, Atrail_cycles, Aprob_cycles] = ACO(plotfigure, 'AS');
disp("End transition probability matrix is = ");
disp(Aprob)
disp("End Pheromone level matrix = ");
disp(Atrail);
initGraph('pheromone_end',plotfigure,Atrail);
initGraph('probabilities', plotfigure, Aprob);
pause
%% Run ACO multiple times
clear
clc
close all
plotfigure = false;
param = aco_base_parameters;
N = 10; % number of runs
Aprob = zeros(length(param.nodes), length(param.nodes),N);

for i=1:N
    Aprob(:,:,i) = ACO(plotfigure, 'AS');
    disp("iteration ");
    disp(i);
end
Aprob_avg = mean(Aprob,3);
initGraph('probabilities', ~plotfigure, Aprob_avg);
disp("Average prob. matrix")
disp(Aprob_avg)
%standard deviation matrix
disp("The standard deviation matrix is")
disp(std(Aprob,0,3))
pause
%% Compare AS and MMAS
plotfigure = false;
param = aco_base_parameters;
[~, ~, Atrail_AS, Aprob_AS] = ACO(plotfigure, 'AS');
[~, ~, Atrail_MMAS, Aprob_MMAS] = ACO(plotfigure, 'MMAS');
%%%%% change path to observe here %%%%%%%%%
startNode = 1; 
endNode = 3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%
trail_AS = reshape(Atrail_AS(startNode,endNode,:),param.Ncycles+1,1);
trail_MMAS = reshape(Atrail_MMAS(startNode,endNode,:),param.Ncycles+1,1);
prob_AS = reshape(Aprob_AS(startNode,endNode,:),param.Ncycles+1,1);
prob_MMAS = reshape(Aprob_MMAS(startNode,endNode,:),param.Ncycles+1,1);
figure()
plot(trail_AS, '+-','linewidth', 1.3)
set(gca,'FontSize',14);
hold on
title('Pheromone level on path 1->3')
plot(trail_MMAS,'*-','linewidth', 1.3)
xlabel('Cycles (N)');
ylabel('Pheromone level');
legend('AS', 'MMAS');
grid on
hold off

figure()
plot(prob_AS, '+-', 'linewidth', 1.5)
set(gca,'FontSize',14)
hold on
title('Probability of choosing path 1->3')
plot(prob_MMAS, '*-','linewidth', 1.3)
legend('AS', 'MMAS');
xlabel('Cycles (N)');
ylabel('Probability');
grid on
hold off

