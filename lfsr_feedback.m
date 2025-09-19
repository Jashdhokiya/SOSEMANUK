% lfsr_feedback.m
function fb = lfsr_feedback(ctx)
% A simplified LFSR feedback function for a 10-word register.
% This uses valid indices (1 through 10) to prevent errors.

    s = ctx.s;
    
    % New placeholder logic using valid indices for a 10-word LFSR
    fb = bitxor(s(1), bitxor(s(3), s(10)));
end