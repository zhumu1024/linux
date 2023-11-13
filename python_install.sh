#!/bin/bash

BASE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd "${BASE_DIR}" || exit

# pip
PYPI_MIRROR=https://mirrors.nju.edu.cn/pypi/web/simple
# Python Package Index (PyPI) 的镜像地址。PyPI 是 Python 官方的软件包索引和仓库，开发者可以从这里获取Python软件包
# 
#pip3 install -i ${PYPI_MIRROR} --upgrade pip setuptools

pip3 install -i ${PYPI_MIRROR} pysocks cryptography
pip3 install -i ${PYPI_MIRROR} virtualenv
pip3 install -i ${PYPI_MIRROR} more-itertools zipp setuptools-scm
pip3 install -i ${PYPI_MIRROR} numpy matplotlib
pip3 install -i ${PYPI_MIRROR} pandas scipy jupyter sympy
pip3 install -i ${PYPI_MIRROR} lxml statsmodels patsy h5py
pip3 install -i ${PYPI_MIRROR} beautifulsoup4 scikit-learn seaborn
"
pysocks: 一个Python库，用于处理SOCKS代理。

cryptography: 提供了密码学相关的工具和算法，例如加密、解密、签名和验证等功能。

virtualenv: 用于创建Python虚拟环境的工具，允许在不同项目中独立管理Python库。

more-itertools: 提供了更多的Python迭代工具，用于增强Python标准库中的迭代器功能。

zipp: 一个用于处理ZIP文件格式的库。

setuptools-scm: 用于自动管理Python包的版本号的工具。

numpy: 用于数值计算的Python库，提供了多维数组和矩阵运算。

matplotlib: 用于绘制图表和数据可视化的库。

pandas: 提供了数据分析和操作的工具，尤其适用于处理结构化数据。

scipy: 提供了科学计算和技术计算的Python库，包含了各种数学、科学和工程计算的工具。

jupyter: Jupyter笔记本的Python内核，用于创建和共享文档，结合代码和文本。

sympy: 提供了符号数学计算的Python库。

lxml: 用于解析XML和HTML的Python库。

statsmodels: 提供了统计模型和数据探索的Python库。

patsy: 用于描述性统计的Python库，支持统计模型描述的构建。

h5py: 用于处理HDF5文件格式的Python库。

beautifulsoup4: 用于解析HTML和XML文件的Python库，常用于网络数据采集。

scikit-learn: 提供了机器学习和数据挖掘的Python库。

seaborn: 用于数据可视化和统计图形绘制的Python库，基于matplotlib。
"
#HDF5_DIR=$(brew --prefix hdf5) pip install h5py tables

pip3 install -i ${PYPI_MIRROR} h5py tabulate # TBB
#Pip Installs Packages
#
# PPanGGOLiN
pip3 install -i ${PYPI_MIRROR} tqdm tables networkx dataclasses
pip3 install -i ${PYPI_MIRROR} plotly gmpy2 colorlover bokeh

# antismash
pip3 install -i ${PYPI_MIRROR} helperlibs jinja2 joblib jsonschema markupsafe pysvg pyscss
pip3 install -i ${PYPI_MIRROR} biopython bcbio-gff

pip3 install -i ${PYPI_MIRROR} Circle-Map cutadapt importlib-metadata

pip3 install -i ${PYPI_MIRROR} deeptools

"
h5py: 提供了对HDF5格式数据的Python封装，用于处理大型数据集。
tabulate: 用于在文本中生成表格的Python库，可帮助在终端中漂亮地显示数据。
tqdm: 提供了在Python中生成进度条的功能。
tables: 用于处理和管理表格式数据的Python库。
networkx: 用于复杂网络分析的Python库。
dataclasses: 用于创建数据类的Python库。
biopython: 一个用于生物信息学的Python库。
bcbio-gff: 用于处理GFF（General Feature Format）文件的Python库。

Circle-Map: 这可能是一个特定的Python模块或应用，其功能需要在其文档或代码中查看确认。
cutadapt: 用于对DNA序列进行切除和修剪的Python库。
importlib-metadata: 用于读取Python包元数据的库。
deeptools: 用于处理高通量测序数据的Python库，包括数据处理和可视化分析。
"
# poetry can search packages
# curl -sSL https://install.python-poetry.org | python3 -
