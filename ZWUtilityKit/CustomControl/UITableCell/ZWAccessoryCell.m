//
//  ZWAccessoryCell.m
//  Pods
//
//  Created by EadkennyChan on 17/6/9.
//
//

#import "ZWAccessoryCell.h"
#import "Masonry.h"

@interface ZWAccessoryCell ()
{
    UIImageView *m_imageViewAccessory;
}
@end

@implementation ZWAccessoryCell

@synthesize accessoryView = m_imageViewAccessory;

- (void)initValues
{
    [super initValues];
    _fWidthRight = 15.0;
}

- (void)showAccessory:(BOOL)bShow image:(nullable UIImage *)image
{
    [m_imageViewAccessory removeFromSuperview];
    if (image == nil)
        return;
    UIImageView *imgV = [[UIImageView alloc] initWithImage:image];
    [self addSubview:m_imageViewAccessory = imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-_fWidthRight);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(image.size);
    }];
}

- (void)showCustomAccessory:(UIImageView *)view withSize:(CGSize)size
{
    [m_imageViewAccessory removeFromSuperview];
    if (view == nil || CGSizeEqualToSize(size, CGSizeZero))
    {
        return;
    }
    CGRect frame = CGRectZero;
    frame.size = size;
    view.frame = frame;
    [self addSubview:m_imageViewAccessory = view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-_fWidthRight);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(size);
    }];
}

- (void)hiddenAccessory
{
    [m_imageViewAccessory removeFromSuperview];
    m_imageViewAccessory = nil;
}

- (void)setFWidthRight:(CGFloat)fWidthRight
{
    _fWidthRight = fWidthRight;
    [m_imageViewAccessory mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-fWidthRight);
    }];
}
@end
