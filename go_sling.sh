#!/bin/sh
git clone --recursive https://github.com/google/sling.git
pip install -U protobuf==3.4.0
cd sling/
bazel build -c opt sling/nlp/parser sling/nlp/parser/tools:all

if [ ! -f ./conll-2003-sempar.tar.gz ]; then
    echo "Conll Corpus not found!"
    curl -o ./conll-2003-sempar.tar.gz http://www.jbox.dk/sling/conll-2003-sempar.tar.gz
    mkdir -p ./local/embeddings
    tar -xvf ./conll-2003-sempar.tar.gz -C ./ --no-same-owner 
fi


if [ ! -f ./local/embeddings/word2vec-32-embeddings.bin ]; then
    echo "Pre-Train File not found!"
    curl -o ./local/embeddings/word2vec-32-embeddings.bin http://www.jbox.dk/sling/word2vec-32-embeddings.bin
fi

echo "Training ..."
START_TIME=$SECONDS

./sling/nlp/parser/tools/train.sh \
  --commons=local/conll2003/commons \
  --train=local/conll2003/eng.train.zip \
  --dev=local/conll2003/eng.testa.zip \
  --word_embeddings=local/embeddings/word2vec-32-embeddings.bin \
  --report_every=5000 \
  --train_steps=10000 \
  --output=/tmp/sempar-conll

ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo "Done: $ELAPSED_TIME seconds elapsed."
