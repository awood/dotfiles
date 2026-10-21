KEYCHAIN_KEYS=(
    ~/.ssh/id_rsa
)
eval "$(keychain add --eval "${KEYCHAIN_KEYS[@]}" "gpgs:99779B18")"
