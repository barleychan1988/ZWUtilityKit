//
//  ZWUIImageView.m
//  ZWUtilityKit
//
//  Created by chenzw on 15/9/18.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import "ZWUIImageView.h"

@interface ZWUIImageView ()
{
    UIImageView *m_imageViewStatus;
}
@end


@implementation ZWUIImageView

- (void)setImageFailed:(UIImage *)imageFailed
{
    _imageFailed = imageFailed;
    if (m_imageViewStatus == nil)
    {
        m_imageViewStatus = [[UIImageView alloc] initWithImage:_imageFailed];
        [self addSubview:m_imageViewStatus];
    }
    else if (m_imageViewStatus.superview == nil)
    {
        [self addSubview:m_imageViewStatus];
    }
//    CGRect frame = self.bounds;
    self.image = nil;
}

- (void)setImageLoading:(UIImage *)imageLoading
{
    _imageLoading = imageLoading;
    self.image = nil;
}

@end