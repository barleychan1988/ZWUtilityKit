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
{ \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
}

//系统版本
#define SystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS7 (SystemVersion>=7.0 ? YES : NO)
#define IOS8 (SystemVersion>=8.0 ? YES : NO)
#define IOS9 (SystemVersion>=9.0 ? YES : NO)
#define IOS10 (SystemVersion>=10.0 ? YES : NO)
#define IOS11 (SystemVersion>=11.0 ? YES : NO)

#define iPhone4 (getDeviceTypeSize() == DEVICE_SIZE_iPhone_4)
#define iPhone5 (getDeviceTypeSize() == DEVICE_SIZE_iPhone_5)
#define iPhone6 (getDeviceTypeSize() == DEVICE_SIZE_iPhone_6)
#define iPhone6Plus (getDeviceTypeSize() == DEVICE_SIZE_iPhone_6_Plus)
#define iPhoneX (getDeviceTypeSize() == DEVICE_SIZE_iPhone_X)

#define WeakObject(obj) __weak typeof(obj) weakObject = obj
#define StrongObject(obj) __strong typeof(obj) strongObject = weakObject

/*
 * @brief 获得全局的delegate
 */
#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

typedef void (^BlockBoolStrObject)(BOOL, NSString *_Nullable, id _Nullable );
typedef void (^BlockVoid)(void);
typedef void (^BlockBoolObject)(BOOL bFlag, id _Nullable object);
typedef void (^BlockObject)(id _Nullable object);
typedef void (^BlockInteger)(long nValue);
typedef void (^BlockObjectObject)(id _Nullable object1, id _Nullable object2);
typedef id _Nullable (^BLOCKObject_Void)(void);
typedef BOOL (^BLOCKBOOL_Void)(void);
typedef BOOL (^BLOCKBOOL_Object)(id _Nullable);

#endif /* macroDef_h */
