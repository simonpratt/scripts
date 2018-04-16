if [ "$TERM" != "dumb" ]
then
        if [ -x /usr/local/bin/zsh ]
        then
                SHELL=/bin/zsh
                export SHELL
                exec /bin/zsh
        fi
fi
