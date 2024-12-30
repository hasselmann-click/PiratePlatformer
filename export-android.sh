#!/bin/bash

# Image to use
IMAGE="godot-android-build-env"

# Set the project paths
PROJECT_PATH="."
EXPORT_PATH="./exports"

# Set the path to the export templates
# download them from https://godotengine.org/download/linux/
TEMPLATES_PATH="./exports/templates"  
if [ ! -d "$TEMPLATES_PATH" ]; then
    echo "Export templates directory does not exist: $TEMPLATES_PATH"
    exit 1
fi

# Run the Docker container to export the project
docker build -t $IMAGE -f ./dockerfile-export-android .
docker run --rm \
    -v "$PROJECT_PATH:/workspace" \
    -v "$EXPORT_PATH:/workspace/exports" \
    -v "$TEMPLATES_PATH:/root/.local/share/godot/templates/4.3.stable" \
    $IMAGE godot --headless --export "Android" /workspace/exports/my_game.apk
