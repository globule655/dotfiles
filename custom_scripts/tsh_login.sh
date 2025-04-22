#!/bin/bash

PROXY_DOMAIN="tlp.digeiz.fr"
TLP_VAULT_ID="8ae12b3d-84b5-4e8b-b157-eb70842fc01a"

tsh_login() {
    # Ensure bw is logged out first and get session key
    bw logout
    SESSION_KEY=$(bw login "guillaume.debros@digeiz.com" --raw)
    # Récupérer le mot de passe et le code TOTP dans des variables
    PASSWORD=$(bw get password $TLP_VAULT_ID --session $SESSION_KEY)
    TOTP=$(bw get totp $TLP_VAULT_ID --session $SESSION_KEY)
    
    # Créer un script expect temporaire
    TEMP_EXPECT=$(mktemp)
    
    # Écrire le script expect dans le fichier temporaire
    cat > "$TEMP_EXPECT" << 'EXPECTSCRIPT'
        set password [lindex $argv 0]
        set totp [lindex $argv 1]
        set proxy [lindex $argv 2]
        set username [lindex $argv 3]
        
        spawn tsh login --proxy=$proxy --user=$username
        expect "Enter password for Teleport user"
        send -- "$password\r"
        expect "Enter your OTP token"
        send -- "$totp\r"
        expect eof
EXPECTSCRIPT
    
    # Exécuter le script expect avec les arguments
    expect "$TEMP_EXPECT" "$PASSWORD" "$TOTP" "$PROXY_DOMAIN" "$USER"
    
    # Supprimer le fichier temporaire
    rm -f "$TEMP_EXPECT"
}

tsh_login
