//
//  ZWTableViewCell.m
//  SuperCode
//
//  Created by chenpeng on 16/5/3.
//  Copyright © 2016年 chenzw. All rights reserved.
//

#import "ZWTableViewCell.h"
#import "UtilityUIKit.h"

#pragma mark - 

@interface ZWRequiredTipCell ()
{
    __weak UILabel *m_labelRequiredTip;
    __weak UIImageView *m_imageViewAccessory;
}
@end

@implementation ZWRequiredTipCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    [self initValues];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
        [self initValues];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
        [self initValues];
    return self;
}

- (void)initValues
{
    _fRequiredTipWidth = 45;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frameContent = self.bounds;
    CGRect frame = self.bounds;
    if (m_labelRequiredTip.superview)
    {
        frame.size.width = _fRequiredTipWidth;
        m_labelRequiredTip.frame = frame;
        frameContent.origin.x = _fRequiredTipWidth;
    }
    if (m_imageViewAccessory.superview)
    {
        frame.size = m_imageViewAccessory.image.size;
        if (_fAccessoryWidth > frame.size.width)
            frame.origin.x = self.bounds.size.width - _fAccessoryWidth;
        else
            frame.origin.x = self.bounds.size.width - frame.size.width;
        frame.origin.y = (self.bounds.size.height - frame.size.height) / 2;
        m_imageViewAccessory.frame = frame;
        frameContent.size.width -= (frameContent.origin.x + self.bounds.size.width - frame.origin.x);
    }
    self.contentView.frame = frameContent;
}

- (void)showRequiredTip:(BOOL)bShow
{
    if (bShow)
    {
        if (m_labelRequiredTip.superview == nil)
        {
            UILabel *l = [[UILabel alloc] init];
            l.textColor = [UIColor redColor];
            l.text = @"*";
            l.textAlignment = NSTextAlignmentCenter;
            [self addSubview:l];
            m_labelRequiredTip = l;
        }
    }
    else
    {
        [m_labelRequiredTip removeFromSuperview];
        m_labelRequiredTip = nil;
    }
}

- (void)showAccessoryImage:(BOOL)bShow image:(UIImage *)image
{
    if (bShow)
    {
        if (m_imageViewAccessory.superview == nil)
        {
            UIImageView *imgV = [[UIImageView alloc] init];
            m_imageViewAccessory = imgV;
            [self addSubview:imgV];
        }
        m_imageViewAccessory.image = image;
        [self setNeedsLayout];
    }
    else
    {
        [m_imageViewAccessory removeFromSuperview];
        m_imageViewAccessory = nil;
    }
}

- (void)setFRequiredTipWidth:(CGFloat)fRequiredTipWidth
{
    _fRequiredTipWidth = fRequiredTipWidth;
    [self setNeedsLayout];
}

- (void)setFAccessoryWidth:(CGFloat)fAccessoryWidth
{
    _fAccessoryWidth = fAccessoryWidth;
    [self setNeedsLayout];
}

@end

#pragma mark -

@interface ZWLabelTipCell ()
{
    UILabel *m_labelRequiredTip;
}

@property(nonatomic, retain)UIImageView *imageViewAccessory;

@end

NSString *const ZWLabelTipCellID = @"ZWLabelTipCellID";

@implementation ZWLabelTipCell

- (void)initSubviews
{
    UILabel *l = [[UILabel alloc] init];
    [self.contentView addSubview:l];
    _labelTip = l;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.contentView.bounds;
    if (_fWidthTip < 10)
    {
        CGFloat fWidth = getSizeForLabel(_labelTip.text, _labelTip.font, NSLineBreakByWordWrapping, CGSizeZero).width;
        frame.size.width = fWidth + 5;
    }
    else
        frame.size.width = _fWidthTip;
    switch(_alignmentTipVertical)
    {
        case VerticalAlignment_Top:
            frame.size.height = getSizeForLabel(_labelTip.text, _labelTip.font, NSLineBreakByWordWrapping, CGSizeZero).height + 30;
            break;
        case VerticalAlignment_Bottom:
            frame.size.height = getSizeForLabel(_labelTip.text, _labelTip.font, NSLineBreakByWordWrapping, CGSizeZero).height + 30;
            frame.origin.y = self.contentView.bounds.size.height - frame.size.height;
            break;
        default:
            break;
    }
    _labelTip.frame = frame;
    
    frame = m_labelRequiredTip.frame;
    frame.origin.y = _labelTip.frame.origin.y;
    frame.size.height = _labelTip.frame.size.height;
    m_labelRequiredTip.frame = frame;
}

