//
//  NSDictionary+NSData.h
//  ZWUtilityKit
//
//  Created by chenzw on 15/5/29.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (toNSData)

+ (NSData*)Convert2NSData:(NSDictionary*)dict;
+ (NSDictionary*)ConvertFromNSData:(NSData *)data;

@end
