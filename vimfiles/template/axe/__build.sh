#!/bin/bash
echo "-- Build bootstrap"
cd ./axe-bootstrap
../__booststrap.sh
install -m 755 axe $AXE_ROOT/_axe && rm -f ./axe
echo "-- bootstrap ok --"
echo "-- Build axe"
cd $AXE_ROOT/../axe/source/compiler
$AXE_ROOT/_axe axc.axe --release
install -m 755 axc $AXE_ROOT/axe && rm -f ./axc ./axc.dSYM
echo "-- axe ok --"
echo "-- Build saw"
cd $AXE_ROOT/../saw
axe saw --release
install -m 755 saw $AXE_ROOT/saw && rm -f ./saw
echo "-- saw ok --"
echo "-- Build axedoc"
cd $AXE_ROOT/../axedoc
axe axedoc --release -lpcre
install -m 755 axedoc $AXE_ROOT/axedoc && rm -f ./axedoc
echo "-- axedoc ok --"
echo "-- Build axels --"
cd $AXE_ROOT/../axels
dmd -O -release -inline ./source/axels/main.d -of=./axels
install -m 755 axels $AXE_ROOT/axels && rm -f ./axels ./axels.o
echo "-- saw ok --"
