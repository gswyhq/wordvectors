#!/bin/bash

#### 在此处设置参数 ####
############## START ###################
lcode="zh" # ISO 639-1 目标语言的code，见 `lcodes.txt`.
max_corpus_size=1000000000 # 语料库最大大小，根据计算能力随意调整
vector_size=300 # 词向量的大小
window_size=5 # 一个句子中当前和预测单词之间的最大距离，即上下文窗口大小
vocab_size=20000 # 最大词汇量
num_negative=5 # 噪声词数
############## END #####################

echo "第一步，新建 `data` 目录，并移动到那里."
mkdir data; cd data

echo "第二步，下载维基百科文件到磁盘"
wget -c -t 0 "https://dumps.wikimedia.org/${lcode}wiki/20161201/${lcode}wiki-20161201-pages-articles-multistream.xml.bz2"

echo "第三步，提取bz2文件"
bzip2 -d "${lcode}wiki-20161201-pages-articles-multistream.xml.bz2"

cd ..
echo "第四步，构建语料库"
python build_corpus.py --lcode=${lcode} --max_corpus_size=${max_corpus_size}

echo "第五步，生成词向量 wordvectors"
python make_wordvectors.py --lcode=${lcode} --vector_size=${vector_size} --window_size=${window_size} --vocab_size=${vocab_size} --num_negative=${num_negative}

