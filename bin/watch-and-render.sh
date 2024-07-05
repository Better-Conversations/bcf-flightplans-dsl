#!/usr/bin/env bash

# Because of the way that we load the flight plans with a require_relative we need to start a new ruby process for each
# file.
fswatch --exclude ".rb~$" --include ".rb$" --event Updated ./flight_plans | xargs -I{} ruby ./bin/loader.rb {}
