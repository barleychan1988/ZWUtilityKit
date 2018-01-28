//
//  NetworkDetection.h
//  ZWUtilityKit
//
//  Created by EadkennyChan on 17/5/26.
//  Copyright © 2017年 zwchen. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - network
/*
 *  @brief: 判断网络是否可用
 */
FOUNDATION_EXPORT BOOL isNetworkAvailabel(void);
BOOL addNetworkMonitor(id observer, SEL aSelector);
void removeNetworkMonitor(id observer);
