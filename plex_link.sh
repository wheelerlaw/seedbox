#!/usr/bin/env bash
set -e
set -o pipefail

tags=$1
data_path=$2
is_multi_file=$3

[[ $tags == *"movies"* ]] || exit

if [ $is_multi_file ]; then
    cd "$data_path"
    for i in *.rar; do
        unrar x -o- "$i"
    done
fi
