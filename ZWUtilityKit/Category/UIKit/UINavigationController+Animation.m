//
//  UINavigationController+Animation.m
//  ZWUtilityKit
//
//  Created by chenzw on 15/7/28.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import "UINavigationController+Animation.h"

@implementation UINavigationController (Animation)

- (void)customPresentViewController:(UIViewController *)viewController
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType: kCATransitionMoveIn];
    [animation setSubtype: kCATransitionFromTop];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
//    animation.delegate = self;
    [self pushViewController:viewController animated:NO];
    [self.view.layer addAnimation:animation forKey:@"customPresent"];
}

- (void)customDismiss
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
//    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:@"customDismiss"];
    [self popViewControllerAnimated:NO];
}

- (void)customPopToViewController:(UIViewController *)vc
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    //    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:@"customDismiss"];
    [self popToViewController:vc animated:NO];
}

@end