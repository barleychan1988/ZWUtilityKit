//
//  NoneContentCell.h
//  ZWUtilityKit
//
//  Created by EadkennyChan on 16/10/17.
//  Copyright © 2016年 zwchen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString *const ZWNoneCellID;

@interface ZWNoneCell : UITableViewCell

- (void)showSeparatorLine:(BOOL)bShow indent:(CGFloat)fIndex color:(nullable UIColor *)color;

@end

NS_ASSUME_NONNULL_END
