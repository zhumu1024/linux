#!/usr/bin/env bash

echo "====> Building Genomics related tools <===="

echo "==> Anchr"
# TODO: superreads can't find `jellyfish/circular_buffer.hpp`
#TODO 通常是一种标记或注释，表示需要在之后完成或解决的任务

# # super reads  错误率低的illumina短reads来搭建较长的super-reads  
# 
#  jellyfish 计数 DNA 的 k-mers 的软件。该软件运用 Hash 表来存储数据，同时能多线程运行，速度快，内存消耗小
# Reads"（序列）是指从DNA测序技术中得到的短片段DNA序列。通常这些序列长度较短，可能只有几百个碱基对长。
# Contigs"（连读）是通过将读取序列拼接在一起来形成更长的序列。Contigs相对较长，可能达到数千个碱基对长，但它们可能仍然缺少一些重要的信息，例如重复序列或缺失区域。
# "k-mers"（k个核苷酸长度的片段）是将读取序列分割成长度为k的小片段。它们可以用于重组读取序列以生成contigs或完整的基因组序列。
# 相邻k-mers有且仅有一个碱基差异。  Contig的长度与k值的大小密切相关。k值越大，k-mers能跨过更多长度较短的重复序列，有利于Contig的组装，
# 何事都有两面，k值越大，得到的k-mers的数量会越少，k-mers彼此相连，建立感情的机会就越少，反而不利于Contig的组装
# 
#  circular_buffer顾名思义是一个循环缓冲器，其 capcity是固定的当容量满了以后，插入一个元素时，会在容器的开头或结尾处删除一个元素。
# 缓冲区满了后，新数据会覆盖掉最老的数据。循环缓冲区适用于需要持续更新数据并限制内存使用的情况
#
#.hpp 文件是 C++ 编程语言中用于存储 C++ 头文件的扩展名

#   `include/jellyfish-2.2.4/`
#include 目录通常用于存放头文件（header files）。头文件包含了函数、类或其他源代码文件的声明，允许其他源代码文件在程序编译时引用和使用这些声明

#curl -fsSL https://raw.githubusercontent.com/wang-q/App-Anchr/master/share/install_dep.sh | bash

echo "==> Install bioinformatics softwares"

brew tap brewsci/bio
# brew tap 没有参数会自动更新已经存在的tap并列出当前已经tapped的仓库 
# Tap 是 Homebrew 中的一个概念，它允许用户添加额外的软件包仓库，以便安装和管理其他软件包
# brewsci/bio 提供生物信息学公式
brew tap brewsci/science  
# 用于科学和科学计算领域的软件包的仓库

brew install clustal-w mafft muscle trimal

