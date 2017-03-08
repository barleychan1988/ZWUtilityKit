//
//  NSString+URL.m
//  ZWUtilityKit
//
//  Created by EadkennyChan on 16/8/26.
//  Copyright © 2016年 zwchen. All rights reserved.
//

#import "NSURL+EncodeString.h"
#import "ZWMacroDef.h"

@implementation NSURL (EncodeString)

+ (NSURL *)URLEncodedString:(NSString *)strUrl
{
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"!$&'()*+,-./:;=?@_~%#[]"] invertedSet];        
    NSString *encodedString = [strUrl stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return [NSURL URLWithString:encodedString];
}

@end
