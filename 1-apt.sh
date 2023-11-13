#!/usr/bin/env bash

echo "====> Install softwares via apt-get <===="
# Advanced Package Tool
# 适用于deb包管理式的操作系统，主要用于自动从互联网的软件仓库中搜索、安装、升级、卸载软件或操作系统
# Deb是Debian Linux操作系统中的软件包格式,Deb文件通常包含预编译的二进制文件、脚本和元数据，
# DEB是Debian软件包格式的文件扩展名，跟Debian的命名一样，DEB也是因Debra Murdock而得名，她是Debian创始人Ian Murdock的太太。
# 由于常常需要root权限来操作，所以常和sudo一起使用
# sudo super user do
# linux 用户分类：
# 超级用户 root 0 真实存在 拥有一切权限
# 程序用户 root 1-499 不真实存在，主要是程序
# 普通用户 root 500~65535 其中拥有相同权限的人可以划分到一个group当中，便于统一管理权限

echo "==> Disabling the release upgrader"
sudo sed -i.bak 's/^Prompt=.*$/Prompt=never/' /etc/update-manager/release-upgrades
# super user do 
# sed stream editor 
# -i   in place
# .bak Backup 指被备份的文件的副本，备份文件通常具有与原始文件相同的内容，但其文件扩展名被修改为.bak
# 类Unix操作系统（如Linux、macOS）中，以点开头的文件或目录通常被视为配置文件或特定用途的文件，它们通常不需要在常规文件列表中显示。
# s/ substitute 查找并替换 g/全局替换（global replacement）
# ^ 开头匹配 末尾：$ 
# .*$ 点号匹配任何单个字符，除了换行符.星号是一个量词，表示前一个元素（在这里是点号）可以出现零次或多次
# .* 表示匹配一个字符串中从当前位置到字符串末尾的所有字符
#  /etc/update-manager  Editable Text Configuration

echo "==> Switch to an adjacent mirror"
# 
# https://lug.ustc.edu.cn/wiki/mirrors/help/ubuntu
cat <<EOF > list.tmp

deb https://mirrors.ustc.edu.cn/ubuntu/ focal main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ focal main restricted universe multiverse

deb https://mirrors.ustc.edu.cn/ubuntu/ focal-security main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ focal-security main restricted universe multiverse

deb https://mirrors.ustc.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ focal-updates main restricted universe multiverse

deb https://mirrors.ustc.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ focal-backports main restricted universe multiverse

## Not recommended
# deb https://mirrors.ustc.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse
# deb-src https://mirrors.ustc.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse

EOF

# cat concatenate  连接  创建或查看文件 在终端中显示文件内容 或者是在文件或终端重定向输出
# <<EOF：这是 Here Document （文档嵌入） 的开始标记  EOF" 是 "End of File" 的缩写，但在这里它通常不是字面上的文件结尾，而是一个标记用于指示文本块的结束
#  >重定向  文件不存在则创建
#  .tmp文件来存储系统临时数据  temporary

#  DEB是Debian软件包格式的文件扩展名，跟Debian的命名一样，DEB也是因Debra Murdock而得名，她是Debian创始人Ian Murdock的太太。
#  deb deb包的目录  deb-src 编译deb包的源码目录 即通过.deb还是源码安装文件

# focal Ubuntu 20.04 LTS的主要软件源  
# focal-security Ubuntu 20.04 LTS的安全软件源 包含了一些安全更新的软件包。
# focal-updates Ubuntu 20.04 LTS的更新软件源  包含了一些更新的软件包。
# focal-backports  Ubuntu 20.04 LTS的后备软件源，包含了一些较新的软件包，但这些软件包可能没有经过充分测试
# focal-proposed Ubuntu 20.04 LTS的测试软件源，包含了一些即将发布的软件包，但这些软件包可能存在一些问题。
# LTS （"Long-Term Support）

