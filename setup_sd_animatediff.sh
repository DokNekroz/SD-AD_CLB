#!/bin/bash

# 1. Переменные окружения
export COMMANDLINE_ARGS="--skip-torch-cuda-test --no-half --precision full --use-cpu all --upcast-sampling"

# 2. Клонирование stable-diffusion-webui
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
cd stable-diffusion-webui

# 3. Установка AnimateDiff
mkdir -p extensions
git clone https://github.com/continue-revolution/sd-webui-animatediff.git extensions/sd-webui-animatediff

# 4. Установка motion-модулей
mkdir -p models/MotionModules
cd models/MotionModules
wget https://huggingface.co/guoyww/animatediff/resolve/main/mm_sd_v15_v2.ckpt
cd ../../..

# 5. Установка зависимостей (можно заменить на custom requirements)
pip install -r requirements_versions.txt

# 6. Запуск интерфейса
python launch.py --share