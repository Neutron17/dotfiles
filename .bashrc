#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='exa'
alias ll='exa -l --icons'
# alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
