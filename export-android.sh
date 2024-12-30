#!/bin/bash

echo "Exporting project to Android APK"

# Image to use
IMAGE="godot-android-build-env"
# Set the project paths
PROJECT_PATH=$(pwd)
EXPORT_PATH="${PROJECT_PATH}/exports"
# Set the path to the export templates
# download them from https://godotengine.org/download/linux/
TEMPLATES_PATH="${PROJECT_PATH}/exports/templates/android"  
if [ ! -d "$TEMPLATES_PATH" ]; then
    echo "Export templates directory does not exist: $TEMPLATES_PATH"
    exit 1
fi

echo "Building Docker image: $IMAGE"
# Run the Docker container to export the project
docker build -t $IMAGE -f ./dockerfile-export-android .

echo "Running Docker container: $IMAGE"
echo "Exporting to: $EXPORT_PATH"
echo "Project path: $PROJECT_PATH"

# Remark: no-editor-plugins (o.s.) will be relevant in the future: https://github.com/godotengine/godot-proposals/issues/2628
docker run --rm \
    -v "${PROJECT_PATH}:/workdir" \
    -v "${EXPORT_PATH}:/workdir/exports" \
    -v "${TEMPLATES_PATH}:/workdir/exports/templates/android" \
    -w /workdir \
    $IMAGE --verbose --headless \
        --no-editor-plugins \
        --export-debug "Android"

echo "Done"