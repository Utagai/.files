function ls
    set -l opt --color=auto
    isatty stdout
    and set -a opt -F
    for fi in (/bin/ls $argv)
        if test -z $argv[-1]
            set fipath $fi
        else
            set fipath $argv[-1]/$fi
        end

        if test -d $fipath
            chmod o-w $fipath 2>/dev/null
        end
    end
    command ls $opt $argv
end
