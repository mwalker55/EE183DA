function [true_states, estimated_state] = estimator(control_seq, trueXYT, estXYT)
    [sensed_rpm, true_rpm] = simulator(control_seq);
    mean_rpm = generateMeanRPM(control_seq);
    sensed_states = determineStatesFromRPM(sensed_rpm, estXYT(1), estXYT(2), estXYT(3));
    true_states = determineStatesFromRPM(true_rpm, trueXYT(1), trueXYT(2), trueXYT(3));
    mean_states = determineStatesFromRPM(mean_rpm, estXYT(1), estXYT(2), estXYT(3));
    estimated_state = mean(cat(3, mean_states, sensed_states), 3);
   
    true_states(4:6, end) = zeros(3,1);  estimated_state(4:6, end) = zeros(3,1);
end