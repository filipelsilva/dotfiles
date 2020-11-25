#!/bin/sh

echo "Downloading fonts (this may take a while)..."
wget https://github.com/be5invis/Iosevka/releases/download/v4.0.0-beta.3/ttf-iosevka-4.0.0-beta.3.zip
wget https://github.com/be5invis/Iosevka/releases/download/v4.0.0-beta.3/ttf-iosevka-term-4.0.0-beta.3.zip

unzip ttf-iosevka-4.0.0-beta.3.zip
unzip ttf-iosevka-term-4.0.0-beta.3.zip
rm ttf-iosevka-4.0.0-beta.3.zip tf-iosevka-term-4.0.0-beta.3.zip

mv *.tff ~/.local/share/fonts/

echo "Updating font-cache..."
sudo fc-cache -f > /dev/null
