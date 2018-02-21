

if [ ! -d "benchmarks" ]; then
    git clone https://github.com/tensorflow/benchmarks.git
fi

DIR=benchmarks/scripts/tf_cnn_benchmarks

NUM_EPOCH=1
NUM_BATCH_SIZE=32

TF_FLAGS="--num_epochs=$NUM_EPOCH --batch_size=$NUM_BATCH_SIZE --mkl=true --device=gpu --model=inception3 --tf_random_seed=6813"

# BEGIN GPU 1 BENCHMARK, use last GPU
NUM_GPU=1
export CUDA_VISIBLE_DEVICES=7
echo "BENCHMARK GPU: 1 ... CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
START_TIME=$SECONDS
python $DIR/tf_cnn_benchmarks.py --num_gpus=$NUM_GPU $TF_FLAGS > tf_cnn_benchmarks_gpu_$NUM_GPU.log 2>&1
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo "Done: $ELAPSED_TIME seconds elapsed."

# BEGIN GPU 8 BENCHMARK
NUM_GPU=8
export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
echo "BENCHMARK GPU: 8 ... CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
START_TIME=$SECONDS
python $DIR/tf_cnn_benchmarks.py --num_gpus=$NUM_GPU $TF_FLAGS > tf_cnn_benchmarks_gpu_$NUM_GPU.log 2>&1
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo "Done: $ELAPSED_TIME seconds elapsed."
