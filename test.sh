#!/bin/bash

if ( command -v apt-get &> /dev/null ); then
	echo "UBUNTU"
fi
#if (( $+commands[apt-get] )); then
#	echo "UBUNTU"
#elif (( ${+commands[pacman]} )); then
#	echo "ARCH"
#fi
