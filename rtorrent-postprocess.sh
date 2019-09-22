#!/usr/bin/env bash
set -x

# Input Parameters
[ -z "$var" ] && export HOME="/root"
ARG_PATH="$1"
[ $2 = 1 ] && ARG_MULTI="multi" || ARG_MULTI="single"
ARG_NAME="$3"
ARG_LABEL="$4"
#ARG_COMPLETED_DIR="$5"

#mkdir -p "$ARG_COMPLETED_DIR"
#mv -u "$ARG_PATH", "$ARG_COMPLETED_DIR"

[[ ! $ARG_LABEL =~ "movies" ]] && [[ ! $ARG_LABEL =~ "tv" ]] && [[ $ARG_LABEL =~ "ignore" ]] && echo "Not a movie or TV show. Quitting..." && exit

# Configuration
CONFIG_OUTPUT="/data/plexmedia"

if [ $2 = 1 ]; then
    filebot -script fn:amc --output "$CONFIG_OUTPUT" --action symlink \
--conflict skip -non-strict --log-file /var/log/amc.log \
--def unsorted=y music=y artwork=y ut_dir="$ARG_PATH" ut_kind="$ARG_MULTI" ut_title="$ARG_NAME" ut_label="$ARG_LABEL"
#--def unsorted=y music=y artwork=y excludeList=".excludes" ut_dir="$ARG_PATH" ut_kind="$ARG_MULTI" ut_title="$ARG_NAME" ut_label="$ARG_LABEL"

else
    filebot -script fn:amc --output "$CONFIG_OUTPUT" --action symlink \
--conflict skip -non-strict --log-file /var/log/amc.log \
--def unsorted=y music=y artwork=y  ut_dir="$ARG_PATH" ut_file="$ARG_NAME" ut_kind="$ARG_MULTI" ut_title="$ARG_NAME" ut_label="$ARG_LABEL"
#--def unsorted=y music=y artwork=y excludeList=".excludes" ut_dir="$ARG_PATH" ut_file="$ARG_NAME" ut_kind="$ARG_MULTI" ut_title="$ARG_NAME" ut_label="$ARG_LABEL"
fi

