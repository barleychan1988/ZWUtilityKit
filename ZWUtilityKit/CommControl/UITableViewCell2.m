//
//  UITableViewCell2.m
//  ZWUtilityKit
//
//  Created by 陈正旺 on 15/3/2.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import "UITableViewCell2.h"

@implementation UITableViewCell2

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView *subview in self.contentView.superview.subviews)
    {
        if ([NSStringFromClass(subview.class) hasSuffix:@"SeparatorView"])
        {
            subview.hidden = _bSeparatorLineHidden;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
