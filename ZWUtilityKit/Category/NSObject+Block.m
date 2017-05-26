//
//  NSObject+Block.m
//  DIY
//
//  Created by chenzw on 15/11/4.
//  Copyright © 2015年 BiggerSister. All rights reserved.
//

#import "NSObject+Block.h"

@implementation NSObject (Block)

- (void)executeBlock:(void (^)(void))block
{
    if (block)
    {
        block();
    }
}

@end