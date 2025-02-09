source .env

CONTAINER_NAME="yue"
CONTAINER_ID="$(docker ps -a -f name=$CONTAINER_NAME -q)"

if [ -n "$CONTAINER_ID" ]; then
    docker start $CONTAINER_NAME
else
    docker run --gpus=all --name yue -it \
        -v ./prompt:/YuEGP/inference/prompt \
        -v ./output:/YuEGP/inference/output \
        -p 7860:7860 \
        --name $CONTAINER_NAME \
        yuegp:$CUDA_VERSION \
        python gradio_server.py --profile 1
fi
    
