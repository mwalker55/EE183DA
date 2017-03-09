function [ prev_state ] = updateState(prev_state)
    %input: state at previous time point (.002s ago)
    %output: state at current time point with three operational state
    %variables updated reflecting velocities over last .002s; three
    %velocity variables still need to be updated at current time point
    prev_state(1) = prev_state(1)+.002*prev_state(4);
    prev_state(2) = prev_state(2)+.002*prev_state(5);
    prev_state(3) = mod(prev_state(3)+.002*prev_state(6), 2*pi);
end