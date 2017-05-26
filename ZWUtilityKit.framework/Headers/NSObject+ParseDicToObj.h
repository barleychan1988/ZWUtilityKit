//
//  ParseDicToObj.h
//  ZWUtilityKit
//
//  Created by EadkennyChan on 16/6/28.
//  Copyright © 2016年 zwchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ParseDicToObj)
/*
 *  @brief：获取类属性变量名
 */
- (NSArray*)propertyKeys;
/*
 *  @brief：设置属性值
 *  @param：
 *      dicValue：属性名和值
 */
- (void)setPropertyValue:(NSDictionary *)dicValue;

@end