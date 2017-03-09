//
//  NetworkApply.h
//  ZWUtilityKit
//
//  Created by EadkennyChan on 17/3/9.
//  Copyright © 2017年 EadkennyChan. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *  @brief: 判断网络是否可用
 */
FOUNDATION_EXPORT BOOL isNetworkAvailabel();
BOOL addNetworkMonitor(id observer, SEL aSelector);
void removeNetworkMonitor(id observer);
