//
//  ZWLocationAuthor.h
//  SuperCode
//
//  Created by chenpeng on 16/3/30.
//  Copyright © 2016年 chenzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UtilityKit.h"
#import "ZWMacroDef.h"

@interface ZWLocationAuthor : NSObject

@property (nonatomic, copy)BlockObject blockUpdateLocation;
@property (nonatomic, assign, readonly)BOOL bIsAlerting;
+ (ZWLocationAuthor *)getInstance;

@end

/*
 *  @bief:使得系统弹出“准许访问位置”授权确认
 *      用这个方法，plist中需要NSLocationAlwaysUsageDescription 和 NSLocationWhenInUseUsageDescription
 */
FOUNDATION_EXPORT void alertLocationAuthorization(BOOL bRepeat, BlockObject blockUpdateLocation);
//用户位置是否可用
BOOL isLocationEnable();
