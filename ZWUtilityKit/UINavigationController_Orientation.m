//
//  UINavigationController+Orientation.m
//  ODB
//
//  Created by chenzhengwang on 14-3-15.
//  Copyright (c) 2014年 lixufeng. All rights reserved.
//

#import "UINavigationController_Orientation.h"
#import "UtilityKit.h"
#import "UINavigationController+BarButtonItem.h"
#import "ZWMacroDef.h"


@interface UINavigationController_Orientation ()<UIGestureRecognizerDelegate>

@end

@implementation UINavigationController_Orientation

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self)
    {
        self.interactivePopGestureRecognizer.delegate = self;
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if (viewController != [self.viewControllers firstObject])
    {
        [self setDefaultBackBarButtonItem];
    }
}

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

@implementation UINavigationController_Orientation (Orientation)

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self.topViewController respondsToSelector:@selector(gestureRecognizerShouldBegin:)])
    {
        id<UIGestureRecognizerDelegate> topVC = (id<UIGestureRecognizerDelegate>)self.topViewController;
        return [topVC gestureRecognizerShouldBegin:gestureRecognizer];
    }
    return (self.viewControllers.count > 1);//关闭主界面的右滑返回
}

@end
