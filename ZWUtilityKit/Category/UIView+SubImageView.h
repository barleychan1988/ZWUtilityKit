//
//  UIView+SubImageView.h
//  DIY
//
//  Created by chenzw on 15/11/3.
//  Copyright © 2015年 BiggerSister. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SubImageView)

- (UIImageView *)addSubImageView:(UIImage *)image;
- (UIImageView *)addBackgroundImage:(UIImage *)image;

@end