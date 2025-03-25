#!/usr/bin/env bash
#MISE description="Creates a Linux release of the agent"

(cd agent && MIX_ENV=prod BURRITO_TARGET=macos mix release --overwrite)
