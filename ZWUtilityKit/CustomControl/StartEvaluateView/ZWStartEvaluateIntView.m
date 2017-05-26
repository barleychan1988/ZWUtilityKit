//
//  ZWStartEvaluateIntView.m
//  ZWUtilityKit
//
//  Created by chenzw on 15/9/10.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import "ZWStartEvaluateIntView.h"

@interface ZWStartEvaluateIntView ()
{
    UIView *m_viewBtnsPan;
    NSArray *m_arrayImageViews;
    UIView *m_viewEnable;//裁剪评分显示
}
@end


@implementation ZWStartEvaluateIntView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    _bCanEvaluate = NO;
    
    _fMaxScore = 100;
    _fMinScore = 0;
    _fScore = _fMinScore;
    
    self.nStartNum = 5;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat fWith = (self.bounds.size.width - 10 * _nStartNum + 10) / _nStartNum;
    CGRect frame = self.bounds;
    if (fWith > self.bounds.size.height)
    {
        fWith = self.bounds.size.height;
    }
    else
    {
        frame.origin.y = (self.bounds.size.height - fWith) / 2;
    }
    frame.size = CGSizeMake(fWith, fWith);
    CGFloat fDiff = (self.bounds.size.width - _nStartNum * fWith) / (_nStartNum - 1);
    
    UIView *subview;
    for (NSInteger nIndex = 0; nIndex < _nStartNum; nIndex++)
    {
        subview = [m_arrayImageViews objectAtIndex:nIndex];
        subview.frame = frame;
        
        subview = [m_viewBtnsPan.subviews objectAtIndex:nIndex];
        subview.frame = frame;
        
        subview = [m_viewEnable.subviews objectAtIndex:nIndex];
        subview.frame = frame;
        
        frame.origin.x += (frame.size.width + fDiff);
    }
    
    int nStartNum = (int)(_fScore / (_fMaxScore - _fMinScore) * _nStartNum);//星星的整数个
    if (nStartNum / _nStartNum * (_fMaxScore - _fMinScore) < _fScore)
    {
        nStartNum++;
    }
    
    frame = self.bounds;
    frame.size.width = _fScore / (_fMaxScore - _fMinScore) * _nStartNum * fWith;
    if (nStartNum > 1)
        frame.size.width += (nStartNum - 1) * fDiff;
    m_viewEnable.frame = frame;
}

- (void)setNStartNum:(NSInteger)nStartNum
{
    _nStartNum = nStartNum;
    if (_bCanEvaluate)
    {
        if (m_viewBtnsPan == nil)
        {
            UIView *viewBtns = [[UIView alloc] initWithFrame:self.bounds];
            viewBtns.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            viewBtns.backgroundColor = [UIColor clearColor];
            viewBtns.clipsToBounds = YES;
            [self addSubview:viewBtns];
            m_viewBtnsPan = viewBtns;
        }
        else
        {
            for (UIView *subview in m_viewBtnsPan.subviews)
            {
                [subview removeFromSuperview];
            }
        }
        [self sendSubviewToBack:m_viewBtnsPan];
        UIButton *btn;
        for (NSInteger nIndex = 0; nIndex < _nStartNum; nIndex ++)
        {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addTarget:self action:@selector(btnClickedEvaluate:) forControlEvents:UIControlEventTouchUpInside];
            [m_viewBtnsPan addSubview:btn];
        }
    }
}

- (void)setImageDisable:(UIImage *)imageDisable
{
    if (imageDisable == nil)
        return;
    _imageDisable = imageDisable;
    
    NSMutableArray *mtArray = [NSMutableArray arrayWithCapacity:_nStartNum];
    UIImageView *imageView;
    for (NSInteger nIndex = 0; nIndex < _nStartNum; nIndex ++)
    {
        imageView = [[UIImageView alloc] initWithImage:_imageDisable];
        imageView.userInteractionEnabled = NO;
        [self addSubview:imageView];
        [mtArray addObject:imageView];
    }
    m_arrayImageViews = mtArray;
    [self bringSubviewToFront:m_viewEnable];
}

- (void)setImageEnable:(UIImage *)imageEnable
{
    if (imageEnable == nil)
        return;
    _imageEnable = imageEnable;
    
    if (m_viewEnable == nil)
    {
        UIView *viewEnable = [[UIView alloc] initWithFrame:self.bounds];
        viewEnable.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        viewEnable.backgroundColor = [UIColor clearColor];
        viewEnable.clipsToBounds = YES;
        viewEnable.userInteractionEnabled = NO;
        [self addSubview:viewEnable];
        m_viewEnable = viewEnable;
    }
    [self bringSubviewToFront:m_viewEnable];
    
    UIImageView *imageView;
    for (NSInteger nIndex = 0; nIndex < _nStartNum; nIndex ++)
    {
        imageView = [[UIImageView alloc] initWithImage:_imageEnable];
        imageView.userInteractionEnabled = NO;
        [m_viewEnable addSubview:imageView];
    }
}

- (IBAction)btnClickedEvaluate:(UIButton *)sender
{
    NSInteger nIndex = [m_viewBtnsPan.subviews indexOfObject:sender];
    _fScore = (nIndex + 1) / (float)_nStartNum * (_fMaxScore - _fMinScore);
    [self layoutSubviews];
}

- (void)setFScore:(float)fScore
{
    _fScore = fScore;
    [self layoutSubviews];
}

@end