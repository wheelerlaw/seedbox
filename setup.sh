#!/usr/bin/env bash

docker build -t wheelerlaw/rtorrent:latest -f rtorrent.Dockerfile .
docker build -t wheelerlaw/flood:latest -f flood/Dockerfile flood
