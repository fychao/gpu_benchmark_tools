

#git clone https://github.com/torch/distro.git ~/torch --recursive
#cd ~/torch; bash install-deps;
## add  export TORCH_NVCC_FLAGS="-D__CUDA_NO_HALF_OPERATORS__"  see https://goo.gl/MBseu3
#./install.sh
#
#luarocks install bit32
#luarocks install tds
#
###
##
## Data Preperation
##
###
WMT_DATASET_PATH="/home/benchmark01/wmt15-ende"
ONMT_PATH="/home/benchmark01/OpenNMT"

#mkdir $WMT_DATASET_PATH
#wget -qO- "https://s3.amazonaws.com/opennmt-trainingdata/wmt15-de-en.tgz" | tar xvz -C $WMT_DATASET_PATH


#git clone https://github.com/OpenNMT/OpenNMT.git
cd $ONMT_PATH

#echo "Preparing Datasets (tokenizing)..."
#SECONDS_PREP=0
#for f in $WMT_DATASET_PATH/wmt15-de-en/*.?? ; do th tools/tokenize.lua < $f > $f.tok ; done
#duration=$SECONDS
#echo "Done: $duration seconds elapsed."
#
#echo "Preparing Datasets (preprocessing)..."
#SECONDS_PREP=0
#for l in en de ; do cat $WMT_DATASET_PATH/wmt15-de-en/commoncrawl.de-en.$l.tok $WMT_DATASET_PATH/wmt15-de-en/europarl-v7.de-en.$l.tok $WMT_DATASET_PATH/wmt15-de-en/news-commentary-v10.de-en.$l.tok > $WMT_DATASET_PATH/wmt15-de-en/wmt15-all-de-en.$l.tok ; done
#time th preprocess.lua -train_src $WMT_DATASET_PATH/wmt15-de-en/wmt15-all-de-en.en.tok -train_tgt $WMT_DATASET_PATH/wmt15-de-en/wmt15-all-de-en.de.tok -valid_src $WMT_DATASET_PATH/wmt15-de-en/newstest2013.en.tok -valid_tgt $WMT_DATASET_PATH/wmt15-de-en/newstest2013.de.tok -save_data $WMT_DATASET_PATH/wmt15-de-en/wmt15-all-en-de
#echo "Done: $duration seconds elapsed."

###
#
# Begin Runing Benchmark
#
###
echo "Training ..."
START_TIME=$SECONDS
export THC_CACHING_ALLOCATOR=0
time th train.lua -data $WMT_DATASET_PATH/wmt15-de-en/wmt15-all-en-de-train.t7 -save_model $WMT_DATASET_PATH/wmt15-de-en/wmt15-all-en-de -gpuid 1 -end_epoch 1
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo "Done: $ELAPSED_TIME seconds elapsed."

