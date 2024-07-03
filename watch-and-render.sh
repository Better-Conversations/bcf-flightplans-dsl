#!/usr/bin/env bash

fswatch -e '~$' flight_plans/ | xargs -I {} ruby {}
