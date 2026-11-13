FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV MODEL_DIR=/app/models
ENV MODEL_NAME=Qwen3.5-0.8B-Q8_0.llamafile

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY download-model.sh /usr/local/bin/download-model

RUN chmod +x /usr/local/bin/download-model

ARG MODEL_URL
ENV MODEL_URL=${MODEL_URL}

RUN download-model

EXPOSE 8080

ENTRYPOINT ["/bin/bash", "-c", "exec \"$MODEL_DIR/$MODEL_NAME\" --server --host 0.0.0.0 --port 8080"]