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
# hash 是一个 Bash 内建命令，它的作用是用于跟踪并查找可执行程序的路径 cpanm：Comprehensive Perl Archive Network cpan-perl的安装模块  m min
# || 或命令，当前一个命令无法执行时，执行下一个命令
# { } 代表代码块的开始和结束
    curl -L https://cpanmin.us |
        perl - -v --mirror-only --mirror http://mirrors.ustc.edu.cn/CPAN/ App::cpanminus
        #使用 Perl 解释器执行一个命令，该命令下载并安装 cpanm 工具，确保只从指定的 CPAN 镜像站点下载
        # perl 使用perl解释器
        # --v 显示版本信息 verbose
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
"
screen: 一个终端复用工具，可以让你在一个终端窗口中同时运行多个终端会话。

stow: 一个符号链接管理工具，通常用于管理安装在系统中的软件包的配置文件，使得它们更容易管理和组织。

htop: 一个交互式的系统监控工具，用于查看系统资源的使用情况（CPU、内存等）。

parallel: 一个并行处理工具，可以同时在多个处理器核心上运行任务，加速处理过程。

pigz: 一个并行压缩工具，是gzip的替代品，能够利用多核心进行文件压缩，加快压缩速度。

tree: 用于以树形图形式显示文件和目录结构的命令行工具，便于查看文件层次结构。

pv: 一个数据流管道进度条工具，可以显示数据在管道中传输的进度。

jq: 一个用于处理和查询 JSON 数据的命令行工具，可以提取、转换和格式化JSON数据。

jid: 用于将JSON数据以交互式的方式展示为表格形式。

pup: 一个命令行工具，用于解析HTML并进行数据提取、筛选和转换。

datamash: 用于对文本和数字数据进行统计、操作和计算的命令行工具。

miller: 一个用于处理文本数据的工具，支持各种操作如排序、过滤、格式化等。

tsv-utils: 专门用于处理制表符分隔值（TSV）文件的工具集。

librsvg: 一个用于渲染SVG格式图片的库。

udunits: 一个用于处理单位和转换的库，支持不同单位之间的转换和比较。

proxychains-ng: 一个用于在命令行下使用代理的工具，通过该工具可以在命令行中使用代理访问网络资源。
"

brew install bat exa tealdeer # tiv
brew install hyperfine ripgrep tokei
brew install bottom # zellij
"
bat: 一个 cat 命令的替代品，具有语法高亮和 Git 集成等功能，用于查看文件内容。

exa: 一个 ls 命令的替代品，提供更好的文件列表显示，包括颜色和图标标识。

tealdeer: 一个快速的命令行工具，用于查看 man 手册的简化版本，以便快速了解命令用法。

hyperfine: 用于测试程序执行时间的命令行工具，可以对比不同程序的性能。

ripgrep: 一个高效的文本搜索工具，类似于 grep，但更快速和功能更丰富。

tokei: 一个代码统计工具，可以统计源代码的行数、文件数以及语言使用情况。

bottom: 一个跨平台的系统资源监控工具，提供图形化的命令行界面以显示系统的资源使用情况。

"
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
"
gpg2: GnuPG（GPG）的一个版本，用于加密和签名数据，保护数据的安全性。

pandoc: 一个文档格式转换工具，支持多种格式之间的转换，如Markdown到HTML、LaTeX到Word等。

gnuplot: 一个用于绘制数据和图表的工具，支持多种绘图类型。

graphviz: 一个用于绘制图形和网络图的工具，可以用来创建各种类型的图表。

imagemagick: 一个用于创建、编辑、合成图片的工具，支持各种图片格式的处理和转换。

"
# weird dependancies by Cairo.pm
#安装一些 X Window System 相关的开发库和协议，用于支持图形用户界面（GUI）应用程序的构建和运行
# brew install linuxbrew/xorg/libpthread-stubs linuxbrew/xorg/renderproto linuxbrew/xorg/kbproto linuxbrew/xorg/xextproto

# gtk+3
#支持 GTK+3（GIMP Toolkit）和图形应用程序的构建和运行
# brew install gsettings-desktop-schemas gtk+3 adwaita-icon-theme gobject-introspection


  
