source .env

docker run --gpus=all --rm -it \
    -v ./prompt:/YuEGP/inference/prompt \
    -v ./output:/YuEGP/inference/output \
    -p 7860:7860 \
    yuegp:$CUDA_VERSION \
    python gradio_server.py --profile 1
    
