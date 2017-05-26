//
//  NSObject+Block.h
//  DIY
//
//  Created by chenzw on 15/11/4.
//  Copyright © 2015年 BiggerSister. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Block)

- (void)executeBlock:(void (^)(void))block;

@end
