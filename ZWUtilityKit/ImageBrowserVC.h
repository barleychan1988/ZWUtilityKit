//
//  ImageBrowserVC.h
//  DIY
//
//  Created by chenzw on 15/12/24.
//  Copyright © 2015年 BiggerSister. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageBrowserDelegate;

@interface ImageBrowserVC : UIViewController

@property (nonatomic, assign)id<ImageBrowserDelegate> delegate;

@property (nonatomic, retain)NSArray<UIImage *> *arrayImages;
@property (nonatomic, retain)UIImage *imageCurSelected;

@property (nonatomic, assign)UIStatusBarStyle statusBarStyle;

- (void)btnClickRemoveCurrentImage;

@end

@protocol ImageBrowserDelegate <NSObject>

- (void)imageBrowser:(ImageBrowserVC *)imageBrowser didChangedImages:(NSArray<UIImage *> *)images;

@end