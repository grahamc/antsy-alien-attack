#!/usr/bin/env bash

source code/threads.sh
source code/input.sh
source code/gfx.sh
source code/sfx.sh
source code/music.sh
source code/title.sh
source code/game.sh
source code/gameover.sh
source code/victory.sh

LOOP=
DELAY=0.02

case ${BASH_VERSINFO[@]::2} in [1-3]' '[0-9][0-9]|[1-3]' '[0-9]|'4 '[0-1])
	echo -e "\nYour Bash is too low! 4.2+ is required to run this game, yours is ${BASH_VERSINFO[@]}"
    exit 1;;
esac

setup() {
  trap teardown EXIT INT
  trap start-loop ALRM
  gfx-setup
  sound-setup
  music-setup
}

teardown() {
  gfx-teardown
  sound-teardown
  music-teardown
  terminate-all-threads
  trap exit ALRM
  sleep "$DELAY"
  exit
}

start-loop() {
  $LOOP
  (sleep $DELAY && kill -ALRM $$) &
}

setup
title-mode
start-loop
start-input-handler