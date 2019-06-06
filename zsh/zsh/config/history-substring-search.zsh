bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey -M viins "^[[A" history-substring-search-up
bindkey -M viins "^[[B" history-substring-search-down
bindkey -M vicmd "^[[A" history-substring-search-up
bindkey -M vicmd "^[[B" history-substring-search-down

setopt HIST_FIND_NO_DUPS

# Set Colors
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=green,fg=black,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=black,bold'
