#!/bin/bash

# Authorization token
AUTH_TOKEN="9c2e0d7fd3c92668e0231147df9694b8"

# URLs and output file names
declare -A lora_models=(
  ["PEAnimeBG.safetensors"]="https://civitai.com/api/download/models/151356?type=Model&format=SafeTensor"
  ["Asethetic.safetensors"]="https://civitai.com/api/download/models/917604?type=Model&format=SafeTensor"
  ["EnhanceResolution8KHighResolution.safetensors"]="https://civitai.com/api/download/models/922225?type=Model&format=SafeTensor"
  ["glowneon_x1_v1.safetensors"]="https://civitai.com/api/download/models/922308?type=Model&format=SafeTensor"
  ["DetailedAnime-SDXLPony.safetensors"]="https://civitai.com/api/download/models/912294?type=Model&format=SafeTensor"
  ["Cozybackgrounds.safetensors"]="https://civitai.com/api/download/models/772727?type=Model&format=SafeTensor"
  ["Animescape.safetensors"]="https://civitai.com/api/download/models/475727?type=Model&format=SafeTensor"
)

# Directory to save Lora models
OUTPUT_DIR="./models/loras"
mkdir -p "$OUTPUT_DIR"

# Download each Lora model
for filename in "${!lora_models[@]}"; do
  url="${lora_models[$filename]}"
  echo "Downloading $filename..."
  curl -L -H "Authorization: Bearer $AUTH_TOKEN" -o "$OUTPUT_DIR/$filename" "$url"
done

echo "All Lora models downloaded successfully."
