//
//  ZWButtonCell.h
//  ZWUtilityKit
//
//  Created by EadkennyChan on 17/2/14.
//  Copyright © 2017年 zwchen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString * _Nullable const ZWButtonCellID;

@interface ZWButtonCell : UITableViewCell

@property (nonatomic, retain, readonly, nonnull)UIButton *btn;
- (void)setButtonInset:(UIEdgeInsets)separatorInset;
- (void)addTarget:(nullable id)target action:(SEL _Nullable )action forControlEvents:(UIControlEvents)controlEvents;

@end

NS_ASSUME_NONNULL_END
