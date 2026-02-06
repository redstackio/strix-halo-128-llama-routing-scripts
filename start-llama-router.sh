#!/bin/bash
# Llama Router Server - Optimized for AMD Strix Halo

LLAMA_SERVER="./lemonade-sdk/llama-server"
PRESETS_FILE="./llama-router-presets.ini"
LOG_FILE="./llama-router.log"

if [ ! -f "$LLAMA_SERVER" ]; then
    echo "Error: llama-server not found at $LLAMA_SERVER"
    exit 1
fi

if [ ! -f "$PRESETS_FILE" ]; then
    echo "Error: Presets file not found at $PRESETS_FILE"
    exit 1
fi

echo "Starting llama-server in router mode..."
echo "Hardware: AMD Strix Halo (MAX+395, 128GB RAM, 126GB GTT)"
echo "Context: 128K tokens (65K for gpt)"
echo "Models: glm, gpt, minimax"
echo "API: http://0.0.0.0:8080"
echo ""

$LLAMA_SERVER \
    --host 0.0.0.0 \
    --port 8080 \
    --models-preset "$PRESETS_FILE" \
    --models-max 3 \
    2>&1 | tee "$LOG_FILE"
