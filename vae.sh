#!/bin/bash

# Authorization token
AUTH_TOKEN="9c2e0d7fd3c92668e0231147df9694b8"

# URLs and output file names
declare -A vae_models=(
  ["foranimaginexl.safetensors"]="https://civitai.com/api/download/models/403131?type=VAE&format=SafeTensor"
  ["sdxl_vae.safetensors"]="https://civitai.com/api/download/models/363664?type=VAE&format=SafeTensor"
)

# Directory to save VAE models
OUTPUT_DIR="./models/vae"
mkdir -p "$OUTPUT_DIR"

# Download each VAE model
for filename in "${!vae_models[@]}"; do
  url="${vae_models[$filename]}"
  echo "Downloading $filename..."
  curl -L -H "Authorization: Bearer $AUTH_TOKEN" -o "$OUTPUT_DIR/$filename" "$url"
done

echo "All VAE models downloaded successfully."
