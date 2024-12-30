docker run -it --rm ubuntu:latest /bin/bash


apt-get install -y curl
curl -Lo /tmp/godot_export_templates.tpz https://downloads.tuxfamily.org/godotengine/4.3/export_templates/Godot_v4.3-stable_export_templates.tpz
curl --insecure -Lo /tmp/godot_export_templates.tpz https://downloads.tuxfamily.org/godotengine/4.3/export_templates/Godot_v4.3-stable_export_templates.tpz


apt-get update
apt-get install -y ca-certificates
update-ca-certificates

openssl s_client -connect downloads.tuxfamily.org:443

wget https://downloads.tuxfamily.org/godotengine/4.3/export_templates/Godot_v4.3-stable_export_templates.tpz -O /tmp/godot_export_templates.tpz