#!/bin/bash

set -euo pipefail

MODEL_NAME="${MODEL_NAME:-Qwen3.5-0.8B-Q8_0.llamafile}"
MODEL_URL="${MODEL_URL:-https://huggingface.co/mozilla-ai/llamafile_0.10/resolve/main/Qwen3.5-0.8B-Q8_0.llamafile}"

MODEL_DIR="${MODEL_DIR:-/app/models}"
MODEL_PATH="${MODEL_DIR}/${MODEL_NAME}"
TEMP_PATH="${MODEL_PATH}.tmp"

if [[ -z "$MODEL_URL" ]]; then
    echo "ERRO: A variável MODEL_URL não foi definida."
    exit 1
fi

mkdir -p "$MODEL_DIR"

echo "Modelo: $MODEL_NAME"
echo "Destino: $MODEL_PATH"

if [[ -f "$MODEL_PATH" ]]; then
    echo "Modelo já encontrado."
else
    echo "Iniciando download..."

    curl -fL --retry 3 \
        "$MODEL_URL" \
        -o "$TEMP_PATH"

    mv "$TEMP_PATH" "$MODEL_PATH"
fi

chmod +x "$MODEL_PATH"

echo "Download concluído!"