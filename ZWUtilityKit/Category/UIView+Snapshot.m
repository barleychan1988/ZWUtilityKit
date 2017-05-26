//
//  UIView+Snapshot.m
//  DIY
//
//  Created by chenzw on 16/2/15.
//  Copyright © 2016年 BiggerSister. All rights reserved.
//

#import "UIView+Snapshot.h"

@implementation UIView (Snapshot)


- (UIImage *)captureScreenshot:(CGFloat)fScale
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, fScale);
    
    // IOS7及其后续版本
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]];
        [invocation setTarget:self];
        [invocation setSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)];
        CGRect arg2 = self.bounds;
        BOOL arg3 = YES;
        [invocation setArgument:&arg2 atIndex:2];
        [invocation setArgument:&arg3 atIndex:3];
        [invocation invoke];
    }
    else
    { // IOS7之前的版本
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

@end
