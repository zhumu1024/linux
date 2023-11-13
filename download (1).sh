#!/usr/bin/env bash

echo "====> Download Genomics related tools <===="

mkdir -p $HOME/bin
mkdir -p $HOME/.local/bin
mkdir -p $HOME/share
mkdir -p $HOME/Scripts

# make sure $HOME/bin in your $PATH
if grep -q -i homebin $HOME/.bashrc; then
    echo "==> .bashrc already contains homebin"
else
    echo "==> Update .bashrc"

    HOME_PATH='export PATH="$HOME/bin:$HOME/.local/bin:$PATH"'
    echo '# Homebin' >> $HOME/.bashrc
    echo $HOME_PATH >> $HOME/.bashrc
    echo >> $HOME/.bashrc

    eval $HOME_PATH
fi

# Clone or pull other repos
for OP in dotfiles; do
    if [[ ! -d "$HOME/Scripts/$OP/.git" ]]; then
        if [[ ! -d "$HOME/Scripts/$OP" ]]; then
            echo "==> Clone $OP"
            git clone https://github.com/wang-q/${OP}.git "$HOME/Scripts/$OP"
        else
            echo "==> $OP exists"
        fi
    else
        echo "==> Pull $OP"
        pushd "$HOME/Scripts/$OP" > /dev/null
        git pull
        popd > /dev/null
    fi
done

# alignDB
# chmod +x $HOME/Scripts/alignDB/alignDB.pl
# ln -fs $HOME/Scripts/alignDB/alignDB.pl $HOME/bin/alignDB.pl

echo "==> Jim Kent bin"
cd $HOME/bin/
RELEASE=$( ( lsb_release -ds || cat /etc/*release || uname -om ) 2>/dev/null | head -n1 )
if [[ $(uname) == 'Darwin' ]]; then
    curl -L https://github.com/wang-q/ubuntu/releases/download/20190906/jkbin-egaz-darwin-2011.tar.gz
else
    if echo ${RELEASE} | grep CentOS > /dev/null ; then
        curl -L https://github.com/wang-q/ubuntu/releases/download/20190906/jkbin-egaz-centos-7-2011.tar.gz
    else
        curl -L https://github.com/wang-q/ubuntu/releases/download/20190906/jkbin-egaz-ubuntu-1404-2011.tar.gz
    fi
fi \
    > jkbin.tar.gz

echo "==> untar from jkbin.tar.gz"
tar xvfz jkbin.tar.gz x86_64/axtChain
tar xvfz jkbin.tar.gz x86_64/axtSort
tar xvfz jkbin.tar.gz x86_64/axtToMaf
tar xvfz jkbin.tar.gz x86_64/chainAntiRepeat
tar xvfz jkbin.tar.gz x86_64/chainMergeSort
tar xvfz jkbin.tar.gz x86_64/chainNet
tar xvfz jkbin.tar.gz x86_64/chainPreNet
tar xvfz jkbin.tar.gz x86_64/chainSplit
tar xvfz jkbin.tar.gz x86_64/chainStitchId
tar xvfz jkbin.tar.gz x86_64/faToTwoBit
tar xvfz jkbin.tar.gz x86_64/lavToPsl
tar xvfz jkbin.tar.gz x86_64/netChainSubset
tar xvfz jkbin.tar.gz x86_64/netFilter
tar xvfz jkbin.tar.gz x86_64/netSplit
tar xvfz jkbin.tar.gz x86_64/netSyntenic
tar xvfz jkbin.tar.gz x86_64/netToAxt
"
axtChain: 用于比对DNA序列，生成相似性链（axt格式）。
#通常被用于描述两个基因组序列之间的相似性，特别是在进化和比对分析中。典型的aXt格式可能包含注释行和对齐的序列信息

axtSort: 对比对的DNA序列（axt格式）进行排序。
axtToMaf: 将axt格式的比对序列转换为多重比对格式（maf格式）。
#存储多个DNA序列的比对信息的标准格式
#MAF格式常被用于存储和交换基因组序列的比对数据，特别是在进行物种间的比对、演化分析和功能注释时。

chainAntiRepeat: 从比对的序列中去除重复的部分。
chainMergeSort: 合并和排序比对的链（chain格式）。
chainNet: 创建和处理比对的链网络。
chainPreNet: 为链生成预处理文件，用于创建网络。
chainSplit: 拆分链文件为更小的部分。
chainStitchId: 用于连接和识别链中的片段。
faToTwoBit: 将FASTA格式的DNA序列转换为Twobit格式，一种用于快速DNA序列检索的二进制格式。
lavToPsl: 将比对的序列（lav格式）转换为比对统计（psl格式）。
netChainSubset: 从网络中提取特定区域的链。
netFilter: 过滤网络文件，保留指定条件下的数据。
netSplit: 拆分网络文件。
netSyntenic: 针对网络文件中的同源区域进行操作。
netToAxt: 将网络文件转换为比对序列（axt格式）。

"
mv $HOME/bin/x86_64/* $HOME/bin/
rm jkbin.tar.gz

if [[ $(uname) == 'Darwin' ]]; then
    curl -L http://hgdownload.soe.ucsc.edu/admin/exe/macOSX.x86_64/faToTwoBit
else
    curl -L http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/faToTwoBit
fi \
    > faToTwoBit
mv faToTwoBit $HOME/bin/
chmod +x $HOME/bin/faToTwoBit
