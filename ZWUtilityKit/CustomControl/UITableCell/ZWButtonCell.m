//
//  ZWButtonCell.m
//  ZWUtilityKit
//
//  Created by EadkennyChan on 17/2/14.
//  Copyright © 2017年 zwchen. All rights reserved.
//

#import "ZWButtonCell.h"
#import "Masonry.h"

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
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    UIButton *btn = [[UIButton alloc] init];
    [self.contentView addSubview:_btn = btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
    }];
}

- (void)setButtonInset:(UIEdgeInsets)inset
{
    [_btn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(inset.left);
        make.right.equalTo(self.contentView).offset(-inset.right);
        make.top.equalTo(self.contentView).offset(inset.top);
        make.bottom.equalTo(self.contentView).offset(-inset.bottom);
    }];
}

- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [_btn removeTarget:nil action:nil forControlEvents:UIControlEventAllEvents];
    [_btn addTarget:target action:action forControlEvents:controlEvents];
}

@end
