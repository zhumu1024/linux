# linux
The knowledge of linux
## 大段代码学习及注释--生信学习文档--[linux部分](https://github.com/wang-q/ubuntu/blob/master/README.md?plain=1)

此处暂时记录不便记录在笔记本上的大段代码及其学习和代码记录

### install linuxbrew板块 
```shell
if grep -q -i Homebrew $HOME/.bashrc; then
    echo "==> .bashrc already contains Homebrew"
else
    echo "==> Update .bashrc"

    echo >> $HOME/.bashrc
    # >> 追加内容，区别于>的清除文档内容后重定向
    # 在$HOME/.bashrc的底部添加一行空格，提高可读性
    echo '# Homebrew' >> $HOME/.bashrc
    #添加注释（名字）
    echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >> $HOME/.bashrc
    #将 Homebrew 的可执行文件路径添加到 .bashrc 文件的 PATH 变量
    #brew --prefix 会返回 Homebrew 的安装根目录的路径 ：这是路径分隔符
    # 三引号在这里是 确保将整个 $PATH 作为单个参数传递给 echo，而不会被解释为多个参数
    echo "export MANPATH='$(brew --prefix)/share/man'":'"$MANPATH"' >> $HOME/.bashrc
    #将 Homebrew 的 man 页面路径添加到 .bashrc 文件的 MANPATH 变量中，以确保用户可以访问 Homebrew 安装的程序的文档
    echo "export INFOPATH='$(brew --prefix)/share/info'":'"$INFOPATH"' >> $HOME/.bashrc
    #将 Homebrew 的 info 页面路径添加到 .bashrc 文件的 INFOPATH 变量中，以确保用户可以访问 Homebrew 安装的程序的信息页面
    echo "export HOMEBREW_NO_ANALYTICS=1" >> $HOME/.bashrc
    #禁用 Homebrew 的分析功能，确保用户的使用数据不会被 Homebrew 收集
    echo "export HOMEBREW_NO_AUTO_UPDATE=1" >> $HOME/.bashrc
    #禁止自动更新
    echo 'export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"' >> $HOME/.bashrc
    #配置 Homebrew 使用清华大学的 Git 镜像服务来获取 brew 仓库的更新
    echo 'export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"' >> $HOME/.bashrc
    # 配置 Homebrew 使用清华大学的 Git 镜像服务来获取 homebrew-core 仓库的更新
    echo 'export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"' >> $HOME/.bashrc
    #配置 Homebrew 使用清华大学的镜像服务来获取二进制包（bottles）
    echo >> $HOME/.bashrc
fi

source $HOME/.bashrc
#加载，更新


```

### Install packages managed by Linuxbrew板块

此处对一个完整的.sh文件中的代码进行注释及学习，希望掌握.sh文件处理任务的脉络。

