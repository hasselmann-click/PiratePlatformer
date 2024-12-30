#!/bin/bash

echo "Exporting project to Android APK"

# Image to use
IMAGE="godot-android-build-env"

# Set the project paths
PROJECT_PATH="."
EXPORT_PATH="${PROJECT_PATH}/exports"

# Set the path to the export templates
# download them from https://godotengine.org/download/linux/
# TEMPLATES_PATH="./exports/templates"  
# if [ ! -d "$TEMPLATES_PATH" ]; then
#     echo "Export templates directory does not exist: $TEMPLATES_PATH"
#     exit 1
# fi

echo "Building Docker image: $IMAGE"
# Run the Docker container to export the project
docker build -t $IMAGE -f ./dockerfile-export-android .

echo "Running Docker container: $IMAGE"
echo "Exporting to: $EXPORT_PATH"
echo "Project path: $PROJECT_PATH"

docker run --rm \
    -v "${PROJECT_PATH}:/workdir" \
    -v "${EXPORT_PATH}:/workdir/exports" \
    -w /workdir \
    $IMAGE --verbose --headless \
        --export-debug "Android" "/workdir/exports/my_game.apk"
        #--import
        # -v "$TEMPLATES_PATH:/root/.local/share/godot/templates/4.3.stable" \

echo "Done"