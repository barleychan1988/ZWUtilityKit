//
//  UIView+SubImageView.m
//  DIY
//
//  Created by chenzw on 15/11/3.
//  Copyright © 2015年 BiggerSister. All rights reserved.
//

#import "UIView+SubImageView.h"

@implementation UIView (SubImageView)

- (UIImageView *)addSubImageView:(UIImage *)image
{
    UIImageView *imgV = [[UIImageView alloc] initWithImage:image];
    [self addSubview:imgV];
    
    CGRect frame = self.bounds;
    if (image.size.width < self.bounds.size.width && image.size.height < self.bounds.size.height)
    {
        frame.size = image.size;
        frame.origin.x = (self.bounds.size.width - frame.size.width) / 2.0;
        frame.origin.y = (self.bounds.size.height - frame.size.height) / 2.0;
        imgV.frame = frame;
    }
    else// if (m_imageView.image.size.width > self.bounds.size.width && m_imageView.image.size.height > self.bounds.size.height)
    {
        CGFloat fScaleWByH = image.size.width / image.size.height;
        if (frame.size.width < fScaleWByH * frame.size.height)
        {
            frame.size.height = frame.size.width / fScaleWByH;
        }
        else
        {
            frame.size.width = frame.size.height * fScaleWByH;
        }
        frame.origin.x = (self.bounds.size.width - frame.size.width ) / 2.0;
        frame.origin.y = (self.bounds.size.height - frame.size.height ) / 2.0;
        imgV.frame = frame;
    }
    return imgV;
}

- (UIImageView *)addBackgroundImage:(UIImage *)image
{
    UIImageView *imgV = [[UIImageView alloc] initWithImage:image];
    [self insertSubview:imgV atIndex:0];
    
    CGRect frame = self.bounds;
    CGFloat fScaleWByH = image.size.width / image.size.height;
    if (frame.size.width > fScaleWByH * frame.size.height)
    {
        frame.size.height = frame.size.width / fScaleWByH;
    }
    else
    {
        frame.size.width = frame.size.height * fScaleWByH;
    }
    frame.origin.x = (self.bounds.size.width - frame.size.width ) / 2.0;
    frame.origin.y = (self.bounds.size.height - frame.size.height ) / 2.0;
    imgV.frame = frame;
    
    return imgV;
}
@end