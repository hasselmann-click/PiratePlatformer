# Udemy Pirate Platformer

- A Godot 2D platformer for me to test and experiment some stuff with
- Based on the [Udemy Course](https://www.udemy.com/share/10ao3O3@1iwbvJ1AzlgIe49A60Eb47rogq-yoOd4co__NADaAQz4J55WiSaD9h7i5UX6uoDaNw==/) by Thomas Yanuziello

- Not finished yet. 


## Assets
Assets are expected to be in the `assets-synced` folder. This is because assets typically aren't part of the source code and require a separate large-file syncing system.

### Assets Used
- https://pixelfrog-assets.itch.io/treasure-hunters
- https://freesound.org/people/LukeSharples/packs/13289/
- https://freesound.org/people/LittleRobotSoundFactory/packs/1800
- https://freesound.org/people/Yin_Yang_Jake007/sounds/406087/

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