#Multiple sequence alignment；MSA 多重序列比对
#
# clustal-w 多序列比对工具 涉及的核酸、蛋白质的全局多序列比对，为进一步构建分子进化树等进化分析提供了基础 
# 			GUI版的叫做ClustalX, 命令行版叫做ClustalW; 最新版本叫做Omega, 只提供了命令行版
# 			采用渐进多序列比对算法
# 			
# 动态规划算法的工具有MSA；渐进多序列比对算法的工具有Clustal家族（包括Clustalx和Clustalw；
# 迭代法工具有PRRN/PRRP、DIALIGN、MUSCLE以及目前最常用的MAFFT；
# 基于一致性算法的工具有ProbCons和MergeAlign，此外还有T-Coffee系列软件。
# 多重序列比对软件－MAFFT 迭代法 准确度也很高
# muscle  迭代法 
# 
# ClustalW的时间复杂度是O（N^4+L^2）,MUSCLE的时间复杂度是O（N^4+NL^2）
# 
# trimal 用于对多序列比对进行剪枝和过滤的工具，通常用于生物信息学和分子进化研究
# 		删除具有大量缺失数据的序列、删除低信息内容的列、删除高度变异的区域等。
# 		剪枝的目标是获得干净、紧凑且具有高质量信息的比对，以便进一步的生物信息学分析，
# 		如系统发育树构建、进化分析和蛋白质结构预测。
# 		
brew install lastz diamond paml fasttree iqtree # raxml
# lastz Blastz的替代实现版，进行两个序列之间的比对
# diamond diamon的功能就是将蛋白或者翻译后的核苷酸和蛋白数据库进行比对，没有BLAST那么多功能，但比较快 
# 			支持建库  blastp 蛋白质序列去蛋白质数据库。 
# 			blastx 将核酸按照6种翻译成蛋白质序列再在蛋白质里进行搜索 DNA序列可以按六种框架阅读和翻译（核酸有两条链，每条链三种，对应三种不同的起始密码子）
# 
# paml 利用DNA或Protein数据使用最大似然法进行系统发育分析的软件，不擅长构树，但能用于评估系统进化过程中的参数和假设检验
# fasttree 基于最大似然法构建进化树的软件，它最大的特点就是运行速度快，支持几百万条序列的建树任务。而且可以返回每个节点的可信度
# 			官方的说法是，对于大的比对数据集，FastTree 比phyml或者RAxML 快100到1000倍  
# 			内存优化策略 近似  启发式算法
# 
# iqtree 最大似然法建树
# 	
# Mega (Molecular Evolutionary Genetics Analysis)：Mega 是一种集成的分子生物学工具，包括构建分子发育树的功能。
# 															它提供了直观的用户界面，适用于生物学家和分子生物学研究人员。		
# RAxML 是一种高度用于构建进化树的工具，以其速度和准确性而闻名，使用人数最多
brew install fastani mash
#FastANI（Fast Average Nucleotide Identity）是一种用于计算核酸序列的平均核苷酸相似性（ANI）的快速工具 计算速度比blast提高，精度差距不大
#											ANI被定义为两个微生物基因组同源片段之间平均的碱基相似度，他的特点是在近缘物种之间有较高的区分度
#											
#Mash通过把大的序列集合简化成小的sketch，从而快速计算它们之间的广义突变距离（global mutation distances，
#	 可以近似地理解为『进化距离』，越大表示两者之间亲缘关系越近，如果是0，表示同一物种）。 两条序列分化之后，每个同源位点上发生碱基替换的次数。
	 # 突变距离 DNA中的一个核苷酸序列变为另一个核苷酸序列时，所需要的最少数量的突变性改变

brew install raxml --without-open-mpi
#RAxML (Random Axelerated Maximum Likelikhood) 能使用多线程或并行化使用最大似然法构建进化树。 使用人数很多
# --without-open-mpi 禁用 Open MPI 支持，将所有计算限制在单个节点上，可能会导致较长的计算时间，特别是在处理大规模数据集时
brew install --force-bottle newick-utils
# Newick Utilities是一套用于处理系统发育树的unix shell工具，其功能包括重置根（re-root）、提取子树、修剪、合并枝以及可视化
# --force-bottle 强制安装软件包的二进制预编译版本（称为“瓶装”）而不是从源代码构建
#
brew install bowtie bowtie2 bwa samtools
#bowtie来map DNA测序 bowtie1出现的早，所以对于测序长度在50bp以下的序列效果不错，而bowtie2主要针对的是长度在50bp以上的测序的。 map到参考基因组上
#Bowtie 输出比对结果，通常是一个 SAM（Sequence Alignment/Map）文件  Bowtie 2 输出比对结果，同样通常是一个 SAM 文件，还可以是更紧凑的bam文件
#sam文件 头部区：以’@'开始，体现了比对的一些总体信息。比如比对的SAM格式版本，比对的参考序列，比对使用的软件等。 主体区：比对结果
#BWA来进行ChIP-seq测序
#
#
# Samtools是一个用来处理SAM/BAM（SAM的二进制格式，用于压缩空间）格式的比对文件的工具，
# 它能够输入和输出SAM（sequence alignment/map：序列比对）格式的文件，对其进行排序、合并、建立索引等处理。建立索引是为了提高 SAM/BAM 文件的查询和访问效率
brew install stringtie hisat2 # tophat cufflinks 
# hisat2 应用了起源于最优化理论的网络流算法，与可选择的从头组装策略一起来将这些短读段组装成转录本 
#  "Hierarchical Indexing for Spliced Alignment of Transcripts 2"，它是一个用于RNA-Seq数据分析的工具
# +stringtie 进行转录本组装并预计表达水平
brew install seqtk minimap2 minigraph # gfatools
#seqtk 日常序列的处理包括，比如：fq转换为fa，格式化序列，截取序列，随机抽取序列等
#minimap2 针对三代数据开发的比对工具
#minigraph   Minimap2 软件包的一部分 于生成图形表示的轻量级工具，特别用于生物信息学中的序列比对和图形可视化
brew install genometools # igvtools
# 处理和分析生物数据，尤其是基因组数据 基因组序列分析，注释，组装
brew install canu fastqc picard-tools samtools # kat
# canu Canu是基于OLC算法，具有长reads的自纠错和组装功能，是应用最为广泛的三代组装软件
# fastqc 执行一些简单的质量控制检查，以获得较好的原始数据，并且确保数据中没有任何问题或偏差 
# picard-tools 处理和分析DNA测序数据的开源工具集，它提供了一系列命令行工具，用于质量控制、格式转换、标记重复序列、统计测序库性质等多个任务
brew install --build-from-source snp-sites # macOS bottles broken
# 从多FASTA比对中快速提取SNP，并且可以输出多种格式的结果以供下游分析
# --build-from-source 从源代码进行构建 更加灵活