```bash
#!/bin/bash
# 特殊字符序列，通常称之为 shebang。用于指定执行脚本的解释器。

export HOMEBREW_NO_AUTO_UPDATE=1
#设置homebrew关掉自动更新
# export ALL_PROXY=socks5h://localhost:1080
#由于已经开了代理，所以可以不用这一行。

# Clear caches
rm -f $(brew --cache)/*.incomplete
#brew 是 Homebrew 软件包管理器的命令行工具，brew --cache 用于查找 Homebrew 缓存目录的路径。
#*.incomplete 缓存文件

echo "==> gcc"
RELEASE=$( ( lsb_release -ds || cat /etc/*release || uname -om ) 2>/dev/null | head -n1 )
#获取linux系统的版本信息 详见笔记本，此段代码不进行详细分析
if [[ $(uname) == 'Darwin' ]]; then
    brew install pkg-config
    #pkg-config通常用于在构建软件时获取正确的库和头文件路径，以确保软件能够正确链接到所需的库。
else
    if echo ${RELEASE} | grep CentOS > /dev/null ; then
        brew install gcc
        #gcc 是一种开源编译器，用于将源代码文件编译成可执行程序（机器代码）。
        brew install pkg-config
        brew unlink pkg-config
        # unlink 取消链接 取消链接后，该软件包的可执行文件将不会出现在系统的可执行文件路径中，但仍然可以使用 brew link pkg-config 重新链接它
    else
        brew install gcc
        brew install pkg-config
        brew unlink pkg-config
    fi
fi


# perl
echo "==> Install Perl 5.34"
brew install perl
#下载perl

if grep -q -i PERL_534_PATH $HOME/.bashrc; then
#在$HOME/.bashrc中搜索PERL_534_PATH -q：quiet 静默 -i：ignore case 忽略大小写
    echo "==> .bashrc already contains PERL_534_PATH"
else
    echo "==> Updating .bashrc with PERL_534_PATH..."
    PERL_534_BREW=$(brew --prefix)/Cellar/$(brew list --versions perl | sed 's/ /\//' | head -n 1)    
    #设置一个名为 PERL_534_BREW 的环境变量，存储 Perl 编程语言的安装路径
    # $(brew --prefix) $( ) 命令替换 brew --prefix：获取 Homebrew 软件包管理器的安装路径，通常是 /usr/local
    # brew list --versions perl 列出已安装的 Perl 版本及其路径
    # sed 强大的文本工具 's/ /\//'  文本替换：sed 's/old_pattern/new_pattern/g' input_file 功能空格替换为斜杠（/），但/为特殊字符，需要\来转义一下
     

    PERL_534_PATH="export PATH=\"$PERL_534_BREW/bin:\$PATH\""
    #perl的环境变量

    echo '# PERL_534_PATH' >> $HOME/.bashrc
    echo $PERL_534_PATH    >> $HOME/.bashrc
    #内容追加
    echo >> $HOME/.bashrc

    # make the above environment variables available for the rest of this script
    eval $PERL_534_PATH
    # eval 执行后面变量中的命令
fi

hash cpanm 2>/dev/null || {
# hash 是一个 Bash 内建命令，它的作用是用于跟踪并查找可执行程序的路径 cpanm：perl的安装模块
# || 或命令，当前一个命令无法执行时，执行下一个命令
# { } 代表代码块的开始和结束
    curl -L https://cpanmin.us |
        perl - -v --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ App::cpanminus
        #使用 Perl 解释器执行一个命令，该命令下载并安装 cpanm 工具，确保只从指定的 CPAN 镜像站点下载
        # perl 使用perl解释器
        # --v 显示版本信息
        # -- mirror-only 指定下载的镜像源
        #App::cpanminus   cpanm 工具的 Perl 模块版本。
}

# Some building tools
echo "==> Building tools"
brew install autoconf libtool automake # autogen
#autoconf, libtool, automake：这些工具通常被一起使用，它们属于 GNU Build System 的一部分，用于自动化软件的配置和构建过程
    #autoconf：生成用于配置软件的脚本，使软件能够在不同的系统上构建。
    #libtool：管理库文件的创建和使用，允许跨平台的库文件共享。
    #automake：用于生成 Makefile，以便可以轻松地构建和编译软件。
brew install cmake
#CMake 是一个跨平台的开源构建系统，可以生成适用于不同编译器和平台的构建文件，使软件能够在各种操作系统上构建。
brew install bison flex
#解析器生成器和词法分析器生成器，通常用于编译器和解释器的开发。它们用于生成解析语法和词法规则的 C 代码

# libs
brew install gd gsl jemalloc boost # fftw
#gd：通用图像处理库，用于创建和操作图像。
#gsl：GNU Scientific Library，提供一组数学函数和工具，用于科学计算。
#jemalloc：一种内存分配器，用于管理内存分配和释放。
#boost：C++ 库集合，提供各种数据结构和算法，用于 C++ 编程。

brew install libffi libgit2 libxml2 libgcrypt libxslt
#libffi：外部函数接口库，用于在不同编程语言之间进行函数调用。
#libgit2：用于与 Git 存储库进行交互的库，可用于创建 Git 客户端或工具。
#libxml2：一种用于解析和生成 XML 文档的库。
#libgcrypt：GNU Privacy Guard (GnuPG) 的一部分，提供加密和解密功能。

brew install pcre libedit readline sqlite nasm yasm
#pcre：Perl Compatible Regular Expressions，用于处理正则表达式的库。
#libedit：提供基本的行编辑功能，通常用于命令行界面。
#readline：GNU Readline 库，用于创建命令行界面的交互性。
#sqlite：嵌入式关系型数据库管理系统。
#nasm：Netwide Assembler，用于汇编语言程序的开发。
#yasm：一种汇编语言编译器，用于创建汇编语言程序。

brew install bzip2 gzip libarchive libzip xz
#bzip2：用于数据压缩和解压的开源压缩库。
#gzip：用于文件压缩和解压的工具和库。
#libarchive：用于操作各种归档文件格式（如 tar 和 zip）的库。
#libzip：用于创建和操作 ZIP 文件格式的库。

#这一部分是下载python的，和之前下载homebrew很像，不再详细注释
brew install python@3.9

if grep -q -i PYTHON_39_PATH $HOME/.bashrc; then
    echo "==> .bashrc already contains PYTHON_39_PATH"
else
    echo "==> Updating .bashrc with PYTHON_39_PATH..."
    PYTHON_39_PATH="export PATH=\"$(brew --prefix)/opt/python@3.9/bin:$(brew --prefix)/opt/python@3.9/libexec/bin:\$PATH\""
    echo '# PYTHON_39_PATH' >> $HOME/.bashrc
    echo ${PYTHON_39_PATH} >> $HOME/.bashrc
    echo >> $HOME/.bashrc

    # make the above environment variables available for the rest of this script
    eval ${PYTHON_39_PATH}
    # ${ } 用于变量替换
fi

# Upgrading pip breaks pip
#pip3 install --upgrade pip setuptools wheel
# pip3：这是 Python 包管理工具（pip）的 Python 3 版本。pip 用于安装和管理 Python 包和依赖项。
# --upgrade：指示 pip 更新已安装的包到最新版本
#pip 是 Python 包管理工具本身的包。setuptools 是用于构建、分发和安装 Python 包的库。wheel 是 Python 包的二进制分发格式，它可以加快包的安装速度。

# r
#下载r，和之前类似，不再详细注释
# brew install wang-q/tap/r@3.6.1
hash R 2>/dev/null || {
    echo "==> Install R"
    brew install r
}

cpanm --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ --notest Statistics::R
#Perl 模块会附带一组测试用例，以确保模块的正确性和稳定性。这些测试用例在安装模块时自动运行，以验证模块是否按预期工作。
#--notest 的作用是告诉 cpanm 在安装 Perl 模块时不运行测试。

# java
echo "==> Install Java"
if [[ "$OSTYPE" == "darwin"* ]]; then
#$OSTYPE 是一个环境变量，用于存储操作系统类型的信息。
#检查 $OSTYPE 的值是否以 "darwin" 开头，如果是，就表示当前操作系统是 macOS
    brew install openjdk
    #OpenJDK 是一个开源的 Java 开发工具包，它包含 Java 编译器、运行时环境、类库和工具，允许开发者创建和运行 Java 应用程序
else
    brew install openjdk
    # brew link openjdk --force
fi

brew install ant maven
#Ant,更灵活，使用 XML 文件来定义构建任务和依赖关系，可以用于编译、打包、测试和部署 Java 应用程序等任务,特别适用于管理和构建 Java 项目。
# Maven,更加规范化，提供了一种一致的方式来构建、测试、打包和发布 Java 项目，同时管理项目的依赖项。

# pin these
# brew pin perl
# brew pin python@3.9
# brew pin r

# other programming languages
brew install lua node
#Lua 编程语言的解释器，Node.js，用于构建服务器端和网络应用程序的 JavaScript 运行时

# taps
brew tap wang-q/tap
#tap 是 brew 命令的一个子命令，用于管理 Brew 中的软件包仓库。这行命令是将wang-q/top这个库添加到brew的库中去。

# downloading tools
brew install aria2 curl wget
#三个下载工具

# gnu
brew install gnu-sed gnu-tar
#gnu版本，相较于普通版本（更重视兼容性）更重视功能性和扩展性

# other tools
#详细请看[tools](https://github.com/zhumu1024/tools-for-bio/edit/main/README.md) 
brew install screen stow htop parallel pigz
brew install tree pv
brew install jq jid pup
brew install datamash miller tsv-utils
brew install librsvg udunits
brew install proxychains-ng

brew install bat exa tealdeer # tiv
brew install hyperfine ripgrep tokei
brew install bottom # zellij

# large packages
if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install gpg2
fi

hash pandoc 2>/dev/null || {
    brew install pandoc
}

hash gnuplot 2>/dev/null || {
    brew install gnuplot
}

hash dot 2>/dev/null || {
    brew install graphviz
}

hash convert 2>/dev/null || {
    brew install imagemagick
}

# weird dependancies by Cairo.pm
#安装一些 X Window System 相关的开发库和协议，用于支持图形用户界面（GUI）应用程序的构建和运行
# brew install linuxbrew/xorg/libpthread-stubs linuxbrew/xorg/renderproto linuxbrew/xorg/kbproto linuxbrew/xorg/xextproto

# gtk+3
#支持 GTK+3（GIMP Toolkit）和图形应用程序的构建和运行
# brew install gsettings-desktop-schemas gtk+3 adwaita-icon-theme gobject-introspection







```



