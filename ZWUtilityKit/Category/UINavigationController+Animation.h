//
//  UINavigationController+Animation.h
//  ZWUtilityKit
//
//  Created by chenzw on 15/7/28.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Animation)

- (void)customPresentViewController:(UIViewController *)vc;
- (void)customDismiss;
- (void)customPopToViewController:(UIViewController *)vc;

@end