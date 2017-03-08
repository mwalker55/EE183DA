function RPM = pwmToRPM(pwm)
    if(pwm == 2)
       pwm_real = (2-1.9)*rand()+1.9;
    elseif(pwm == 1.5)
       pwm_real = (1.51-1.49)*rand()+1.49;
    else
       pwm_real = (1.1-1)*rand()+1;
    end
    RPM = (pwm_real-1.5)*130;
end