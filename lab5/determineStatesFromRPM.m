function [states] = determineStatesFromRPM(RPM, initX, initY, initT)
    num_states = size(RPM,2)+2;
    states = zeros(6, num_states);
    states(1,1) = initX; states(2,1) = initY; states(3,1) = initT;
    for curr_state=2:(num_states-1)
        new_state = updateState(states(:, curr_state-1));
        [dx, dy, dt] = rpmToVel(RPM(1, curr_state-1), RPM(2, curr_state-1), new_state(3));
        new_state(4) = dx; new_state(5) = dy; new_state(6) = dt;
        states(:, curr_state) = new_state;
    end
    states(:, num_states) = updateState(states(:, num_states-1));
end