source .env
docker build \
    --build-arg CUDA_VERSION=$CUDA_VERSION \
    -t yuegp:$CUDA_VERSION \
    .
