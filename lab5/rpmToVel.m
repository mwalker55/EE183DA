function [ dx, dy, dt ] = rpmToVel(RPM_left, RPM_right, theta)
    %input: RPM of each wheel and current direction car is facing
    %output: x,y, theta velocities
    wheel_rad = 50E-3;
    axle_rad = 45E-3;
    if(RPM_left > 0 && RPM_right < 0) %forward motion
       dx = mean([RPM_left -RPM_right])*2*pi*wheel_rad/60*cos(theta);
       dy = mean([RPM_left -RPM_right])*2*pi*wheel_rad/60*sin(theta);
       dt = 0;
    elseif (RPM_left < 0 && RPM_right > 0) %backward motion
       dx = -mean([-RPM_left RPM_right])*2*pi*wheel_rad/60*cos(theta);
       dy = -mean([-RPM_left RPM_right])*2*pi*wheel_rad/60*sin(theta);
       dt = 0;
    elseif (RPM_left < 0 && RPM_right < 0) %rotating CCW
       dx = 0; dy = 0;
       dt = -mean([RPM_left RPM_right])*2*pi*wheel_rad/60*1/axle_rad;
    elseif (RPM_left > 0 && RPM_right > 0) %rotating CW
       dx = 0; dy = 0;
       dt = -mean([RPM_left RPM_right])*2*pi*wheel_rad/60*1/axle_rad;  
    elseif (RPM_left == 0 && RPM_right == 0) %absolutely zero motion
       dx = 0; dy = 0; dt = 0; 
    end
end