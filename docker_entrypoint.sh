#! /usr/bin/env bash

export BOT_TOKEN=$(cat bot.token)

echo "Running..."
mix run --no-halt
