#!/bin/bash

if [ ! -d "gr-framers" ]; then
	git clone https://github.com/gr-vt/gr-framers.git
fi

cd gr-framers

if [ ! -d "build" ]; then
	mkdir build
fi

cd build
cmake ..
make
sudo make install

