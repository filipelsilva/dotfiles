#!/bin/bash

curl -sS https://webinstall.dev/node | bash
$HOME/.local/bin/webi node@stable

# Packages
npm install -g diff-so-fancy
