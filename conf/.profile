# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

ls="ls --color=yes"
alias ll="ls -l"
: << EOF

\$ 提示符 root # 普通用户 $
设置字符序列颜色格式为：\[\e[F;Bm\]
F为自体颜色， 编号30-37 B为背景颜色,编号：40-47
\e[0m关闭颜色输出 当B=1时将显示加亮加粗的字体

颜色表(注意不是组合后的结果):
前景   背景  颜色
30 40 黑色
31 41 红色
32 42 绿色
33 43 黄色
34 44 蓝色
35 45 紫红色
36 46 青蓝色
37 47 白色

代码 意义
0 OFF
1 高亮显示
4 underline
5 闪烁
7 反白显示
8 不可见
EOF

#xm automatic complete
#complete -W "console create destroy domid domname dump-core list mem-max mem-set migrate pause reboot rename restore save shutdown sysrq trigger top unpause uptime vcpu-list vcpu-pin vcpu-set the debug-keys dmesg info log serve sched-credit sched-sedf block-attach block-detach block-list block-configure network-attach network-detach network-list vtpm-list pci-attach pci-detach pci-list pci-list-assignable-devices vnet-list vnet-create vnet-delete labels addlabel rmlabel getlabel dry-run resources makepolicy loadpolicy cfgbootpolicy dumppolicy" xm
EDITOR=vim

#Xen xm command completion function
function _xm()
{
    XENXM=${XENXM:="on"}
    [ "$XENXM" == "off" ] && return 0

    local word=${COMP_WORDS[COMP_CWORD]}
    local line=${COMP_LINE}
    local comstr="console\ncreate\ndestroy\ndomid\ndomname\ndump-core\nlist\nmem-max\nmem-set\nmigrate\npause\nreboot\nrename\nrestore\nsave\nshutdown\nsysrq\ntrigger\ntop\nunpause\nuptime\nvcpu-list\nvcpu-pin\nvcpu-set\ndebug-keys\ndmesg\ninfo\nlog\nserve\nsched-credit\nsched-sedf\nblock-attach\nblock-detach\nblock-list\nblock-configure\nnetwork-attach\nnetwork-detach\nnetwork-list\nvtpm-list\npci-attach\npci-detach\npci-list\npci-list-assignable-devices\nvnet-list\nvnet-create\nvnet-delete\nlabels\naddlabel\nrmlabel\ngetlabel\ndry-run\nresources\nmakepolicy\nloadpolicy\ncfgbootpolicy\ndumppolicy"
    local Wordlist
    local Wordlist1
    local Wordlist2

    case "$line" in
        *create*)
            COMPREPLY=($(compgen -f -X "!*.cfg" -- "${word}"))
            ;;
        *console*|*destroy*|*reboot*|*pause*|*unpause*|*shutdown*|*mem-max*|*mem-set*|*uptime*|*vcpu-list*|*vcpu-set*|*block-attach*|*block-list*|*network-attach*|*network-list*|*pci-attach*|*vcpu-pin*|*rename*|*domid*|*migrate*|*save*|*dump-core*)
            Wordlist2=$(xm list|sed '1,2d'|awk '{print $1}')
            COMPREPLY=($(compgen -W "$Wordlist2" -- "${word}"))
            ;;
        *pci-list-assignable-devices*)
            Wordlist1=$(xm pci-list-assignable-devices|grep -iv error)
            COMPREPLY=($(compgen -W "$Wordlist1" -- "${word}"))
            ;;
        *pci-list*)
            case "${line/*pci-list/}" in
                *" "*)
                    Wordlist2=$(xm list|sed '1,2d'|awk '{print $1}')
                    COMPREPLY=($(compgen -W "$Wordlist2" -- "${word}"))
                    ;;
                "")
                    Wordlist2=$(xm list|sed '1,2d'|awk '{print $1}')
                    COMPREPLY=($(compgen -W "$Wordlist2 pci-list-assignable-devices" -- "${word}"))
                    ;;
            esac
            ;;
        *list*)
            Wordlist2=$(xm list|sed '1,2d'|awk '{print $1}')
            COMPREPLY=($(compgen -W "$Wordlist2" -- "${word}"))
            ;;
        *block-detach*)
            [ $(echo "$line" | awk '{print NF}') -ge 3 ] && 
            Wordlist2=$(eval xm block-list $(echo "$line" |awk '{print $3}') |
            awk '$1!~/Vdev/{print $1}') ||
            Wordlist2=$(xm list | sed '1,2d' | awk '{print $1}')
            COMPREPLY=($(compgen -W "$Wordlist2" -- "${word}"))
            ;;
        *network-detach*)
            [ $(echo "$line" | awk '{print NF}') -ge 3 ] && 
            Wordlist2=$(eval xm network-list $(echo "$line" |awk '{print $3}') |
            awk '$1!~/Idx/{print $1}') ||
            Wordlist2=$(xm list | sed '1,2d' | awk '{print $1}')
            COMPREPLY=($(compgen -W "$Wordlist2" -- "${word}"))
            ;;
        *pci-detach*)
            [ $(echo "$line" | awk '{print NF}') -ge 3 ] && 
            Wordlist2=$(eval xm pci-list $(echo "$line" |awk '{print $3}') |
            awk '$1!~/VSlt/{print "0000:"$3":"$4"."$5}') ||
            Wordlist2=$(xm list | sed '1,2d' | awk '{print $1}')
            COMPREPLY=($(compgen -W "$Wordlist2" -- "${word}"))

            ;;
        *domname*)
            Wordlist2=$(xm list | sed '1,2d' | awk '{print $2}')
            COMPREPLY=($(compgen -W "$Wordlist2" -- "${word}"))
            ;;
        *dry-run*)
            COMPREPLY=($(compgen -f -X "!*.cfg" -- "${word}"))
            ;;
        *restore*)
            COMPREPLY=($(compgen -f -- "${word}"))
            ;;
        *)
            Wordlist=$(echo -e "$comstr")
            COMPREPLY=($(compgen -W "$Wordlist" -- "${word}"))
            ;;
    esac
}

#install profile have include this
complete -o default -F _xm xm
PS1='\[\e[34;35m\]\[\e[0m\][host\[\e[36;99m\]-a\[\e[0m\]\[\e[34;99m\]\[\e[0m\]]\[\e[31;99m\]\$\[\e[0m\]'
export TESTER=INSTESTER
BASE_NAME="$(basename $(ls -1d /var/lib/deploy*))"
alias cg="source /var/lib/$BASE_NAME/$TESTER/bin/cg"
export COWPATH=/var/lib/$BASE_NAME/$TESTER/bin/
export PATH=$PATH:/var/lib/$BASE_NAME/$TESTER/bin:/usr/sbin # Add RVM to PATH for scripting
