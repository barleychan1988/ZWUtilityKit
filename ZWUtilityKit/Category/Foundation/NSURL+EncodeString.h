//
//  NSString+URL.h
//  ZWUtilityKit
//
//  Created by EadkennyChan on 16/8/26.
//  Copyright © 2016年 zwchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>

@interface NSURL (EncodeString)

+ (NSURL *)URLEncodedString:(NSString *)strUrl;

@end
