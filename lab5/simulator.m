function [ sensors, true_rpm ] = simulator(control_seq)
    if(size(control_seq,1) > 1)
        num_cycles = sum(control_seq); num_cycles = num_cycles(3);
    else
        num_cycles = control_seq(1,3);
    end
    sensors = zeros(2, num_cycles);
    true_rpm = zeros(2, num_cycles);
    curr_cycle = 1;
    for i=1:size(control_seq, 1)
       for n=1:control_seq(i, 3)
          left_RPM_true = pwmToRPM(control_seq(i,1));
          right_RPM_true = pwmToRPM(control_seq(i,2));
          true_rpm(1, curr_cycle) = left_RPM_true;
          true_rpm(2, curr_cycle) = right_RPM_true;
          left_RPM_sensed = round((.2*left_RPM_true*rand() + .9*left_RPM_true)/.0004)*.0004;
          right_RPM_sensed = round((.1*right_RPM_true*rand() + .9*right_RPM_true)/.0004)*.0004;
          sensors(1, curr_cycle) = left_RPM_sensed;
          sensors(2, curr_cycle) = right_RPM_sensed;
          curr_cycle = curr_cycle + 1;
       end
    end
end