brew install bcftools
#处理和分析 VCF（Variant Call Format）文件的开源工具集。VCF文件通常用于存储基因组中的变异信息，
#                                    如单核苷酸多态性（SNPs）、插入/缺失（indels）和结构变异等
#VCF（Variant Call Format）格式是记录测序结果里相对于参考序列的序列变异情况 
#
brew install edirect
#将xml结果根据需要转换为各种形式的表格形式，方便导入DB或可视化结果
brew install sratoolkit
#处理高通量测序数据的软件包，它提供了一系列命令行工具来下载、转换和处理测序数据
# less used
brew install augustus prodigal
brew install megahit spades sga
brew install quast --HEAD
brew install ntcard
brew install gatk freebayes

"
Augustus: 一个用于预测真核生物基因结构的软件，即基因预测软件，可预测基因的外显子和内含子等。

Prodigal: 用于识别原核生物基因的软件，特别擅长于识别原核生物的基因组中的蛋白编码序列。

MEGAHIT, SPAdes, SGA: 这些都是用于对高通量测序数据进行基因组组装的工具。它们能够将碎片化的DNA片段拼接成完整的基因组。

QUAST: 用于对基因组组装结果进行质量评估的工具，能够比较不同组装结果之间的差异。

ntCard: 用于基因组的 k-mer 计数和相似性估计的工具，特别用于大基因组的快速处理。

GATK (Genome Analysis Toolkit): 一个用于对高通量测序数据进行变异分析的软件套件，能够识别 SNP、Indel 等变异。

FreeBayes: 另一个用于变异检测的工具，能够从测序数据中发现单核苷酸多态性。
"
# brew unlink proj
brew install --force-bottle blast
#blast: BLAST（Basic Local Alignment Search Tool）是一种用于在生物信息学中搜索相似性的工具，可用于比对序列和数据库搜索。
echo "==> Custom tap"
brew tap wang-q/tap
#tap 是一个用于扩展 Homebrew 功能的机制。它允许用户添加额外的自定义仓库，类似于软件包管理器中的“源”或“存储库”
brew install faops multiz sparsemem intspan
"
faops: 用于对FASTA格式的核酸序列文件进行操作，比如提取、合并、比较、过滤等功能。能够对序列进行多种操作和处理。

multiz: 用于多序列比对的工具，可用于比对多个DNA或蛋白质序列，有助于识别共同特征和区域。

