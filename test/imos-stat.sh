#!/bin/bash

source "$(dirname "${BASH_SOURCE}")"/../imosh || exit 1

stat() {
  echo "$*"
}

source "$(dirname "${BASH_SOURCE}")"/../imos-stat || exit 1
