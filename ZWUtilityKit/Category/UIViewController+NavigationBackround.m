//
//  UIViewController+NavigationBackround.m
//  Pods
//
//  Created by Eadkenny on 2018/1/16.
//

#import "UIViewController+NavigationBackround.h"

@implementation UIViewController (NavigationBackround)

- (void)setNavBarBackgroundColor:(UIColor *)color NS_AVAILABLE_IOS(7_0)
{
    if (color == nil || color == [UIColor clearColor])
    {
        [self setNavBarBackgroundImage:nil];
    }
    else
    {
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 128.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [self setNavBarBackgroundImage:image];
    }
}

- (void)setNavBarBackgroundImage:(UIImage *)image NS_AVAILABLE_IOS(7_0)
{
    if (image == nil)
    {
        self.edgesForExtendedLayout |= UIRectEdgeTop;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        self.navigationController.navigationBar.translucent = YES;
    }
    else
    {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        [self.navigationController.navigationBar setBackgroundImage:image forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.translucent = NO;
    }
}

@end
