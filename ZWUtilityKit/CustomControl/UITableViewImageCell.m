//
//  DiscoveryInfoImageCell.m
//  DIY
//
//  Created by chenzw on 15/12/30.
//  Copyright © 2015年 BiggerSister. All rights reserved.
//

#import "UITableViewImageCell.h"

@interface UITableViewImageCell ()
{
    UIImageView *m_imageView;
}
@end


@implementation UITableViewImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initSubviews];
        self.contentView.clipsToBounds = YES;
    }
    return self;
}

- (void)initSubviews
{
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:imgV];
    m_imageView = imgV;
}

- (void)setImage:(UIImage *)image
{
    if (![image isKindOfClass:[UIImage class]])
        return;
    _image = image;
    m_imageView.image = _image;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_image)
    {
        CGFloat fWByHRatio = _image.size.width / _image.size.height;
        CGRect frame = self.contentView.bounds;
        switch (_styleImageShow)
        {
            case ImageShowStyle_ScaleFitByBig:
                if (frame.size.width < frame.size.height * fWByHRatio)
                {
                    frame.size.width = frame.size.height * fWByHRatio;
                }
                else
                {
                    frame.size.height = frame.size.width / fWByHRatio;
                }
                break;
            case ImageShowStyle_ScaleFit:
            {
                if (frame.size.width > _image.size.width && frame.size.height > _image.size.height)
                {
                    frame.size = _image.size;
                    break;
                }
            }
            case ImageShowStyle_ScaleFitBySmall:
                if (frame.size.width > frame.size.height * fWByHRatio)
                {
                    frame.size.width = frame.size.height * fWByHRatio;
                }
                else
                {
                    frame.size.height = frame.size.width / fWByHRatio;
                }
                break;                
            default:
                break;
        }
        frame.origin.y = (self.contentView.bounds.size.height - frame.size.height) / 2;
        frame.origin.x = (self.contentView.bounds.size.width - frame.size.width) / 2;
        m_imageView.frame = frame;
    }
}

@end