# main：包含官方支持的自由和开源软件包。
# restricted：包含官方支持的但受限制的软件包，可能包含专有软件。
# universe：包含社区维护的自由和开源软件包。官方不支持和补丁
# multiverse：包含非自由和受限制的软件包。

if [ ! -e /etc/apt/sources.list.bak ]; then
	# [ ] 
	# 条件测试是基于字符串比较
	# 需要使用空格来分隔条件表达式的组成部分
	# 方括号不支持逻辑运算符，如 && 和 ||，因此你需要使用-a（and）和-o（or）来组合条件。
	
	#[[]]
	#条件测试更加灵活。它支持字符串比较、数值比较、正则表达式比较以及逻辑运算符
	#条件测试可以更简洁，因为不需要在变量周围使用引号（"$var"）
	#支持逻辑运算符 && 和 ||，以及常见的数值比较和字符串比较操作
	
	# ！ 单独bash命令
	
	#[[ -e file_path ]] existing 来测试文件是否存在
	#[[ -f file_path ]] file 来测试文件是否存在且是一个普通文件
	#[[ -d dir_path ]] directory 来测试文件存在且是目录
	
	#/etc/apt 目录包含了与APT（Advanced Package Tool）软件包管理系统相关的配置文件
	
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
    #  cp copy cp 发送源 去向文件
    #  sources.list.bak 指定名称，如果有，覆盖
fi
sudo mv list.tmp /etc/apt/sources.list
# mv move mv 发送源 去向
# sources.list 指定名称，如果有，覆盖

# Virtual machines needn't this and I want life easier.
# https://help.ubuntu.com/lts/serverguide/apparmor.html

if [ "$(whoami)" == 'vagrant' ]; then
	# whoami 命令用于显示自身用户名称 who am i
	# " " [ ]中的变量需要"" 且 有空格 
	# Vagrant 是一个用于虚拟化环境管理的开源工具
	
    echo "==> Disable AppArmor"
    sudo service apparmor stop
    # apparmor linux内核安全模块，控制应用程序各种权限
    # AppArmor允许系统管理员将每个程序与一个安全配置文件关联，从而限制程序的功能
    
    sudo update-rc.d -f apparmor remove
    #update-rc.d Run Control 管理Linux系统中的启动服务的配置 用于在不同的运行级别中管理系统的启动和停止服务。
    #通常存储在 /etc/init.d 目录
    #remove 删除
fi

echo "==> Disable whoopsie"
sudo sed -i 's/report_crashes=true/report_crashes=false/' /etc/default/whoopsie
# report_crashes 报告崩溃
# whoopsie 崩溃报告工具
sudo service whoopsie stop

echo "==> Install linuxbrew dependences"
sudo apt-get -y update
#apt-get 命令 适用于deb包管理式的操作系统，搜索、安装、升级、卸载二进制或源码格式软件包
#-y yes 
sudo apt-get -y upgrade
# update 更新本地软件包数据库 只是更新系统中已知软件包的信息，不涉及包的安装。
# upgrade 下载并安装这些新版本的软件包。
# 
sudo apt-get -y install build-essential curl file git
#build-essential 包含了编译和构建软件的工具和库，如编译器、链接器、标头文件，使系统具备编译和构建源代码的能力
#file 命令的主要功能是分析文件的内容并尝试识别文件的类型。它会返回有关文件的详细信息，包括文件类型、字符集、编程语言等。
#curl 命令行工具和库，用于在网络上传输数据。它可以用于从远程服务器下载文件、访问Web服务、发送HTTP请求等
#git 软件包允许用户使用 git 命令来克隆、管理和协作开发代码仓库
sudo apt-get -y install pkg-config libbz2-dev zlib1g-dev libzstd-dev libexpat1-dev
# -dev 通常是指开发库（Development Library）
# libbz2-dev 针对Bzip2数据压缩
# zlib1g-dev 这是针对Zlib数据压缩
# libzstd-dev 针对Zstandard（Zstd）压缩
# libexpat1-dev 对Expat XML解析器的开发库。Expat是一个轻量级、高性能的XML解析器，它用于解析XML文件
# 
# sudo apt-get -y install libcurl4-openssl-dev libncurses-dev

