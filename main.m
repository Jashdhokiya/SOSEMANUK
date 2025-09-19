function main(key_hex, iv_hex) % <-- Changed: Add inputs here
    clear functions;

    % REMOVE the hardcoded key and IV lines.
    % The function will now use the values passed into it.
    
    % Add some basic error checking for the key length
    if numel(key_hex) ~= 64 % 32 bytes * 2 hex chars/byte
        error('Invalid Key: The key_hex string must be 64 characters long for a 256-bit key.');
    end
    if numel(iv_hex) ~= 32 % 16 bytes * 2 hex chars/byte
        error('Invalid IV: The iv_hex string must be 32 characters long for a 128-bit IV.');
    end
    
    fprintf('--- Running SOSEMANUK ---\n');
    fprintf('Key: %s...\n', key_hex(1:8));
    fprintf('IV:  %s...\n', iv_hex(1:8));

    % Convert hex strings to byte arrays
    key = uint8(sscanf(key_hex, '%2x').');
    iv  = uint8(sscanf(iv_hex, '%2x').');
    
    % ... the rest of your code remains the same ...
    
    ctx_enc = sosemanuk_init(key, iv);
    plaintext = uint8('HELLO');
    ciphertext = sosemanuk_process(ctx_enc, plaintext);
    fprintf('Ciphertext (hex): %s\n', upper(reshape(dec2hex(ciphertext,2)',1,[])));
    
    ctx_dec = sosemanuk_init(key, iv);
    recovered = sosemanuk_process(ctx_dec, ciphertext);
    fprintf('Decrypted text: %s\n', char(recovered));
    fprintf('-------------------------\n');
end