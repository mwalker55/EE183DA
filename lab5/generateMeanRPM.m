function [RPM] = generateMeanRPM(control_seq)
    %input: PWM control sequence
    %output: RPM output representing mean process noise 
    if(size(control_seq,1) > 1)
        num_cycles = sum(control_seq); num_cycles = num_cycles(3);
    else
        num_cycles = control_seq(1,3);
    end
    RPM = zeros(2, num_cycles);
    curr_cycle = 1;
    for i=1:size(control_seq, 1)
        for n=1:control_seq(i,3)
           pwm_left = getMeanPWM(control_seq(i,1));
           pwm_right = getMeanPWM(control_seq(i,2));
           %compute mean RPM using 65RPM as max rotational speed
           RPM(1, curr_cycle) = (pwm_left-1.5)*130;
           RPM(2, curr_cycle) = (pwm_right-1.5)*130;
           curr_cycle = curr_cycle+1;
        end
    end
end

function pwm = getMeanPWM(pwm)
    %input: PWM control sequence input
    %output: mean true PWM output after processing; assuming no noise
    %around mean
    if(pwm==2)
        pwm=1.95;
    elseif(pwm==1.5)
        pwm=1.5;
    else
        pwm=1.05;
    end
end