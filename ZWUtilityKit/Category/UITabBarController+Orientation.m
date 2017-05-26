//
//  UITabBarController+Orientation.m
//  ZWUtilityKit
//
//  Created by 陈正旺 on 15/1/31.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import "UITabBarController+Orientation.h"

@implementation UITabBarController (Orientation)

- (BOOL)shouldAutorotate
{
    return self.selectedViewController.shouldAutorotate;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return self.selectedViewController.supportedInterfaceOrientations;
}

@end
