//
//  ZWIndicatorView.m
//  checkCar
//
//  Created by chenzhengwang on 14-7-5.
//  Copyright (c) 2014年 zwchen. All rights reserved.
//

#import "ZWIndicatorView.h"

@interface ZWIndicatorView ()
{
    TFIndicatorView *m_indicatorView;
    UILabel *m_labelTipTitle;
}
@end

@implementation ZWIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        self.autoresizesSubviews = YES;
        
        m_indicatorView = [[TFIndicatorView alloc] initWithFrame:CGRectMake((frame.size.width - 50) / 2, (frame.size.height - 50) / 2, 50.0, 50.0)];
        m_indicatorView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:m_indicatorView];
        [self startAnimating];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
/*
 *  @brief:隐藏提示文字Label，开始旋转风火轮加载动画，移除点击事件响应
 *
 */
-(void)startAnimating
{
    [m_labelTipTitle setHidden:YES];
    [m_indicatorView startAnimating];
//    [m_indicatorView performSelectorInBackground:@selector(startAnimating) withObject:nil];
    [self removeTarget:self action:@selector(reload:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)stopAnimating
{
    [m_labelTipTitle setHidden:NO];
    [m_indicatorView stopAnimating];
//    [m_indicatorView performSelectorInBackground:@selector(stopAnimating) withObject:nil];
    [self addTarget:self action:@selector(reload:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setStrTipTitle:(NSString *)strTipTitle
{
    if (m_labelTipTitle == nil)
    {
        m_labelTipTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200.0, 44)];
        m_labelTipTitle.textColor = [UIColor grayColor];
        m_labelTipTitle.backgroundColor = [UIColor clearColor];
        m_labelTipTitle.textAlignment = NSTextAlignmentCenter;
        m_labelTipTitle.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        m_labelTipTitle.font = [UIFont systemFontOfSize:14];
        [self addSubview:m_labelTipTitle];
    }
    if ([strTipTitle length] > 0)
    {
        m_labelTipTitle.text = strTipTitle;
        [self stopAnimating];
    }
    else
    {
        [self startAnimating];
    }
    m_labelTipTitle.frame = CGRectMake((self.frame.size.width - m_labelTipTitle.frame.size.width) / 2, (self.frame.size.height - m_labelTipTitle.frame.size.height) / 2, m_labelTipTitle.frame.size.width, m_labelTipTitle.frame.size.height);
}

- (IBAction)reload:(id)sender
{
    [self startAnimating];
    if ([_delegate respondsToSelector:@selector(reloadRequest)])
    {
        [_delegate reloadRequest];
    }
}

@end