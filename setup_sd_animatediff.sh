#!/bin/bash

# Безопасный режим: остановить при ошибках
set -e

# 1. Переменные окружения для Colab
export COMMANDLINE_ARGS="--skip-torch-cuda-test --no-half --precision full --use-cpu all --upcast-sampling"
export PYTORCH_ENABLE_MPS_FALLBACK=1

# 2. Клонирование stable-diffusion-webui
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
cd stable-diffusion-webui

# 3. Установка AnimateDiff
mkdir -p extensions
git clone https://github.com/continue-revolution/sd-webui-animatediff.git extensions/sd-webui-animatediff

# 4. Установка motion-модуля
mkdir -p models/MotionModules
cd models/MotionModules
wget -q --show-progress https://huggingface.co/guoyww/animatediff/resolve/main/mm_sd_v15_v2.ckpt
cd ../../..

# 5. Установка зависимостей — лучше в Colab запускать из Jupyter, не здесь
%cd /content/SD-AD_CLB/stable-diffusion-webui
pip install -r requirements.txt

# 6. Запуск интерфейса
%cd /content/SD-AD_CLB/stable-diffusion-webui
COMMANDLINE_ARGS="--medvram --opt-sdp-attention --precision full --no-half --upcast-sampling --share" \
python launch.py