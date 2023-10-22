#!/bin/bash

nvim -u $NVIM_CONF_HOME/init_min.lua +"Man $1" -c "wincmd o"
