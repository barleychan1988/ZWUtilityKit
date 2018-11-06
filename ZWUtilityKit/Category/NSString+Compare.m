//
//  NSString+Compare.m
//  SCBase
//
//  Created by Eadkenny on 2018/3/13.
//

#import "NSString+Compare.h"

@implementation NSString (Compare)

- (BOOL)isEqualToInsensitiveString:(NSString *)aString
{
    NSComparisonResult result = [self caseInsensitiveCompare:aString];
    return result == NSOrderedSame;
}

@end
