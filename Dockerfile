FROM nvidia/cuda:12.8.0-cudnn-devel-ubuntu22.04

RUN apt update && apt-get install -y &&\
  apt install -y python3.10 python3-pip &&\
  ln -sf python3 /usr/bin/python &&\
  ln -sf pip3 /usr/bin/pip &&\
  pip install --upgrade pip &&\
  pip install wheel setuptools

# 1) Install source code 
RUN apt update && apt-get install -y git-lfs &&\
  git lfs install
ADD ./ /YuEGP
RUN cd YuEGP/inference/ &&\
  git clone https://huggingface.co/m-a-p/xcodec_mini_infer

# 2) Install torch and requirements
WORKDIR /YuEGP
RUN pip install --no-cache-dir torch==2.5.1 torchvision torchaudio --index-url https://download.pytorch.org/whl/test/cu124 &&\
  pip install --no-cache-dir -r requirements.txt

# 3) (optional) Install FlashAttention
RUN pip install --no-cache-dir flash-attn --no-build-isolation

# 4) (optional) Transformers Patches for Low VRAM (< 10 GB of VRAM) and 2x faster genration with more than 16 GB of VRAM
RUN cp -r transformers/ /usr/local/lib/python3.10/site-packages/ 

EXPOSE 7860
ENV GRADIO_SERVER_NAME="0.0.0.0" GRADIO_SERVER_PORT=7860
WORKDIR /YuEGP/inference
