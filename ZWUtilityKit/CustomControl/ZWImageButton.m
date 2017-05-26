//
//  ZWImageButton.m
//  DIY
//
//  Created by chenzw on 16/1/4.
//  Copyright © 2016年 BiggerSister. All rights reserved.
//

#import "ZWImageButton.h"

@interface ZWImageButton ()
{
    UIImageView *m_imageView;
}
@end

@implementation ZWImageButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:imgV];
        m_imageView = imgV;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (m_imageView.image)
    {
        if (m_imageView.image.size.width < self.frame.size.width && m_imageView.image.size.height < self.frame.size.height)
        {
            CGRect frame;
            frame.size = m_imageView.image.size;
            frame.origin.x = (self.bounds.size.width - frame.size.width) / 2;
            frame.origin.y = (self.bounds.size.height - frame.size.height) / 2;
            m_imageView.frame = frame;
        }
    }
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    m_imageView.image = image;
    [self setNeedsLayout];
}

@end