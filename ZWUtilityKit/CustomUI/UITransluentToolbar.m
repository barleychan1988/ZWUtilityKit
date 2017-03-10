//
//  UITransluentToolbar.m
//  ZWUtilityKit
//
//  Created by chenzw on 15/4/20.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import "UITransluentToolbar.h"

@implementation UITransluentToolbar

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}

- (id)initWithFrame:(CGRect)aRect
{
    if ((self = [super initWithFrame:aRect]))
    {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        self.clearsContextBeforeDrawing = YES;
    }
    return self;
}

- (void)setLastItem:(UIView *)view
{
    NSMutableArray *mtArrayItems = [NSMutableArray arrayWithArray:self.items];
    if ([self.items count] > 0)
    {
        UIBarButtonItem *itemLastOld = self.items.lastObject;
        if (itemLastOld.customView != nil)
        {
            UIBarButtonItem *itemFlexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            [mtArrayItems addObject:itemFlexible];
        }
    }
    else
    {
        UIBarButtonItem *itemFlexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [mtArrayItems addObject:itemFlexible];
    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    [mtArrayItems addObject:item];
    
    self.items = mtArrayItems;
}

@end