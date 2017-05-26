//
//  NSString+DocumentPath.m
//  气泡
//
//  Created by zzy on 14-5-15.
//  Update by zwchen on 15.10.28
//  Copyright (c) 2014年 zzy. All rights reserved.
//

#import "NSString+DocumentPath.h"

@implementation NSString (DocumentPath)

+ (NSString *)documentPathWith:(NSString *)fileName
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
}

+ (NSString *)libraryPathWith:(NSString *)fileName
{
    return [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
}

+ (NSString *)tmpPathWith:(NSString *)fileName
{
    return [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
}

- (NSString *)stringByDeletingScaleType
{
    NSRange range = [self rangeOfString:@"@2x."];
    if (range.length > 0)
    {
    }
    else if ((range = [self rangeOfString:@"3x."]).length > 0)
    {
    }
    else
    {
        return self;
    }
    return [self stringByReplacingCharactersInRange:NSMakeRange(range.location, range.length - 1) withString:@""];
}

- (NSString *)stringByDeletingIconType
{
    NSRange range = [self rangeOfString:@"_icon"];
    if (range.length == 0)
    {
        return self;
    }
    return [self stringByReplacingCharactersInRange:range withString:@""];
}

@end