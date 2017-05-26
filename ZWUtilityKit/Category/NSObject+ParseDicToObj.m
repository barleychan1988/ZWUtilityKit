//
//  ParseDicToObj.m
//  ZWUtilityKit
//
//  Created by EadkennyChan on 16/6/28.
//  Copyright © 2016年 zwchen. All rights reserved.
//

#import "NSObject+ParseDicToObj.h"
#import <objc/runtime.h>

@implementation NSObject (ParseDicToObj)

- (NSArray*)propertyKeys
{
    unsigned int nPropertyCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &nPropertyCount);
    NSMutableArray *mtArrayProperty = [[NSMutableArray alloc] initWithCapacity:nPropertyCount];
    for (i = 0; i < nPropertyCount; i++)
    {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [mtArrayProperty addObject:propertyName];
    }
    free(properties);
    return [mtArrayProperty copy];
}

- (void)setPropertyValue:(NSDictionary *)dicValue
{
    NSArray *arrayPropertyKey = [self propertyKeys];
    NSArray *arrayKeys = [dicValue allKeys];
    for (NSString *strKey in arrayKeys)
    {
        if ([arrayPropertyKey containsObject:strKey])
        {
            [self setValue:[dicValue objectForKey:strKey] forKey:strKey];
        }
    }
}

@end