#!/bin/bash

# Authorization token
AUTH_TOKEN="9c2e0d7fd3c92668e0231147df9694b8"

# URLs and output file names
declare -A models=(
  ["Animagine_XL_3.0.safetensors"]="https://civitai.com/api/download/models/403131?type=Model&format=SafeTensor&size=full&fp=fp16"
  #["annimexlXuebimix_v60LCM.safetensors"]="https://civitai.com/api/download/models/259194?type=Model&format=SafeTensor&size=full&fp=fp16"
  #["landscapeAnimeMax.safetensors"]="https://civitai.com/api/download/models/424334?type=Model&format=SafeTensor&size=full&fp=fp16"
  #["colorfulAnimeXLXL_20v.safetensors"]="https://civitai.com/api/download/models/363664?type=Model&format=SafeTensor&size=pruned&fp=fp16"
  #["animicsPonyXL_30v.safetensors"]="https://civitai.com/api/download/models/966130?type=Model&format=SafeTensor&size=full&fp=fp16"
)

# Directory to save models
OUTPUT_DIR="./models/my-upload-dir/checkpoints"
mkdir -p "$OUTPUT_DIR"

# Download each model
for filename in "${!models[@]}"; do
  url="${models[$filename]}"
  echo "Downloading $filename..."
  curl -L -H "Authorization: Bearer $AUTH_TOKEN" -o "$OUTPUT_DIR/$filename" "$url"
done

echo "All models downloaded successfully."
