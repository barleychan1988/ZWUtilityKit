//
//  ZWNetImageView.m
//  Test
//
//  Created by chenzw on 15/8/8.
//  Copyright (c) 2015年 BiggerSister. All rights reserved.
//

#import "ZWNetImageView.h"

@interface ZWNetImageView ()<ZWIndicatorProtocol>
{
    UIImageView *m_imageView;
}
@end

@implementation ZWNetImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initSubviews];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    _activityView = [[ZWIndicatorView alloc] initWithFrame:self.bounds];
    _activityView.delegate = self;
    _activityView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:_activityView];
}

- (void)setStrUrl:(NSString *)strUrl
{
    _strUrl = strUrl;
    [self startDownLoad];
}

- (void)setImage:(UIImage *)image
{
    if (m_imageView == nil)
    {
        m_imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        m_imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:m_imageView];
    }
    else if ([m_imageView superview] == nil)
    {
        [self addSubview:m_imageView];
    }
    if (image)
    {
        m_imageView.image = image;
        [_activityView stopAnimating];
    }
}

- (void)startDownLoad
{
    [m_imageView removeFromSuperview];
    [_activityView startAnimating];
    [NSThread detachNewThreadSelector:@selector(loadNetImage:) toTarget:self withObject:_strUrl];
}

- (void)loadNetImage:(NSString *)strUrl
{
    NSURL *nsUrl = [NSURL URLWithString:strUrl];
    NSData *data = [[NSData alloc]initWithContentsOfURL:nsUrl];
    UIImage *image = [[UIImage alloc] initWithData:data];
    if (image)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setImage:image];
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            _activityView.strTipTitle = @"下载失败，请检查图片地址是否正确";
        });
    }
}

#pragma mark - 

- (void)reloadRequest
{
    [self startDownLoad];
}

@end