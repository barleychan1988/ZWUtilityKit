//
//  macroDef.h
//  ZWUtilityKit
//
//  Created by EadkennyChan on 16/7/28.
//  Copyright © 2016年 zwchen. All rights reserved.
//

#ifndef macroDef_h
#define macroDef_h

#import <Foundation/Foundation.h>

/*
 *  @brief: 消除在ARC时，调用performSelector:产生的编译警告
 *  @ex:
 *      之前：[_target performSelector:_action withObject:self];//会产生报警
 *      现在：SuppressPerformSelectorLeakWarning([_target performSelector:_action withObject:self]);
 */
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

//系统版本
#define SystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS7 (SystemVersion>=7.0 ? YES : NO)
#define IOS8 (SystemVersion>=8.0 ? YES : NO)
#define IOS9 (SystemVersion>=9.0 ? YES : NO)
#define IOS10 (SystemVersion>=10.0 ? YES : NO)

#define iPhone4 (getDeviceTypeSize() == DEVICE_SIZE_iPhone_4)
#define iPhone5 (getDeviceTypeSize() == DEVICE_SIZE_iPhone_5)
#define iPhone6 (getDeviceTypeSize() == DEVICE_SIZE_iPhone_6)
#define iPhone6Plus (getDeviceTypeSize() == DEVICE_SIZE_iPhone_6_Plus)
/*
 * @brief 获得全局的delegate
 */
#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

typedef void (^BlockVoid)();
typedef void (^BlockBoolObject)(BOOL bFlage, id object);
typedef void (^BlockObject)(id object);

#endif /* macroDef_h */
