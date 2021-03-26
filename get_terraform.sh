#!/usr/bin/bash

git clone https://github.com/tfutils/tfenv.git ~/.tfenv

ln -s ~/.tfenv/bin/* /usr/local/bin

tfenv install latest

tfenv use latest