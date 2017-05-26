//
//  UIEditView.h
//  Test
//
//  Created by chenzw on 15/6/15.
//  Copyright (c) 2015年 BiggerSister. All rights reserved.
//

/*
 *  @brief: ZWEditView处于选中状态时按住右下角按钮可以随意缩放、旋转大小；点击左上角按钮可以移除该实例
 *      点击ZWEditView时，则该实例便会处于选中状态
 *
 */

#import <UIKit/UIKit.h>

@protocol ZWEditViewDelegate;


@interface ZWEditView : UIView

@property (nonatomic, assign)id<ZWEditViewDelegate> delegate;
@property (strong, nonatomic) UIImage *imageCloseBtn;   //image size 16*16
@property (strong, nonatomic) UIImage *imageRotateBtn;  //image size 16*16

@property (retain, nonatomic) UIColor *colorSelectedFrame;  //选中时边框颜色 default is red.
@property (nonatomic, assign)CGFloat fWidthSelectedFrame;//选中时边框宽度 default is 1.0.
@property (nonatomic, assign)BOOL bDashLine;    //选中时边框是否为虚线 default is YES.

@property (nonatomic, assign)BOOL bBringToFrontWhenSelected; //default is YES.
@property (nonatomic, retain)UIView *contentView;
@property (nonatomic, assign)BOOL bIsCloseToBorder;//contentView是否贴合边框 default is NO.

@property (nonatomic, assign)BOOL bCanEdit;//能否被选中开关  default is YES.
@property (nonatomic, assign)BOOL bCanRotateScale;//能否拉伸选中开关  default is YES.
@property (nonatomic, assign)BOOL bCanClose;//是否可以显示关闭按钮  default is YES.
@property (nonatomic, assign)BOOL bCanMove;//是否可以移动窗口开关  default is YES.

@property (nonatomic, assign, readonly)CGFloat fScale;//拉伸时产生的比例
@property (nonatomic, readonly, assign)CGSize sizeMinContentView;//contentView最小的size,default is CGSizeZero.

/*
 *  @brief: 设置contentView的位置
 */
- (void)setContentFrame:(CGRect)frame;

- (void)rotateViewPanGesture:(UIPanGestureRecognizer *)panGesture;
- (void)moveGesture:(UIPanGestureRecognizer *)panGesture;

- (CGSize)mininumSizeScale;

@end

@protocol ZWEditViewDelegate <NSObject>

@optional
- (BOOL)editViewWillRemoved:(ZWEditView *)editView;     //default is YES.
- (void)editViewDidRemoved:(ZWEditView *)editView;
- (BOOL)editViewWillSelected:(ZWEditView *)editView;    //default is YES.
- (void)editViewDidSelected:(ZWEditView *)eidtView;
- (BOOL)editViewWillMove:(ZWEditView *)editView;    //default is YES.
- (void)editViewDidMove:(ZWEditView *)eidtView;

@end