- (void)showAccessory:(BOOL)bShow image:(NSString *)strImage
{
    [_imageViewAccessory removeFromSuperview];
    if (bShow)
    {
        if (_imageViewAccessory.superview == nil)
        {
            UIImageView *imgV = [[UIImageView alloc] init];
            imgV.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
            _imageViewAccessory = imgV;
            [self.contentView addSubview:imgV];
        }
        _imageViewAccessory.image = [UIImage imageNamed:strImage];
        CGRect frame;
        frame.size = _imageViewAccessory.image.size;
        frame.origin.x = self.contentView.bounds.size.width - frame.size.width;
        frame.origin.y = (self.contentView.bounds.size.height - frame.size.height) / 2;
        _imageViewAccessory.frame = frame;
    }
}

- (void)showAccessory:(BOOL)bShow customView:(UIView *)view
{
    [_imageViewAccessory removeFromSuperview];
    if (bShow)
    {
        if (_imageViewAccessory.superview == nil)
        {
            view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
            _imageViewAccessory = (UIImageView *)view;
            [self.contentView addSubview:view];
        }
        CGRect frame = view.frame;
        frame.origin.x = self.contentView.bounds.size.width - frame.size.width;
        frame.origin.y = (self.contentView.bounds.size.height - frame.size.height) / 2;
        _imageViewAccessory.frame = frame;
    }
}

- (void)showRequiredTip:(BOOL)bShow
{
    if (bShow)
    {
        if (m_labelRequiredTip.superview == nil)
        {
            UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 15, self.bounds.size.height)];
            l.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            l.textColor = [UIColor redColor];
            l.text = @"*";
            l.textAlignment = NSTextAlignmentCenter;
            [self addSubview:l];
            m_labelRequiredTip = l;
        }
    }
    else
    {
        [m_labelRequiredTip removeFromSuperview];
        m_labelRequiredTip = nil;
    }
}

@end

NSString *const ZWLabelLabelCellID = @"ZWLabelLabelCellID";

@interface ZWLabelLabelCell ()
@end

@implementation ZWLabelLabelCell

- (void)initSubviews
{
    [super initSubviews];
    
    UILabel *l = [[UILabel alloc] init];
    l.lineBreakMode = NSLineBreakByWordWrapping;
    l.numberOfLines = 0;
    [self.contentView addSubview:l];
    _labelContent = l;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.labelTip.frame;
    frame.origin.x += frame.size.width;
    frame.size.width = self.contentView.bounds.size.width - frame.origin.x;
    if (self.imageViewAccessory.superview)
        frame.size.width -= (self.imageViewAccessory.frame.size.width + 15);
    frame.size.height = self.contentView.bounds.size.height;
    frame.origin.y = 0;
    _labelContent.frame = frame;
}

@end

#pragma mark -

NSString *const ZWLabelTFCellID = @"ZWLabelTFCellID";

@interface ZWLabelTFCell ()<UITextFieldDelegate>
{
}
@end

@implementation ZWLabelTFCell

- (void)initSubviews
{
    [super initSubviews];
    
    UITextField *tf = [[UITextField alloc] init];
    tf.delegate = self;
    [self.contentView addSubview:tf];
    _tfContent = tf;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.labelTip.frame;
    frame.origin.x += frame.size.width;
    frame.size.width = self.contentView.bounds.size.width - frame.origin.x;
    if (self.imageViewAccessory.superview)
        frame.size.width -= (self.imageViewAccessory.frame.size.width + 15);
    _tfContent.frame = frame;
}

#pragma mark UITextFieldDelegate

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
//- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
{
    if ([_delegate respondsToSelector:@selector(labelTfDidEndEditing:)])
    {
        [_delegate labelTfDidEndEditing:self];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason NS_AVAILABLE_IOS(10_0) // if implemented, called in place of textFieldDidEndEditing:
{
    if ([_delegate respondsToSelector:@selector(labelTfDidEndEditing:)])
    {
        [_delegate labelTfDidEndEditing:self];
    }
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
//
//- (BOOL)textFieldShouldClear:(UITextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)
//- (BOOL)textFieldShouldReturn:(UITextField *)textField;              // called when 'return' key pressed. return NO to ignore.

@end
