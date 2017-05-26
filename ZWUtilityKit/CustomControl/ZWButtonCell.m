//
//  ZWButtonCell.m
//  ZWUtilityKit
//
//  Created by EadkennyChan on 17/2/14.
//  Copyright © 2017年 zwchen. All rights reserved.
//

#import "ZWButtonCell.h"

NSString *const ZWButtonCellID = @"ZWButtonCellID";

@implementation ZWButtonCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    [self initSubviews];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
        [self initSubviews];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
        [self initSubviews];
    return self;
}

- (void)initSubviews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIButton *btn = [[UIButton alloc] init];
    [self.contentView addSubview:btn];
    _btn = btn;
    
    btn.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setButtonInset:(UIEdgeInsets)inset
{
    [self.contentView removeConstraints:self.contentView.constraints];
    NSLayoutConstraint *layoutConst = [NSLayoutConstraint constraintWithItem:_btn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:inset.left];
    [self.contentView addConstraint:layoutConst];
    layoutConst = [NSLayoutConstraint constraintWithItem:_btn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-inset.right];
    [self.contentView addConstraint:layoutConst];
    layoutConst = [NSLayoutConstraint constraintWithItem:_btn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:inset.top];
    [self.contentView addConstraint:layoutConst];
    layoutConst = [NSLayoutConstraint constraintWithItem:_btn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-inset.bottom];
    [self.contentView addConstraint:layoutConst];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
