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
#mkdir -p extensions
#git clone https://github.com/continue-revolution/sd-webui-animatediff.git extensions/sd-webui-animatediff

# Установка megatools
apt update && apt install -y megatools

# 1. Models
mkdir -p /content/temp_models && cd /content/temp_models
megadl 'https://mega.nz/folder/Zm4gzIrD#UcuYvAvSxBDAJKbQAER0sg'
rm -rf /content/SD-AD_CLB/stable-diffusion-webui/models/
mkdir -p /content/SD-AD_CLB/stable-diffusion-webui/models/
cd /content/temp_models
mv -f * /content/SD-AD_CLB/stable-diffusion-webui/models/
cd /content && rm -rf /content/temp_models


# 3. Embeddings
mkdir -p /content/temp_embeddings && cd /content/temp_embeddings
megadl 'https://mega.nz/folder/MjBDGQ6A#2T485PZ8aYWpILuLWUKo4A'
rm -rf /content/SD-AD_CLB/stable-diffusion-webui/embeddings/
mkdir -p /content/SD-AD_CLB/stable-diffusion-webui/embeddings/
cd /content/temp_embeddings
mv -f * /content/SD-AD_CLB/stable-diffusion-webui/embeddings/
cd /content && rm -rf /content/temp_embeddings

# 5. Установка зависимостей — лучше в Colab запускать из Jupyter, не здесь
cd /content/SD-AD_CLB/stable-diffusion-webui
pip install -r requirements.txt
# 6. Запуск интерфейса
COMMANDLINE_ARGS="--xformers --no-half --disable-safe-unpickle --enable-insecure-extension-access --allow-code --medvram --opt-sdp-attention --precision full --upcast-sampling --skip-torch-cuda-test --listen --share" \
python launch.py