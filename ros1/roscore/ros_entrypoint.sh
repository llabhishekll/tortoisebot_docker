#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/noetic/setup.bash"

# execute user cmd
exec "$@"