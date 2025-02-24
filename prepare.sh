#!/bin/bash

# 定义目录变量
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export PROJECT_ROOT="$DIR"

升级 pip 和安装 Python 依赖
pip3 install --upgrade pip
pip3 install dfss transformers==4.45.1 "pybind11[global]" Jinja2
sudo apt install zip

# 编译 C++ 扩展
cd "$PROJECT_ROOT/deepseek_r1_distill_qwen"
mkdir -p build
cd build
cmake .. && make && cp ./*cpython* ..
cd "$PROJECT_ROOT"