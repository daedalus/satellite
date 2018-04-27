#!/bin/bash

if [ ! -d "gr-framers" ]; then
	git clone https://github.com/igorauad/gr-framers.git --branch public_statistics
fi

cd gr-framers

if [ ! -d "build" ]; then
	mkdir build
fi

cd build
cmake ..
make
sudo make install

