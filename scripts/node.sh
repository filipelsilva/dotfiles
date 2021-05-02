#!/bin/bash

curl -sS https://webinstall.dev/node | bash
webi node@stable

# Packages
npm install -g diff-so-fancy
