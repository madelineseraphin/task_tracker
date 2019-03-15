#!/bin/bash

export MIX_ENV=prod
export PORT=4001

echo "Stopping old copy of app, if any..."

_build/prod/rel/task_tracker/bin/task_tracker stop || true

echo "Starting app..."

_build/prod/rel/task_tracker/bin/task_tracker start
