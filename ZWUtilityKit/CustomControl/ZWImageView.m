//
//  ZWImageView.m
//  ZWUtilityKit
//
//  Created by EadkennyChan on 16/10/28.
//  Copyright © 2016年 zwchen. All rights reserved.
//

#import "ZWImageView.h"

@interface ZWImageView()
{
    UIImageView *m_imageView;
}
@end

@implementation ZWImageView

- (id)init
{
    self = [super init];
    if (self)
    {
        self.userInteractionEnabled = NO;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = NO;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (UIImageView *)imageView
{
    if (m_imageView == nil)
    {
        UIImageView *imgV = [[UIImageView alloc] init];
        [self addSubview:imgV];
        m_imageView = imgV;
    }
    return m_imageView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (m_imageView.image)
    {
        CGRect frame = self.bounds;
        CGFloat fRateWByH = m_imageView.image.size.width / m_imageView.image.size.height;
        if (fRateWByH > frame.size.width / frame.size.height)
        {
            frame.size.width = fRateWByH * frame.size.height;
        }
        else
            frame.size.height = frame.size.width / fRateWByH;
        frame.origin.x = (self.bounds.size.width - frame.size.width) / 2;
        frame.origin.y = (self.bounds.size.height - frame.size.height) / 2;
        m_imageView.frame = frame;
    }
}
@end
