#!/bin/sh

workPath=${0%/*}/TestUtilityKit/

cd $workPath
pod install

open $workPath/TestUtilityKit.xcworkspace
