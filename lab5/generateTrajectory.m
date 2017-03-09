function [control_seq] = generateTrajectory(initialXYT, finalXYT)
    %input: current car operational state vars and goal car operational
    %state vars
    %output: control PWM sequence to drive car with to move from current op
    %state to goal op state
    control_seq = zeros(3,3);
   
    %variable set-up: ideal linear speed/omega for determining input
    %lengths
    ideal_RPM = 65;
    wheel_rad = 50E-3; axle_rad = 45E-3;
    ideal_lin_vel = ideal_RPM*2*pi*wheel_rad/60;  ideal_rot = ideal_lin_vel/axle_rad;
    
    %vector between current x,y and goal x,y along with length/direction of
    %difference vector
    diff_vec = [finalXYT(1)-initialXYT(1) finalXYT(2)-initialXYT(2)];
    dist = sqrt(sum(diff_vec.^2));
    dir = atan2(diff_vec(2), diff_vec(1));
    
    %difference in current car orientation and direction to goal op state
    dir_diff = dir - initialXYT(3);
    
    %determine how many .002s cycles we need to rotate and in what
    %direction; note loss of precision since rotations must be in exact
    %.002s increments
    rot_cyc_needed = abs(round(dir_diff/(ideal_rot*.002)));
    if(dir_diff > 0)
        control_seq(1, :) = [1 1 rot_cyc_needed];
    else
        control_seq(1, :) = [2 2 rot_cyc_needed];
    end
    
    %input forward motion to nearest .002s increment to move between
    %current point and and goal after changing direction to face goal
    control_seq(2, :) = [2 1 round(dist/(ideal_lin_vel*.002))];
    
    %at goal point, determine difference in goal orientation and current
    %orientation and rotate accordingly
    dir_diff = finalXYT(3) - dir;
    rot_cyc_needed = abs(round(dir_diff/(ideal_rot*.002)));
    if(dir_diff > 0)
        control_seq(3, :) = [1 1 rot_cyc_needed];
    else
        control_seq(3, :) = [2 2 rot_cyc_needed];
    end
end