echo "==> Install other software"
sudo apt-get -y install aptitude net-tools parallel vim screen xsltproc numactl
#aptitude	aptitude 提供了一个交互式的命令行界面，用于管理软件包的安装、升级、删除和查询
# net-tools 允许管理员配置和监控网络连接
# parallel  并行执行命令
# vim vi improvement 
# screen  允许用户在一个终端窗口中运行多个虚拟终端会话
# xsltproc 执行XSLT（Extensible Stylesheet Language Transformations）转换的命令行工具。XSLT是一种用于将XML文档转换为其他格式的标记语言。
# numactl NUMA（Non-Uniform Memory Access，非均匀内存访问）系统管理的工具。 对高性能计算和服务器工作负载非常重要
#
#
#
echo "==> Install develop libraries"
# sudo apt-get -y install libreadline-dev libedit-dev
sudo apt-get -y install libdb-dev libxml2-dev libssl-dev libncurses5-dev libgd-dev
#libdb-dev  是 Berkeley数据库（Berkeley DB）的开发库。Berkeley DB是一个嵌入式数据库引擎，通常用于存储和管理应用程序的数据

#libxml2-dev ，libxml2是一个用于解析和操作XML文档的库。它允许开发人员在应用程序中进行XML文档处理，包括解析、创建、修改和查询XML文档
#libssl-dev  这是OpenSSL的开发库，允许开发人员在应用程序中使用SSL/TLS加密和安全通信，保护数据在传输过程中的安全性
#libncurses5-dev ncurses是一个库，用于在终端上创建文本用户界面（TUI）
#libgd-dev GD（Graphics Draw）图形库的开发库。GD库允许开发人员在应用程序中创建和操作图像，进行图形绘制和处理，用于生成图形和图表

# sudo apt-get -y install gdal-bin gdal-data libgdal-dev # /usr/lib/libgdal.so: undefined reference to `TIFFReadDirectory@LIBTIFF_4.0'
# sudo apt-get -y install libgsl0ldbl libgsl0-dev

# Gtk stuff, Need by alignDB
# install them in a fresh machine to avoid problems
echo "==> Install gtk3"
#sudo apt-get -y install libcairo2-dev libglib2.0-0 libglib2.0-dev libgtk-3-dev libgirepository1.0-dev
#sudo apt-get -y install gir1.2-glib-2.0 gir1.2-gtk-3.0 gir1.2-webkit-3.0

echo "==> Install gtk3 related tools"
# sudo apt-get -y install xvfb glade

echo "==> Install graphics tools"
sudo apt-get -y install gnuplot graphviz imagemagick
# gnuplot 用于创建各种类型的图表和图形 散点图、线图、柱状图、等高线图
# graphviz  于绘制图形和图形的开源工具集。它提供了各种绘图布局算法，用于可视化关系图、流程图、组织结构 可以自动渲染
# imagemagick 一个功能强大的图像处理工具集，用于创建、编辑和转换图像
# 
# 
#echo "==> Install nautilus plugins"
#sudo apt-get -y install nautilus-open-terminal nautilus-actions

# Mysql will be installed separately.
# Remove system provided mysql package to avoid confusing linuxbrew.
echo "==> Remove system provided mysql"
# sudo apt-get -y purge mysql-common

echo "==> Restore original sources.list"
if [ -e /etc/apt/sources.list.bak ]; then
	# apt Advanced Packaging Tool 用于管理软件包的工具
    sudo rm /etc/apt/sources.list
    sudo mv /etc/apt/sources.list.bak /etc/apt/sources.list
fi

echo "====> Basic software installation complete! <===="
