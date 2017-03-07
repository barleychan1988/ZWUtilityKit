//
//  NSDictionary+DictionarySafeValue.m
//  ZWUtilityKit
//
//  Created by 陈正旺 on 15/1/29.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import "Dictionary+SafeValue.h"

NSString *stringValueForKey(NSDictionary *dic, NSString *strKey)
{
    if ([dic isKindOfClass:[NSDictionary class]] && [dic count] > 0)
    {
        NSString *strValue = [dic objectForKey:strKey];
        if ([strValue isKindOfClass:[NSString class]])
            return strValue;
    }
    return @"";
}

NSInteger integerValueForKey(NSDictionary *dic, NSString *strKey)
{
    if ([dic isKindOfClass:[NSDictionary class]] && [dic count] > 0)
    {
        NSNumber *numValue = [dic objectForKey:strKey];
        if ([numValue isKindOfClass:[NSNumber class]])
        {
            return numValue.integerValue;
        }
        else if ([numValue isKindOfClass:[NSString class]])
        {
            return ((NSString *)numValue).integerValue;
        }
        else
        {
        }
        
    }
    return -1;
}

@implementation NSObject (getSafeValue)

- (NSString *)stringValueForKey:(NSString *)strKey
{
    if (![self isKindOfClass:[NSDictionary class]] || ((NSDictionary *)self).count == 0)
    {
        return @"";
    }
    NSDictionary *_self = (NSDictionary *)self;
    if ([_self count] > 0)
    {
        NSString *strValue = [_self objectForKey:strKey];
        if (strValue == nil || [strValue isKindOfClass:[NSNull class]])
        {
            return @"";
        }
        else if ([strValue isKindOfClass:[NSString class]])
        {
            return strValue;
        }
        else
        {
            return [NSString stringWithFormat:@"%@", strValue];
        }
    }
    return @"";
}

- (NSInteger)integerValueForKey:(NSString *)strKey
{
    if (![self isKindOfClass:[NSDictionary class]] || ((NSDictionary *)self).count == 0)
    {
        return 0;
    }
    NSDictionary *_self = (NSDictionary *)self;
    if ([_self count] > 0)
    {
        NSNumber *numValue = [_self objectForKey:strKey];
        if ([numValue isKindOfClass:[NSNumber class]])
        {
            return numValue.integerValue;
        }
        else if ([numValue isKindOfClass:[NSString class]])
        {
            return ((NSString *)numValue).integerValue;
        }
        else
        {
        }
        
    }
    return 0;
}

- (int)intValueForKey:(NSString *)strKey
{
    if (![self isKindOfClass:[NSDictionary class]] || ((NSDictionary *)self).count == 0)
    {
        return 65535;
    }
    NSDictionary *_self = (NSDictionary *)self;
    if ([_self count] > 0)
    {
        NSNumber *numValue = [_self objectForKey:strKey];
        if ([numValue isKindOfClass:[NSNumber class]])
        {
            return numValue.intValue;
        }
        else if ([numValue isKindOfClass:[NSString class]])
        {
            return ((NSString *)numValue).intValue;
        }
        else
        {
        }
        
    }
    return 65535;
}

- (BOOL)boolValueForKey:(NSString *)strKey
{
    if (![self isKindOfClass:[NSDictionary class]] || ((NSDictionary *)self).count == 0)
    {
        return NO;
    }
    NSDictionary *_self = (NSDictionary *)self;
    if ([_self count] > 0)
    {
        NSNumber *numValue = [_self objectForKey:strKey];
        if ([numValue isKindOfClass:[NSNumber class]])
        {
            return numValue.boolValue;
        }
        else if ([numValue isKindOfClass:[NSString class]])
        {
            return ((NSString *)numValue).boolValue;
        }
        else
        {
        }
        
    }
    return NO;
}

- (float)floatValueForKey:(NSString *)strKey
{
    if (![self isKindOfClass:[NSDictionary class]] || ((NSDictionary *)self).count == 0)
    {
        return 0.0;
    }
    NSDictionary *_self = (NSDictionary *)self;
    if ([_self count] > 0)
    {
        NSNumber *numValue = [_self objectForKey:strKey];
        if ([numValue isKindOfClass:[NSNumber class]])
        {
            return numValue.floatValue;
        }
        else if ([numValue isKindOfClass:[NSString class]])
        {
            return ((NSString *)numValue).floatValue;
        }
        else
        {
        }
        
    }
    return 0.0;
}

- (id)safeObjectForKey:(NSString *)strKey
{
    if (![self isKindOfClass:[NSDictionary class]] || ((NSDictionary *)self).count == 0)
    {
        return nil;
    }
    NSDictionary *_self = (NSDictionary *)self;
    id object = [_self objectForKey:strKey];
    if ([object isKindOfClass:[NSNull class]])
    {
        object = nil;
    }
    return object;
}

- (void)setSafeObject:(nonnull id)value forKey:(nonnull id<NSCopying>)key
{
    if ([self isKindOfClass:[NSMutableDictionary class]] && value != nil)
    {
        NSMutableDictionary *_self = (NSMutableDictionary *)self;
        [_self setObject:value forKey:key];
    }
}

@end


@implementation NSObject (clone)

- (id)dumplicate
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

@end


@implementation NSObject (Dictionary2Obj)

+ (instancetype)objectWithData:(NSDictionary *)dicData
{
    return [[[self class] alloc] initWithDictionary:dicData];
}

+ (NSArray *)objectsWithDatas:(NSArray<NSDictionary *> *)arrayDatas
{
    if (arrayDatas.count == 0)
        return nil;
    NSMutableArray *mtArray = [NSMutableArray arrayWithCapacity:[arrayDatas count]];
    for (NSDictionary *dic in arrayDatas)
    {
        [mtArray addObject:[[[self class] alloc] initWithDictionary:dic]];
    }
    return mtArray;
}

@end
