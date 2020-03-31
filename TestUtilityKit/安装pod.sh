#!/bin/sh

workPath=${0%/*}/

cd $workPath
pod install

open $workPath/TestUtilityKit.xcworkspace
