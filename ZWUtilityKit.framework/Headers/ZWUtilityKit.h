//
//  ZWUtilityKit.h
//  ZWUtilityKit
//
//  Created by 陈正旺 on 14/12/4.
//  Copyright (c) 2014年 zwchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWMacroDef.h"
#import "ZWVertifyStringKit.h"
#import "UtilityKit.h"
#import "ZWLog.h"
#import "UtilityUIKit.h"
#import "UINavigationController+Orientation.h"
#import "UINavigationController+BarButtonItem.h"

#import "NSString+DocumentPath.h"
#import "UIButton+Action.h"
#import "UIView+AddLine.h"
#import "Dictionary+SafeValue.h"
#import "NSObject+Block.h"
#import "NSObject+ParseDicToObj.h"

#import "ZWLocationAuthor.h"

//#import "ZWStartEvaluateView.h"
//#import "ZWStartEvaluateIntView.h"
//#import "UITransluentToolbar.h"
//
//#import "UIView+Keyboard.h"
//#import "UIViewController+Keybord.h"
//#import "UIView+SubImageView.h"
//#import "Geometry+ZWExtension.h"
//#import "UIImage+ZWHandle.h"
//
//#import "SGdownloader.h"

//! Project version number for ZWUtilityKit.
FOUNDATION_EXPORT double ZWUtilityKitVersionNumber;

//! Project version string for ZWUtilityKit.
FOUNDATION_EXPORT const unsigned char ZWUtilityKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ZWUtilityKit/PublicHeader.h>

typedef void (^BlockBoolStrObject)(BOOL, NSString *, id);
typedef void (^BlockVoid)();
typedef void (^BlockBoolObject)(BOOL bFlage, id object);
typedef void (^BlockObject)(id object);
