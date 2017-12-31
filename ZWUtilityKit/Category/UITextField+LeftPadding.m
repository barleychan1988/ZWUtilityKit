//
//  UITextField+LeftPadding.m
//  Pods
//
//  Created by EadkennyChan on 17/7/4.
//
//

#import "UITextField+LeftPadding.h"
#import "Masonry.h"

@implementation UITextField (LeftPadding)

- (void)setLeftPadding:(CGFloat)leftWidth
{
    CGRect frame = self.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
}

- (void)setLeftIcon:(UIImage *)image padding:(CGFloat)leftWidth
{
    [self setLeftIcon:image paddingLeft:leftWidth paddingRight:leftWidth];
}

- (void)setLeftIcon:(nonnull UIImage *)image paddingLeft:(CGFloat)leftWidth paddingRight:(CGFloat)rightWidth
{
    CGRect frame = CGRectZero;
    frame.size.height = self.bounds.size.height;
    frame.size.width = image.size.width + leftWidth + rightWidth;
    UIView *viewLeft = [[UIView alloc] initWithFrame:frame];
    viewLeft.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.leftView = viewLeft;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *imageViewIcon = [[UIImageView alloc] initWithImage:image];
    [viewLeft addSubview:imageViewIcon];
    [imageViewIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(viewLeft);
        make.size.mas_equalTo(image.size);
    }];
}

- (void)setPlaceholder:(NSString *)strPlaceholder withColor:(UIColor *)color
{
    NSDictionary *dicPlaceHolderAttr = @{NSForegroundColorAttributeName:color};
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:strPlaceholder attributes:dicPlaceHolderAttr];
    self.attributedPlaceholder = attrStr;
}

@end
