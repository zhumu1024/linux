#!/bin/bash
# hashbang 指定解释器
BASE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
#获取当前文件的相对路径 
#dirname 去掉路径中非目录的元素
#BASH_SOURCE[0] ： 得到当前文件的路径
#pwd printing working directory


cd "${BASE_DIR}" || exit
# 前往指定目录，否则exit 
#保证脚本不在错误的目录执行

hash cpanm 2>/dev/null || {
    curl -L https://cpanmin.us | perl - App::cpanminus
}
#寻找cpanm是否存在可执行文件 
#|| 或运算  下载  
#-L 支持重定向  | 管道  App::cpanminus：cpanm的per模块 
#
CPAN_MIRROR=https://mirrors.ustc.edu.cn/CPAN/
#指定镜像网站
NO_TEST=--notest
#下载时不进行例行的测试（下载板块自带一个例子文件进行测试）
# basic modules
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Archive::Extract Config::Tiny File::Find::Rule Getopt::Long::Descriptive JSON JSON::XS Text::CSV_XS YAML::Syck
#下载一些capnm的板块
# --mirror-only 指定使用镜像网站进行下载   --mirror 指定镜像网站的名字  
# $CPAN_MIRROR $NO_TEST 提供两个参数，下载网址及下载时不进行测试
# Archive::Extract：用于从归档文件中提取内容的模块。
# Config::Tiny：用于解析和操作INI格式配置文件的模块。
# File::Find::Rule：用于查找文件和目录的规则引擎模块。
# Getopt::Long::Descriptive：用于处理命令行选项和参数的模块。
# JSON 和 JSON::XS：用于JSON数据的解析和编码的模块。
# Text::CSV_XS：用于处理逗号分隔值（CSV）文件的模块。
# YAML::Syck：用于YAML数据的处理模块。
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST App::Ack App::Cmd DBI MCE Moo Moose Perl::Tidy Template WWW::Mechanize XML::Parser

# RepeatMasker need this
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Text::Soundex

# GD
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST GD SVG GD::SVG
"
App::Ack: 一个用于在文件中快速搜索指定内容的工具，常用于代码中的快速文本搜索。

App::Cmd: 一个用于编写命令行应用程序框架的工具。

DBI: 用于连接和操作数据库的Perl模块，提供了数据库无关的接口。

MCE: 多核编程工具，用于在多核和多CPU环境中进行并行编程。

Moo: 一个轻量级的面向对象编程框架，类似于Moose但更轻便。

Moose: 一个Perl面向对象编程框架，提供了强大的面向对象功能。

Perl::Tidy: 用于格式化Perl代码，使其具有一致的风格和可读性。

Template: 一个用于生成文本输出的模板工具，支持文本和HTML生成。

WWW::Mechanize: 一个用于模拟浏览器行为的工具，用于网络爬虫或自动化网页交互。

XML::Parser: 一个用于解析XML文件的工具。

Text::Soundex: 用于实现 Soundex 算法的模块，主要用于字符串的模糊匹配。

GD: 一个用于创建和操作图像的库。

SVG: 用于处理Scalable Vector Graphics（SVG）图像格式的模块。

GD::SVG: 结合了GD和SVG，使GD可以创建SVG格式的图像。
"
# bioperl
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Data::Stag Test::Most URI::Escape Algorithm::Munkres Array::Compare Clone Error File::Sort Graph List::MoreUtils Set::Scalar Sort::Naturally
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST HTML::Entities HTML::HeadParser HTML::TableExtract HTTP::Request::Common LWP::UserAgent PostScript::TextBlock
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST XML::DOM XML::DOM::XPath XML::SAX::Writer XML::Simple XML::Twig XML::Writer GraphViz SVG::Graph
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST SHLOMIF/XML-LibXML-2.0134.tar.gz
cpanm --mirror-only --mirror $CPAN_MIRROR --notest Convert::Binary::C IO::Scalar
cpanm --mirror-only --mirror $CPAN_MIRROR --notest CJFIELDS/BioPerl-1.007002.tar.gz

cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Bio::ASN1::EntrezGene Bio::DB::EUtilities Bio::Graphics
cpanm --mirror-only --mirror $CPAN_MIRROR --notest CJFIELDS/BioPerl-Run-1.007002.tar.gz # BioPerl-Run
"
Data::Stag: 用于处理结构化数据的模块，支持各种数据结构操作。

Test::Most: 提供了丰富的测试功能和断言工具，用于Perl测试。

URI::Escape: 用于对URI进行编码和解码的模块。

Algorithm::Munkres: 包含了Munkres/Kuhn算法的Perl实现，用于解决指派问题。

