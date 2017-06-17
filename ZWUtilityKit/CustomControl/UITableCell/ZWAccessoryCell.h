//
//  ZWAccessoryCell.h
//  Pods
//
//  Created by EadkennyChan on 17/6/9.
//
//

#import "ZWSeperatorLineCell.h"

@interface ZWAccessoryCell : ZWSeperatorLineCell

@property (nonatomic, retain, readonly)UIView *accessoryView;

- (void)showAccessory:(BOOL)bShow image:(nullable UIImage *)image;

@end
