//
//  TFIndicatorView.h
//  Tiffany
//
//  Created by ff on 13-7-5.
//  Copyright (c) 2013年 ff. All rights reserved.
//
/* ------------------------------------------------------
 *
 * @description：自定义的旋转风火轮
 *
 * @update time: 2014-07-17 子视图自动保持相对位置
 *
 * ------------------------------------------------------*/

#import <UIKit/UIKit.h>

@interface TFIndicatorView : UIView

@property (nonatomic,assign) NSUInteger numOfObjects;
@property (nonatomic,assign) CGSize objectSize;
@property (nonatomic,retain) UIColor *color;


-(void)startAnimating;
-(void)stopAnimating;


@end
