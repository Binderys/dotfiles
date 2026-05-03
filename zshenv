export LINEAR_API_KEY=$(security find-generic-password -a "$USER" -s LINEAR_API_KEY -w 2>/dev/null)
