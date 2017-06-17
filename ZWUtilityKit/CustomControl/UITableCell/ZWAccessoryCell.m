//
//  ZWAccessoryCell.m
//  Pods
//
//  Created by EadkennyChan on 17/6/9.
//
//

#import "ZWAccessoryCell.h"

@interface ZWAccessoryCell ()
{
    UIImageView *m_imageViewAccessory;
}
@end

@implementation ZWAccessoryCell

@synthesize accessoryView = m_imageViewAccessory;

- (void)showAccessory:(BOOL)bShow image:(nullable UIImage *)image
{
    UIImageView *imgV = m_imageViewAccessory;
    if (bShow && image)
    {
        if (imgV.superview == nil)
        {
            imgV = [[UIImageView alloc] initWithImage:image];
            [self addSubview:m_imageViewAccessory = imgV];
        }
        else
        {
            imgV.image = image;
        }
    }
    else
    {
        [imgV removeFromSuperview];
        m_imageViewAccessory = nil;
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (m_imageViewAccessory)
    {
        CGRect frame;
        frame.size = m_imageViewAccessory.image.size;
        frame.origin.x = self.bounds.size.width - self.contentInset.right - frame.size.width;
        frame.origin.y = (self.bounds.size.height - frame.size.height) / 2;
        m_imageViewAccessory.frame = frame;
        
        frame = self.contentView.frame;
        frame.size.width = m_imageViewAccessory.frame.origin.x - frame.origin.x;
        self.contentView.frame = frame;
    }
}

@end
