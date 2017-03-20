//
//  UINavigationController+TitleBar.m
//  ZWUtilityKit
//
//  Created by EadkennyChan on 17/3/20.
//  Copyright © 2017年 EadkennyChan. All rights reserved.
//

#import "UINavigationController+TitleBar.h"

@implementation UINavigationController (TitleBar)

- (void)setTranslucent
{
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.translucent = YES;
    
    for (UIView *subview in self.navigationController.navigationBar.subviews)
    {
        NSString *strClassName = NSStringFromClass(subview.class);
        NSRange range = [strClassName rangeOfString:@"BarBackground"];
        if (range.location != NSNotFound)
        {
            subview.hidden = YES;
            break;
        }
    }
}

- (void)setupBackgrounImage:(UIImage *)image textColor:(UIColor *)color statusBar:(UIStatusBarStyle)barStyle
{
    for (UIView *subview in self.navigationController.navigationBar.subviews)
    {
        NSString *strClassName = NSStringFromClass(subview.class);
        NSRange range = [strClassName rangeOfString:@"BarBackground"];
        if (range.location != NSNotFound)
        {
            subview.hidden = NO;
            break;
        }
    }
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:color}];
    
_Pragma("clang diagnostic push")
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"")
    [[UIApplication sharedApplication] setStatusBarStyle:barStyle];
_Pragma("clang diagnostic pop")
}

@end
