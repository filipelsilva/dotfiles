#!/bin/bash
[ "$UID" -eq 0 ] || { echo "This script must be run as root."; exit 1; }
