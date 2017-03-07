//
//  NSDictionary+DictionarySafeValue.h
//  ZWUtilityKit
//
//  Created by 陈正旺 on 15/1/29.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString * _Nonnull stringValueForKey( NSDictionary *_Nonnull dic, NSString *_Nonnull strKey);
NSInteger integerValueForKey(NSDictionary *_Nonnull dic, NSString *_Nonnull strKey);

@interface NSObject (getSafeValue)
- (nonnull NSString *)stringValueForKey:(nonnull NSString *)strKey;
- (NSInteger)integerValueForKey:(nonnull NSString *)strKey;
- (int)intValueForKey:(nonnull NSString *)strKey;
- (BOOL)boolValueForKey:(nonnull NSString *)strKey;
- (float)floatValueForKey:(nonnull NSString *)strKey;
- (nullable id)safeObjectForKey:(nonnull NSString *)strKey;

- (void)setSafeObject:(nonnull id)value forKey:(nonnull id<NSCopying>)key;
@end


@interface NSObject (clone)

- (nonnull id)dumplicate;

@end

@interface NSObject (Dictionary2Obj)
+ (nonnull instancetype)objectWithData:(nonnull NSDictionary *)dicData;
+ (nullable NSArray *)objectsWithDatas:(nullable NSArray<NSDictionary *> *)arrayDatas;
@end
