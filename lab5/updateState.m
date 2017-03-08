function [ prev_state ] = updateState(prev_state)
    prev_state(1) = prev_state(1)+.002*prev_state(4);
    prev_state(2) = prev_state(2)+.002*prev_state(5);
    prev_state(3) = mod(prev_state(3)+.002*prev_state(6), 2*pi);
end