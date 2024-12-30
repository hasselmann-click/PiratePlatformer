# Udemy Pirate Platformer

[Udemy Course](https://www.udemy.com/share/10ao3O3@1iwbvJ1AzlgIe49A60Eb47rogq-yoOd4co__NADaAQz4J55WiSaD9h7i5UX6uoDaNw==/) by Thomas Yanuziello

## Export

- Exports require the Godot export templates
  - You can download them from https://godotengine.org/download/linux/
  - Save them to `./exports/templates`

### Android

- Run `./export-android.sh`
  - Don't run it in Git Bash. This will mess up the paths in the container.
- This will build and run a docker container to export the project to an Android APK
  - Dockerfile: `./dockerfile-export-android`
- You can update the export path in the script to export to a different location
