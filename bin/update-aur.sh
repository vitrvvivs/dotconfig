#!/bin/sh
yay -Quq --aur | while read -r p; do yes '' | yay -S "$p" || echo "$p" >>~/yay-failed.log; done