Array::Compare: 用于比较数组之间差异的模块。

Clone: 用于深度复制数据结构的模块。

Error: 用于提供错误处理和异常的模块。

File::Sort: 提供对文件进行排序操作的模块。

Graph: 用于处理和操作图结构的模块。

List::MoreUtils: 提供了更多用于列表操作的函数。

Set::Scalar: 用于处理和操作集合的模块。

Sort::Naturally: 自然排序字符串的模块。

HTML::Entities: 用于对HTML实体进行编码和解码的模块。

HTML::HeadParser: 用于解析HTML文档头部信息的模块。

HTML::TableExtract: 用于从HTML表格中提取数据的模块。

HTTP::Request::Common: 提供了HTTP请求的一些常用方法。

LWP::UserAgent: 用于发送HTTP请求的用户代理模块。

PostScript::TextBlock: 用于创建PostScript文档的模块。

XML::DOM: 用于操作DOM结构的XML处理模块。

XML::Simple: 用于简化XML数据处理的模块。

XML::Twig: 用于处理大型XML文件的模块。

XML::Writer: 用于创建XML文档的模块。

GraphViz: 用于生成GraphViz图形描述的模块。

SVG::Graph: 用于生成SVG格式图形的模块。

SHLOMIF/XML-LibXML-2.0134.tar.gz: XML::LibXML模块的特定版本。

Convert::Binary::C: 用于处理C语言结构体的模块。

IO::Scalar: 提供了对标量进行I/O操作的模块。

CJFIELDS/BioPerl-1.007002.tar.gz: 特定版本的BioPerl模块。

Bio::ASN1::EntrezGene: 用于解析NCBI EntrezGene数据库的模块。

Bio::DB::EUtilities: 用于访问NCBI EUtilities服务的模块。

Bio::Graphics: 用于绘制生物信息学图形的模块。

CJFIELDS/BioPerl-Run-1.007002.tar.gz: 特定版本的BioPerl-Run模块。
"
# circos
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Config::General Data::Dumper Digest::MD5 Font::TTF::Font Math::Bezier Math::BigFloat Math::Round Math::VecStat
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Params::Validate Readonly Regexp::Common Set::IntSpan Statistics::Basic Text::Balanced Text::Format Time::HiRes
"
Config::General: 一个用于处理配置文件的模块，可以解析各种格式的配置文件。

Data::Dumper: 用于将数据结构以字符串形式输出，通常用于调试和日志记录。

Digest::MD5: 用于生成和处理MD5哈希的模块，常用于数据完整性校验和加密相关操作。

Font::TTF::Font: 用于处理TrueType字体的模块，可以读取和修改字体文件。

Math::Bezier: 用于处理贝塞尔曲线的模块，支持贝塞尔曲线的计算和操作。

Math::BigFloat: 提供了任意精度的浮点数运算功能，用于处理大数值。

Math::Round: 用于数值舍入操作的模块。

Math::VecStat: 提供了对向量数据进行统计分析的功能。

Params::Validate: 用于验证和检查函数参数的模块。

Readonly: 用于创建只读变量的模块。

Regexp::Common: 提供了一系列常见正则表达式模式的模块，用于数据匹配和提取。

Set::IntSpan: 用于处理整数集合的模块。

Statistics::Basic: 提供了基本的统计分析功能，如均值、中位数等。

Text::Balanced: 用于从文本中提取和匹配成对出现的字符串。

Text::Format: 用于对文本进行格式化输出的模块。

Time::HiRes: 提供了高分辨率时间操作的模块，通常用于对时间进行精确控制和测量。

"
# Bio::Phylo
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST XML::XML2JSON PDF::API2 Math::CDF Math::Random
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Bio::Phylo
"
XML::XML2JSON: 用于将XML数据转换为JSON格式的模块。它使得在Perl中可以方便地将XML数据转换为JSON格式，方便处理和操作。

PDF::API2: 用于创建和修改PDF文件的模块。它允许Perl编程者创建PDF文档，包括文本、图像、表格和其他内容的排版。

Math::CDF: 提供了累积分布函数（CDF）的计算功能，用于统计学和数学计算中的概率分布。

Math::Random: 提供了生成随机数的功能，包括伪随机数和真随机数的生成。

Bio::Phylo: 这是生物信息学中的一个模块，用于进化树和系统发育树的构建、分析和可视化。它提供了对系统发育学数据进行操作和分析的功能，包括树形结构的构建和描述。
"
# Database and WWW
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST MongoDB LWP::Protocol::https Mojolicious

# text, rtf and xlsx
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Roman Text::Table RTF::Writer Chart::Math::Axis
cpanm --mirror-only --mirror $CPAN_MIRROR --notest Excel::Writer::XLSX Spreadsheet::XLSX Spreadsheet::ParseExcel Spreadsheet::WriteExcel

