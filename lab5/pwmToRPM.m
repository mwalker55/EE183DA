function RPM = pwmToRPM(pwm)
    %input: pure pwm input
    %output: RPM after factoring in PWM input noise
    
    %adjust pure PWM input to be noisy
    if(pwm == 2)
       pwm_real = (2-1.9)*rand()+1.9;
    elseif(pwm == 1.5)
       pwm_real = (1.51-1.49)*rand()+1.49;
    else
       pwm_real = (1.1-1)*rand()+1;
    end
    
    %compute real RPM using 65RPM as max rotational speed
    RPM = (pwm_real-1.5)*130;
end