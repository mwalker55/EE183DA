clear; clc;

control_seq = [1 2 13; 2 1 25; 1 1 5; 2 1 50; 2 2 10; 1 2 36; 2 2 10; 1 2 6];
[sensed_rpm, true_rpm] = simulator(control_seq);
mean_rpm = generateMeanRPM(control_seq);
sensed_states = determineStatesFromRPM(sensed_rpm);
true_states = determineStatesFromRPM(true_rpm);
mean_states = determineStatesFromRPM(mean_rpm);

estimated_state = mean(cat(3, mean_states, sensed_states), 3);

figure; hold on;
plot(sensed_states(1,:), sensed_states(2,:));
plot(true_states(1,:), true_states(2,:));
plot(estimated_state(1,:), estimated_state(2,:));
xlabel('X position of Car');
ylabel('Y position of Car');
title('Trajectory');
legend('Sensed', 'True', 'Estimated');   

mse_sensed = immse(true_states, sensed_states);
mse_estimated = immse(true_states, estimated_state);
