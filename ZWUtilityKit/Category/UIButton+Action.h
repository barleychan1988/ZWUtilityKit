//
//  UIButton+Action.h
//  ZWUtilityKit
//
//  Created by chenzw on 15/9/8.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TargetAction)

//删除对应事件的响应方法
- (void)removeTarget:(id)target forControlEvents:(UIControlEvents)controlEvents;
//删除对应目标的响应
- (void)removeTarget:(id)target;

@end