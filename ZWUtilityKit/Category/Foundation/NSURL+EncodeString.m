//
//  NSString+URL.m
//  ZWUtilityKit
//
//  Created by EadkennyChan on 16/8/26.
//  Copyright © 2016年 zwchen. All rights reserved.
//

#import "NSURL+EncodeString.h"

@implementation NSURL (EncodeString)

+ (NSURL *)URLEncodedString:(NSString *)strUrl
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)strUrl,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return [NSURL URLWithString:encodedString];
}

@end