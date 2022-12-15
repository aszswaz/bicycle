alias cp="cp -v -r"
alias rm="rm -rf"
alias tree="tree -I '.git' -I 'node_modules' -I 'electron-builder'"
alias ffplay="ffplay -vf 'drawtext=text='%{pts\:hms}':box=1:x=(w-tw)/2:y=h-(2*lh):boxborderw=4' -autoexit"
alias rsync="rsync -rav"

alias document="cd $HOME/Documents/notebook"
alias aszswaz="cd $HOME/Documents/project/aszswaz && ls --time-style='long-iso' -h -t -o"
alias zhiweidata="cd $HOME/Documents/project/zhiweidata && ls --time-style='long-iso' -h -t -o"

alias mvn8="JAVA_HOME=/usr/lib/jvm/java-8-openjdk mvn"
alias mvn11="JAVA_HOME=/usr/lib/jvm/java-11-openjdk mvn"

alias ctags="ctags -I __THROW --extras=+F --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --fields=+S -R"
alias systags="ctags -f ~/.config/nvim/systags /usr/include /usr/local/include"

alias mongo="mongo --nodb"
alias mongosh="mongosh --nodb"

alias mysql="mysql --ssl-mode DISABLED"
alias mysql_local="MYSQL_PWD=root mysql --ssl-mode DISABLED -u root"

alias node10="$HOME/.local/share/node-v10.16.3-linux-x64/bin/node"
alias npm10="$HOME/.local/share/node-v10.16.3-linux-x64/lib/node_modules/npm/bin/npm-cli.js"
alias npx10="$HOME/.local/share/node-v10.16.3-linux-x64/lib/node_modules/npm/bin/npx-cli.js"

alias xclip='xclip -selection clipboard'
