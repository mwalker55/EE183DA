clear; clc;

control_seq = [2 2 15; 1 2 30; 2 1 90; 1 1 30; 1 2 30; 2 2 50; 1 2 5; 2 2 10; 2 1 50; 2 2 10; 1.5 1.5 5; 2 1 10; 2 2 15; 1 2 5; 2 2 10; 2 1 30];
[sensed_rpm, true_rpm] = simulator(control_seq);
mean_rpm = generateMeanRPM(control_seq);
sensed_states = determineStatesFromRPM(sensed_rpm);
true_states = determineStatesFromRPM(true_rpm);
mean_states = determineStatesFromRPM(mean_rpm);

figure; hold on;
plot(sensed_states(1,:), sensed_states(2,:));
plot(true_states(1,:), true_states(2,:));
plot(mean_states(1,:), mean_states(2,:));
xlabel('X position of Car');
ylabel('Y position of Car');
title('Trajectory');
legend('Sensed', 'True', 'Mean');   

mse_sensed = immse(true_states, sensed_states);
mse_combo = immse(true_states, mean(cat(3, mean_states, sensed_states), 3));