# Test::*
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Test::Class Test::Roo Test::Taint Test::Without::Module

# Moose and Moo
cpanm --mirror-only --mirror $CPAN_MIRROR --notest MooX::Options MooseX::Storage
"
MongoDB: 提供了Perl和MongoDB数据库的交互接口，允许在Perl中进行MongoDB数据库的操作。

LWP::Protocol::https: 用于在LWP（Library for WWW in Perl）中启用https协议的模块。

Mojolicious: 一个现代化的、实时的Web应用框架，提供了构建Web应用所需的各种功能和工具。

Roman: 用于阿拉伯数字和罗马数字相互转换的模块。

Text::Table: 用于在终端或文件中绘制表格的模块。

RTF::Writer: 用于生成RTF（Rich Text Format）文档的模块。

Chart::Math::Axis: 用于绘制数学坐标轴的模块，通常用于绘制图表。

Excel::Writer::XLSX: 用于创建和编辑XLSX格式的Excel文件的模块。

Spreadsheet::XLSX: 用于解析XLSX格式的Excel文件的模块。

Spreadsheet::ParseExcel: 用于解析旧版本的Excel文件（xls格式）的模块。

Spreadsheet::WriteExcel: 用于写入Excel文件（xls格式）的模块。

Test::Class: 用于编写基于类的测试的模块。

Test::Roo: 提供了一些辅助功能用于测试的模块。

Test::Taint: 用于检测Perl taint模式的模块。

Test::Without::Module: 允许在测试期间临时屏蔽模块的加载的模块。

MooX::Options: 为Moo对象提供了命令行选项解析的功能。

MooseX::Storage: 用于对Moose对象进行序列化和存储的模块。
"
# Develop
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST App::pmuninstall App::cpanoutdated Minilla Version::Next CPAN::Uploader

# Others
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST DateTime::Format::Natural DBD::CSV String::Compare Sereal PerlIO::gzip

# AlignDB::*
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST AlignDB::IntSpan AlignDB::Stopwatch
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST AlignDB::Codon AlignDB::DeltaG AlignDB::GC AlignDB::SQL AlignDB::Window AlignDB::ToXLSX
cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST App::RL App::Fasops App::Rangeops
"
App::pmuninstall: 用于从CPAN卸载模块的命令行工具。

App::cpanoutdated: 用于检查已安装模块的更新情况的工具。

Minilla: 用于管理和发布CPAN模块的工具集。

Version::Next: 用于生成下一个版本号的工具。

CPAN::Uploader: 用于将模块上传到CPAN的工具。

DateTime::Format::Natural: 用于将自然语言描述的日期时间转换为 DateTime 对象的模块。

DBD::CSV: 一个DBI驱动，允许使用SQL操作CSV文件。

String::Compare: 用于比较字符串的模块。

Sereal: 一个序列化和反序列化数据的高效工具。

PerlIO::gzip: 用于在Perl中提供gzip压缩格式的I/O。

AlignDB::IntSpan: 一个用于处理整数集合的模块。

AlignDB::Stopwatch: 用于跟踪程序执行时间的模块。

AlignDB::Codon: 用于密码子分析的模块。

AlignDB::DeltaG: 用于计算自由能变化的模块。

AlignDB::GC: 用于GC含量分析的模块。

AlignDB::SQL: 用于构建和执行SQL查询的模块。

AlignDB::Window: 用于序列窗口分析的模块。

AlignDB::ToXLSX: 用于将数据转换为XLSX格式的模块。

App::RL: 用于快速文件行操作的命令行工具。

App::Fasops: 用于对FASTA文件进行操作的命令行工具。

App::Rangeops: 用于对范围进行操作的命令行工具。
"
# App::*
cpanm -nq https://github.com/wang-q/App-Plotr.git
cpanm -nq https://github.com/wang-q/App-Egaz.git
#-n: --notest，表示在安装模块时不运行测试。
#-q: --quiet
#App-Plotr: 一个绘图和图表绘制的应用程序。  App-Egaz: 另一个特定的应用程序，功能和用途需要查看模块内部或文档才能确定。
#
# Gtk3 stuffs
# cpanm --mirror-only --mirror $CPAN_MIRROR $NO_TEST Glib Cairo Cairo::GObject Glib::Object::Introspection Gtk3 Pango

# Math
# cpanm --mirror-only --mirror $CPAN_MIRROR --notest Math::Random::MT::Auto PDL Math::GSL

# Statistics::R would be installed in `brew.sh`
# DBD::mysql would be installed in `mysql8.sh`
