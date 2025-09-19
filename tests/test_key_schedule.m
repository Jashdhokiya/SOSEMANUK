% --- Standalone Test for serpent_key_schedule ---
clear functions; % Ensure a clean start

% Key A: Original key
key_hex_A = '8800000000000000800000000000000000000000000000000000000000000000';

% Key B: Same as Key A, but the VERY LAST byte is changed (00 -> FF)
key_hex_B = '88000000000000008000000000000000000000000000000000000000000000FF';

% Convert hex strings to byte arrays
key_A = uint8(sscanf(key_hex_A, '%2x').');
key_B = uint8(sscanf(key_hex_B, '%2x').');

fprintf('Testing serpent_key_schedule...\n');

% Generate subkeys for both keys
subkeys_A = serpent_key_schedule(key_A);
subkeys_B = serpent_key_schedule(key_B);

% Compare the results
if isequal(subkeys_A, subkeys_B)
    fprintf('------------------------------------------------------\n');
    fprintf('TEST FAILED: The subkeys are identical.\n');
    fprintf('This confirms the second half of the key is being ignored.\n');
    fprintf('------------------------------------------------------\n');
else
    fprintf('------------------------------------------------------\n');
    fprintf('TEST PASSED: The subkeys are different.\n');
    fprintf('This means the key schedule is working correctly.\n');
    fprintf('------------------------------------------------------\n');
end