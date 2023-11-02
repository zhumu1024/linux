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