sparsemem: 是一种基于最小唯一匹配长度的字符串匹配工具，通常用于序列比对和查找相似性序列。

intspan: 用于对整数集合进行操作和计算，这在某些基因组学的分析和操作中很有用，例如区域的定义和检测。
"
# brew install multiz --cc=gcc
# brew install jrunlist jrange

echo "==> circos"
brew install wang-q/tap/circos@0.69.9
#Circos是一种数据可视化工具，用于绘制环状图表，通常用于展示基因组中的结构和特征。
echo "==> RepeatMasker"
brew install hmmer easel
# HMMER是用于在蛋白质数据库中进行隐马尔可夫模型搜索的工具，easel是其依赖库。
brew install wang-q/tap/rmblast@2.10.0
# RepeatMasker是用于检测和标记基因组中重复序列的工具。
# brew link rmblast@2.10.0 --overwrite

brew install wang-q/tap/trf@4
#Tandem Repeats Finder，用于识别DNA序列中的串联重复序列。
brew install wang-q/tap/repeatmasker@4.1.1
#用于基因组中重复序列检测和标记的工具。通常需要配合相应的数据库使用。
#基因组重复序列检测
# Config repeatmasker
pip3 install h5py
#一个Python库，用于处理HDF5格式数据。
#HDF5被广泛应用于存储和管理大规模数据，包括遥感图像、生物医学图像、气候模拟、高能物理实验数据等
#
cd $(brew --prefix)/Cellar/repeatmasker@4.1.1/4.1.1/libexec
#(brew --prefix 会返回brew的安装目录
#Cellar 目录下通常包含了安装的软件包的不同版本。每个软件包的不同版本都会被安装在 Cellar 目录中
# 
#
#libexec 目录通常包含了软件包的执行文件和相关的库文件。这是软件包的核心文件，用于运行和执行软件。
#@ 符号通常表示软件包的名称和版本
perl configure \
    -hmmer_dir=$(brew --prefix)/bin \
    #HMMER 是一个用于在蛋白质数据库中进行隐马尔可夫模型（HMM）搜索的工具 
    #指定安装目录
    -rmblast_dir=$(brew --prefix)/Cellar/rmblast@2.10.0/2.10.0/bin \
    # RM-BLAST（RepeatMasker-BLAST）是一个修改版的NCBI BLAST（Basic Local Alignment Search Tool）软件，专门用于RepeatMasker工具的序列比对。
    # RepeatMasker是一个用于发现和标记基因组中重复元件（如转座子、低复杂度序列等）的工具。
    # Cellar 目录下通常包含了安装的软件包的不同版本。每个软件包的不同版本都会被安装在 Cellar 目录中
    # 
    -libdir=$(brew --prefix)/Cellar/repeatmasker@4.1.1/4.1.1/libexec/Libraries \
    #指定RepeatMasker所需的库文件目录
    -trf_prgm=$(brew --prefix)/bin/trf \
    #Tandem Repeats Finder（TRF）是一种用于发现DNA序列中串联重复序列的工具。串联重复是指基因组中出现的相邻、重复出现的序列单元。
    #指定Tandem Repeats Finder (TRF) 的位置，$(brew --prefix)/bin/trf是TRF程序的路径
    -default_search_engine=rmblast

# 指定特定版本或位置的依赖项 避免不同版本之间的冲突

cd -
#cd - 可以切换到上次访问的目录
#
#
#
#echo "==> Config repeatmasker"
#wget -N -P /tmp https://github.com/egateam/egavm/releases/download/20170907/repeatmaskerlibraries-20140131.tar.gz
#
#pushd $(brew --prefix)/opt/repeatmasker/libexec
#rm -fr lib/perl5/x86_64-linux-thread-multi/
#rm Libraries/RepeatMasker.lib*
#rm Libraries/DfamConsensus.embl
#tar zxvf /tmp/repeatmaskerlibraries-20140131.tar.gz
#sed -i".bak" 's/\/usr\/bin\/perl/env/' configure.input
#./configure < configure.input
#popd
