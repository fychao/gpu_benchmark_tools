# gpu_benchmark_tools
this is collection of gpu benchmark tools

<!-- MarkdownTOC -->

- plan
	- I. Sling
	- II. DeepBench

<!-- /MarkdownTOC -->


## plan

### I. Sling

https://github.com/google/sling

* for provisional tensorflow training

### II. DeepBench

https://github.com/baidu-research/DeepBench

types:
- Dense Matrix Multiplies
- Convolutions
- Recurrent Layers
- All-Reduce

requires:
* [NVIDIA's NCCL](https://developer.nvidia.com/nccl)
* [Ohio State University (OSU) Benchmarks](http://mvapich.cse.ohio-state.edu/benchmarks/)
* [Baidu's Allreduce](https://github.com/baidu-research/baidu-allreduce/)
* [Intel's MLSL](https://github.com/intel/MLSL)

