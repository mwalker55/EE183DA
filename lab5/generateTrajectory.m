function [control_seq] = generateTrajectory(initialXYT, finalXYT)
    control_seq = zeros(3,3);
    ideal_RPM = 65;
    wheel_rad = 50E-3; axle_rad = 45E-3;
    ideal_lin_vel = ideal_RPM*2*pi*wheel_rad/60;  ideal_rot = ideal_lin_vel/axle_rad;
    diff_vec = [finalXYT(1)-initialXYT(1) finalXYT(2)-initialXYT(2)];
    dist = sqrt(sum(diff_vec.^2));
    dir = atan2(diff_vec(2), diff_vec(1));
    dir_diff = dir - initialXYT(3);
    rot_cyc_needed = abs(round(dir_diff/(ideal_rot*.002)));
    if(dir_diff > 0)
        control_seq(1, :) = [1 1 rot_cyc_needed];
    else
        control_seq(1, :) = [2 2 rot_cyc_needed];
    end
    control_seq(2, :) = [2 1 round(dist/(ideal_lin_vel*.002))];
    dir_diff = finalXYT(3) - dir;
    rot_cyc_needed = abs(round(dir_diff/(ideal_rot*.002)));
    if(dir_diff > 0)
        control_seq(3, :) = [1 1 rot_cyc_needed];
    else
        control_seq(3, :) = [2 2 rot_cyc_needed];
    end
end