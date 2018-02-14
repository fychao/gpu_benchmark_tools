#!/bin/sh


LANG=C.UTF-8
LC_ALL=C.UTF-8
echo 'export PATH=~/conda/bin:$PATH' > ~/.bashrc &&  \
    wget --quiet https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p ~/conda && \
    rm ~/anaconda.sh

echo "Training ..."
START_TIME=$SECONDS


ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo "Done: $ELAPSED_TIME seconds elapsed."
