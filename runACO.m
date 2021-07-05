%% Run ACO once
plotfigure = true;
[Aprob, Atrail, Atrail_cycles, Aprob_cycles] = ACO(plotfigure);
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
N = 100; % number of runs
Aprob = zeros(length(param.nodes), length(param.nodes),N);

for i=1:N
    Aprob(:,:,i) = ACO(plotfigure);
    disp(i)
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
[~, ~, Atrail_AS, Aprob_AS] = ACO(plotfigure);
%[~, ~, Atrail_MMAS, Aprob_MMAS] = ACO(plotfigure);
startNode = 1; % change path to observe here
endNode = 3;
trail_AS = reshape(Atrail_AS(startNode,endNode,:),param.Ncycles+1,1);
%trail_MMAS = reshape(Atrail_MMAS(startNode,endNode,:),param.Ncycles+1,1);
prob_AS = reshape(Aprob_AS(startNode,endNode,:),param.Ncycles+1,1);
%prob_MMAS = reshape(Aprob_MMAS(startNode,endNode,:),param.Ncycles+1,1);
figure()
plot(trail_AS, '+-','linewidth', 1.3)
set(gca,'FontSize',14);
hold on
title('Pheromone level on path 1->3')
%plot(trail_MMAS,'+-','linewidth', 1.5)
xlabel('Cycles (N)');
ylabel('Pheromone level');
legend('AS');
grid on
hold off

figure()
plot(prob_AS, '+-', 'linewidth', 1.5)
set(gca,'FontSize',14)
hold on
title('Probability of choosing path 1->3')
%plot(prob_MMAS, '+-','linewidth', 1.5)
legend('AS');
xlabel('Cycles (N)');
ylabel('Probability');
grid on
hold off

