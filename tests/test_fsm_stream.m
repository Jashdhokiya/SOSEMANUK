% --- Standalone Test for the FSM Stream ---
clear functions; % Ensure a clean start

% Key A: Original key
key_hex_A = '8800000000000000800000000000000000000000000000000000000000000000';
% Key B: Last byte is changed
key_hex_B = '88000000000000008000000000000000000000000000000000000000000000FF';

key_A = uint8(sscanf(key_hex_A, '%2x').');
key_B = uint8(sscanf(key_hex_B, '%2x').');

% --- Setup for Key A ---
ctx_A = struct();
ctx_A.subkeys = serpent_key_schedule(key_A);
ctx_A.fsm = uint32([0 0]);
ctx_A.fsm_idx = 1; % Using the 'Best Fix' from the persistent variable issue

% --- Setup for Key B ---
ctx_B = struct();
ctx_B.subkeys = serpent_key_schedule(key_B);
ctx_B.fsm = uint32([0 0]);
ctx_B.fsm_idx = 1;

% Generate 20 outputs from the FSM for each key
stream_A = zeros(1, 20, 'uint32');
stream_B = zeros(1, 20, 'uint32');

for i = 1:20
    [ctx_A, fsm_out_A] = fsm_step(ctx_A);
    stream_A(i) = fsm_out_A;

    [ctx_B, fsm_out_B] = fsm_step(ctx_B);
    stream_B(i) = fsm_out_B;
end

% --- Compare the FSM output streams ---
if isequal(stream_A, stream_B)
    fprintf('------------------------------------------------------\n');
    fprintf('TEST FAILED: The FSM output streams are identical.\n');
    fprintf('This means the logic in fsm_step.m is the problem.\n');
    fprintf('------------------------------------------------------\n');
else
    fprintf('------------------------------------------------------\n');
    fprintf('TEST PASSED: The FSM output streams are different.\n');
    fprintf('This means fsm_step.m is working correctly.\n');
    fprintf('------------------------------------------------------\n');
end