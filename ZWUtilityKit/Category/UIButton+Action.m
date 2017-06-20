//
//  UIButton+Action.m
//  ZWUtilityKit
//
//  Created by chenzw on 15/9/8.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import "UIButton+Action.h"


@implementation UIButton (TargetAction)

- (void)removeTarget:(id)target forControlEvents:(UIControlEvents)controlEvents
{
    NSArray *arrayActions = [self actionsForTarget:target forControlEvent:controlEvents];
    for (NSString *strActionName in arrayActions)
    {
        [self removeTarget:target action:NSSelectorFromString(strActionName) forControlEvents:controlEvents];
    }
}

- (void)removeTarget:(id)target
{
    [self removeTarget:target action:nil forControlEvents:UIControlEventAllEvents];
}

@end
