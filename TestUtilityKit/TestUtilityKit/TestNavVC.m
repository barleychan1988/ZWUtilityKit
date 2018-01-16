//
//  TestNavVC.m
//  TestUtilityKit
//
//  Created by Eadkenny on 2018/1/16.
//  Copyright © 2018年 JGW. All rights reserved.
//

#import "TestNavVC.h"

UIImage *pureColorImage(UIColor *color)
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@interface TestNavVC ()
{
    NSInteger m_bIsNavTranslucent;
}
@end

@implementation TestNavVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"测试导航栏背景";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    m_bIsNavTranslucent = 0;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 150, 100, 30);
    btn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self btnClicked];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnClicked
{
    m_bIsNavTranslucent++;
    if (m_bIsNavTranslucent == 1)
    {
        self.title = @"深蓝导航栏";
        UIImage *image = pureColorImage([UIColor colorWithRed:49.0/255.0 green:55.0/255 blue:84.0/255 alpha:1]);
        self.edgesForExtendedLayout = UIRectEdgeNone;
        UIImage *backgroundImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 20, 0)];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.translucent = NO;
    }
    else if (m_bIsNavTranslucent == 2)
    {
        self.title = @"透明导航栏";
        self.edgesForExtendedLayout |= UIRectEdgeTop;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        self.navigationController.navigationBar.translucent = YES;
        
        //        self.edgesForExtendedLayout |= UIRectEdgeTop;
        //        self.navigationController.navigationBar.translucent = YES;
        //        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        //        self.navigationController.navigationBar.shadowImage = [UIImage new];
    }
    else if (m_bIsNavTranslucent == 3)
    {
        self.title = @"深蓝导航栏";
        UIImage *image = pureColorImage([UIColor redColor]);
        self.edgesForExtendedLayout = UIRectEdgeNone;
        UIImage *backgroundImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 20, 0)];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.translucent = NO;
    }
    else
    {
        self.title = @"淡红导航栏";
        UIImage *image = pureColorImage([UIColor colorWithRed:84/255.0 green:49.0/255 blue:61.0/255 alpha:1]);
        self.edgesForExtendedLayout = UIRectEdgeNone;
        [self.navigationController.navigationBar setBackgroundImage:image forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.translucent = NO;
        m_bIsNavTranslucent = 0;
    }
}

@end
