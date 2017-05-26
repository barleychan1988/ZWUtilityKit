//
//  ZWButtonCell.h
//  ZWUtilityKit
//
//  Created by EadkennyChan on 17/2/14.
//  Copyright © 2017年 zwchen. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const ZWButtonCellID;

@interface ZWButtonCell : UITableViewCell

@property (nonatomic, retain, readonly)UIButton *btn;
- (void)setButtonInset:(UIEdgeInsets)separatorInset;

@end
