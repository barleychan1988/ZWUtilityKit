//
//  UINavigationController+TitleBar.h
//  ZWUtilityKit
//
//  Created by EadkennyChan on 17/3/20.
//  Copyright © 2017年 EadkennyChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (TitleBar)

//设置导航栏透明
- (void)setTranslucent;
- (void)setupBackgrounImage:(UIImage *)image textColor:(UIColor *)color statusBar:(UIStatusBarStyle)barStyle;

@end
