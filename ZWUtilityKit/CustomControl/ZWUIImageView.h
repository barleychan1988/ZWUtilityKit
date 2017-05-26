//
//  ZWUIImageView.h
//  ZWUtilityKit
//
//  Created by chenzw on 15/9/18.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWUIImageView : UIImageView

@property (nonatomic, retain)UIImage *imageLoading;//正在加载时显示的图
@property (nonatomic, retain)UIImage *imageFailed;//加载失败后显示的图

@end