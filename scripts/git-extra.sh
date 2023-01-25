#!/bin/bash

echo "Updating the mlocate database"
sudo -v; sudo updatedb

echo "Finding diff_highlight..."
diff_highlight="$(locate '*/diff-highlight/diff-highlight')"
echo "Found"

echo "Finding git_jump..."
git_jump="$(locate '*/git-jump/git-jump')"
echo "Found"

echo "Linking files to /usr/local/bin..."
sudo -v; sudo ln -sf "$diff_highlight" /usr/local/bin
sudo -v; sudo ln -sf "$git_jump" /usr/local/bin
echo "Done"
