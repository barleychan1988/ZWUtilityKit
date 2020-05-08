//
//  ZWTextField.h
//  ZWUtilityKit
//
//  Created by  eadkenny on 2020/3/31.
//  Copyright © 2020 zwchen. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 主要解决iOS13以后，leftView、rightView上包含子控件时，leftView、rightView的宽度和UITextField一样宽的问题
 */
NS_ASSUME_NONNULL_BEGIN

@interface ZWTextField : UITextField

@property (nonatomic, retain)UIColor *normalTextColor;
@property (nonatomic, retain)UIColor *disableTextColor;

@end

NS_ASSUME_NONNULL_END
