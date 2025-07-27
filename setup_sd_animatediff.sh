#!/bin/bash

# Безопасный режим: остановить при ошибках
set -e

# 1. Переменные окружения для Colab
export COMMANDLINE_ARGS="--skip-torch-cuda-test --no-half --precision full --use-cpu all --upcast-sampling"
export PYTORCH_ENABLE_MPS_FALLBACK=1

#MEGA install 
wget https://mega.nz/linux/repo/xUbuntu_20.04/amd64/megacmd-xUbuntu_20.04_amd64.deb
apt install ./megacmd-xUbuntu_20.04_amd64.deb -y
mega-login "{mega_email}" "{mega_password}"

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
cd /content/SD-AD_CLB/stable-diffusion-webui

# 5. Установка зависимостей — лучше в Colab запускать из Jupyter, не здесь
# cd /content/SD-AD_CLB/stable-diffusion-webui
pip install -r requirements.txt
# 6. Запуск интерфейса
COMMANDLINE_ARGS="--xformers --no-half --disable-safe-unpickle --enable-insecure-extension-access --allow-code --medvram --opt-sdp-attention --precision full --upcast-sampling --skip-torch-cuda-test --listen --share" \
python launch.py