####
alias gco="cd ~/githubOtokanConfigs/"

shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

####

git_prompt() {
    local REPONAME=$( basename $( git rev-parse --show-toplevel 2> /dev/null ) 2> /dev/null )
    [[ ! $REPONAME ]] && return 0
    #local BRANCH=$( git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ {\1}/' )
    local BRANCH=$( git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/' )
    #[[ ! $BRANCH ]] && return 0
    echo " {$REPONAME:$BRANCH}"
} 


export PS1="${YELLOW}./> ${GREEN}\W${RED}"'$(git_prompt)'"${YELLOW} \n\\$ ${NC}"

####

diffifneeded() { [[ -e $1 ]] && [[ -e $2 ]] && { cmp -s $1 $2 || vimdiff -c 'set diffopt=filler,context:1 | syntax off | nmap <f3> :wqa<cr> | nmap <f4> :qa!<cr> | nmap Q dp]c | norm gg]c[c' $1 $2; } }

cmp_dirs() { for f in $( find . -type f ); do diffifneeded $f $1/$f; done; }
cmp_configs() { for f in $( find * -type f -regex '.*/'$1'/.*' ); do diffifneeded $f ${f/$1/$2/}; done; }
cmp_branch() {  for f in $( find -type f -regex '.*/'$1'/.*' ); do git show $2:$f > /tmp/cmp_branch.$$  ; diffifneeded  /tmp/cmp_branch.$$ $f; done; rm /tmp/cmp_branch.$$; } 
