source /mintty-colors-solarized/sol.dark

#vi keybind
bindkey -v

#自動補完有効化
autoload -U compinit; compinit

#autocd
setopt auto_cd

#alias
alias ...='cd ../..'
alias ....='cd ../../..'
alias ls='ls -a'

#移動履歴をスタック
#cd + <Tab>で履歴表示
setopt auto_pushd
#重複はスタックしない
setopt pushd_ignore_dups
