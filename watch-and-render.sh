#!/usr/bin/env bash

fswatch --exclude ".rb~$" --include ".rb$" --event Updated ./flight_plans | xargs -I{} ruby {}
