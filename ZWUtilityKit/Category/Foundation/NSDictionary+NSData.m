//
//  NSDictionary+NSData.m
//  ZWUtilityKit
//
//  Created by chenzw on 15/5/29.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import "NSDictionary+NSData.h"

@implementation NSDictionary(toNSData)

+ (NSData*)Convert2NSData:(NSDictionary*)dict
{
    NSMutableData* data = [NSMutableData alloc];
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dict forKey:@"talkData"];
    [archiver finishEncoding];
    return data;
}

+ (NSDictionary*)ConvertFromNSData:(NSData *)data
{
    NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    NSDictionary* myDictionary = [unarchiver decodeObjectForKey:@"talkData"];
    [unarchiver finishDecoding];
    return myDictionary;
}

@end