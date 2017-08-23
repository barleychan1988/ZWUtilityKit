//
//  UINavigationController+Orientation.m
//  ZWUtilityKit
//
//  Created by 陈正旺 on 15/1/31.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import "UINavigationController+Orientation.h"
#import "ZWMacroDef.h"

@implementation UINavigationController (Orientation)

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.topViewController.preferredStatusBarStyle;
}

@end

@implementation UINavigationController (Background)

- (void)setBackgroundImage:(UIImage *)image
{
    if (image == nil)
        return;
    UIImage *backgroundImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 20, 0)];
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarPosition:barMetrics:)])
    {
        //if iOS 5.0 and later
        //        [navController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setBackgroundImage:backgroundImage forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
        if (IOS7)
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
    }
    else
    {
        UIImageView *imageView = (UIImageView *)[self.navigationBar viewWithTag:10];
        if (imageView == nil)
        {
            imageView = [[UIImageView alloc] initWithImage:backgroundImage];
            [imageView setTag:10];
            [self.navigationBar insertSubview:imageView atIndex:0];
        }
    }
}

@end
