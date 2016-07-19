#!/bin/bash

. ~/torch/install/bin/torch-activate
cd /root/darkforestGo/local_evaluator
sh cnn_evaluator.sh 1 /data/local/go > /dev/null
cd /root/darkforestGo/cnnPlayerV2
th cnnPlayerMCTSV2.lua "$@"
