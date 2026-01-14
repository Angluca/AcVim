#!/bin/bash
echo "-- Update axe-bootstrap"
cd ./axe-bootstrap
git pull
echo "-- Update axe"
cd ../axe
git pull
echo "-- Update saw"
cd ../saw
git pull
echo "-- Update axedoc"
cd ../axedoc
git pull
echo "-- Update axels"
cd ../axels
git pull
