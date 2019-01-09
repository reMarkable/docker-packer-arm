#!/bin/bash

if [ ! -d /proc/sys/fs/binfmt_misc ] || [ -z "$(ls -A /proc/sys/fs/binfmt_misc)" ]; then
  mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
fi

packer "$@"
