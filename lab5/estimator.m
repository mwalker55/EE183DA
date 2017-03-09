function [true_states, estimated_state] = estimator(control_seq, trueXYT, estXYT)
    %input: input PWM sequence to each wheel; true current op state and
    %state estimated current op state
    %output: true state of vehicle over course of given PWM inputs and
    %estimate of vehicle state over course of given PWM inputs
    
    %input PWM sequence to simulator and receive true and sensed RPM
    [sensed_rpm, true_rpm] = simulator(control_seq);
    %generate RPMs from control sequence with no process/sensor noise
    mean_rpm = generateMeanRPM(control_seq);
    
    %given true, sensed, noiseless RPM determine state variables at each
    %2ms increment
    sensed_states = determineStatesFromRPM(sensed_rpm, estXYT(1), estXYT(2), estXYT(3));
    true_states = determineStatesFromRPM(true_rpm, trueXYT(1), trueXYT(2), trueXYT(3));
    mean_states = determineStatesFromRPM(mean_rpm, estXYT(1), estXYT(2), estXYT(3));
    
    %create state estimate by averaging noiseless and sensed state
    %variables
    estimated_state = mean(cat(3, mean_states, sensed_states), 3);
end