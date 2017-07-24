//
//  NetworkDetection.m
//  ZWUtilityKit
//
//  Created by EadkennyChan on 17/5/26.
//  Copyright © 2017年 zwchen. All rights reserved.
//

#import "NetworkDetection.h"
#import "Reachability.h"

BOOL isNetworkAvailabel()
{
    /*
     *网络探测, return YES 为网络正常, return NO 为网络未连接
     */
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

BOOL addNetworkMonitor(id observer, SEL aSelector)
{
    BOOL bRet = NO;
    bRet = [[Reachability reachabilityForInternetConnection] startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector name:kReachabilityChangedNotification object:nil];
    return bRet;
}

void removeNetworkMonitor(id observer)
{
    [[Reachability reachabilityForInternetConnection] stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:kReachabilityChangedNotification object:nil];
}
