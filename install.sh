#!/usr/bin/env bash

# check gnu stow is installed
hash stow 2>/dev/null || {
	#hash 命令的主要作用是管理 shell 中的命令的路径缓存， shell 中执行命令时，系统会根据 $PATH 环境变量中定义的路径查找命令的位置
	#，然后将命令的路径缓存起来，以便后续更快地执行该命令
	#
	#Stow 允许你将存储在不同目录里软件包的文件安装到一个单独的目录中，然后使用符号链接（symbolic links）将这些文件链接到其在系统中真正应该存在的位置
	#
	#/dev/null 实际上是模拟一个空设备，任何写入到这个设备的数据都会被丢弃，读取这个设备则会立即得到一个文件结束符（EOF）
	#
    echo >&2 "GNU stow is required but it's not installed.";
    echo >&2 "Install with homebrew: brew install stow";
    exit 1;
    #exit 1 中的 1 是一个退出状态码，它指示进程或脚本以错误的状态退出
    #0代表正确的状态退出
    #如果没有退出状态码，则以上一个命令的状态作为退出状态码
}

# colors in term
# http://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
# 改变颜色
GREEN=
RED=
NC=
#NO COLORS 恢复为默认颜色
#创建空字符串变量 之后用于储存
if tty -s < /dev/fd/1 2> /dev/null; then
#tty teletypewriter 电传打字机
#tty 用于显示当前终端设备的名称 
#tty 命令不带任何参数时，它会打印当前正在使用的终端设备的名称
# -s silent 静默运行，只返回状态码 确保脚本在终端运行
# < 重定向
# 
# /dev/fd/1 
# fd file descriptors 文件描述符
# 0 标准输入  1 标准输出  2 标准错误
# 将标准输出重定向到tty -s 中，检查当前脚本的输出是否连接到终端
# 
# 
# 
  RED='\033[0;31m'
  NC='\033[0m' # No Color
  #  ANSI 转义码 American National Standards Institute 
  #  \ 转义
  #  033 ASCII 字符 ESC（Escape）的十六进制表示
  #  [0 表示设置为正常样式
  #  ； 表示分隔
  #  31 颜色码 红色
  #  m 结束转义序列
fi

#日志函数 
log_warn () {
  echo -e "==> ${RED}$@${NC} <=="
  #-e enable 允许解释转义字符
  # $@ 与$*类似  代表传递给函数或脚本的所有参数列表
  # 即所有此时传递的参数都打印为red
  # ${NC} 表示之后的启用默认
}
# 日志信息，已经或即将有意外发生时
log_info () {
  echo -e "==> ${GREEN}$@${NC}"
}
#输出状态监控和事件报告
log_debug () {
  echo -e "==> $@"
}
#输出debug（调试）信息，帮助排错用的
# enter BASE_DIR
# 
# 
BASE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# 0 当前脚本的文件名及路径
# 1 父级调用
# 
cd "${BASE_DIR}" || exit

# stow configurations
mkdir -p ~/.config
#生成配置文件

log_warn "Restow dotfiles"
#将参数传给 log_warn
DIRS=( stow-git stow-latexmk stow-perltidy stow-screen stow-wget stow-vim stow-proxychains )
# 定义一个数组
# （ ）数组
# 数组一般要求元素相同 列表可以包含不同的
# 
for d in ${DIRS[@]}; do
	#[@] 表示引用这个数组中的所有元素
	#
    log_info "${d}"
    # 传递给这个参数
    # 
    for f in $(find ${d} -maxdepth 1 | cut -sd / -f 2- | grep .); do
    	#find ${d}  在d中查找
    	# -maxdepth 1 最大深度为1 不再向下查找
    	# 
    	# cut： -s  silent -d delimiter 分隔符 此处是指定为 /  -f 2- 表示从第二个开始取  第一个通常是父目录 -f field
    	# 
    	# . 表示匹配任何非空行
        homef="${HOME}/${f}"
        #构建目录
        #
        if [ -h "${homef}" ] ; then
        	# -h sysmbol link 符号链接
        	# 比较两个文件的inode号是否相同来判断它们是否是硬链接
            log_debug "Symlink exists: [${homef}]"
        elif [ -f "${homef}" ] ; then
            log_debug "Delete file: [${homef}]"
            # -f file
            # 
            rm "${homef}"
            #不正常，删除
        elif [ -d "${homef}" ] ; then
            log_debug "Delete dir: [${homef}]"
            # -d 目录
            rm -fr "${homef}"
            # 不正常，删除
        fi
    done
	stow -t "${HOME}" "${d}" -v 2
	# -t target  将d解压缩到HOME
	# -v verbose 显示详细信息  -0 不显示  -1 显示默认的  -2显示更信息的
done

# don't ruin Ubuntu
log_info "stwo-bash"
stow -t "${HOME}" stow-bash -v 2
#使得这个软件包的配置文件、脚本或其他内容对该用户更为可用
