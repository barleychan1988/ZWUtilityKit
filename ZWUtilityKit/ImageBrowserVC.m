//
//  ImageBrowserVC.m
//  DIY
//
//  Created by chenzw on 15/12/24.
//  Copyright © 2015年 BiggerSister. All rights reserved.
//

#import "ImageBrowserVC.h"
#import "ZWMacroDef.h"

@interface ImageBrowserVC ()<UIScrollViewDelegate, UIActionSheetDelegate>
{
    UIScrollView *m_scrollView;
    NSArray<UIScrollView *> *m_arrayImageViews;
}
@end

@implementation ImageBrowserVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (@available(iOS 7.0, *))
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    frame.origin.y = self.view.bounds.size.height - frame.size.height;
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:frame];
    scrollV.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    scrollV.pagingEnabled = YES;
    scrollV.backgroundColor = [UIColor blackColor];
    scrollV.showsHorizontalScrollIndicator = NO;
    scrollV.showsVerticalScrollIndicator = NO;
    scrollV.delegate = self;
    [self.view addSubview:scrollV];
    m_scrollView = scrollV;
    
    for (UIView *subview in m_arrayImageViews)
    {
        [m_scrollView addSubview:subview];
    }
}

- (void)setArrayImages:(NSArray<UIImage *> *)arrayImages
{
    _arrayImages = arrayImages;
    
    NSMutableArray *mtArray = [NSMutableArray arrayWithCapacity:[_arrayImages count]];
    [m_arrayImageViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (UIImage *image in _arrayImages)
    {
        UIScrollView *scrollV = [[UIScrollView alloc] init];
        UIPinchGestureRecognizer *pinGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinScaleImage:)];
        [scrollV addGestureRecognizer:pinGesture];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
        [scrollV addGestureRecognizer:tapGesture];
        [m_scrollView addSubview:scrollV];
        [mtArray addObject:scrollV];
        
        UIImageView *imgV = [[UIImageView alloc] initWithImage:image];
        [scrollV addSubview:imgV];
    }
    m_arrayImageViews = mtArray;
    if (self.isViewLoaded && [_arrayImages count] > 0)
    {
        m_scrollView.contentSize = CGSizeMake(m_scrollView.frame.size.width * [_arrayImages count], 0);
        [self viewDidLayoutSubviews];
    }
}

- (void)setImageCurSelected:(UIImage *)image
{
    _imageCurSelected = image;
    if (self.isViewLoaded && [_arrayImages count] > 0)
    {
        [self viewDidLayoutSubviews];
        NSInteger nIndex = [_arrayImages indexOfObject:_imageCurSelected];
        m_scrollView.contentOffset = CGPointMake(nIndex * m_scrollView.frame.size.width, 0);
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (m_scrollView.contentSize.width == 0)
    {
        m_scrollView.contentSize = CGSizeMake(m_scrollView.frame.size.width * [_arrayImages count], 0);
        NSInteger nIndex = [_arrayImages indexOfObject:_imageCurSelected];
        m_scrollView.contentOffset = CGPointMake(nIndex * m_scrollView.frame.size.width, 0);
    }
    CGRect frame = m_scrollView.frame;
    frame.origin = CGPointZero;
    CGFloat fWByHRatio;
    UIImageView *imageV;
    CGRect frameImageV;
    for (UIScrollView *subview in m_arrayImageViews)
    {
        subview.frame = frame;
        
        imageV = (UIImageView *)[subview.subviews firstObject];
        frameImageV.size = subview.contentSize;
        if (frameImageV.size.width < subview.bounds.size.width)
            frameImageV.size.width = subview.bounds.size.width;
        if (frameImageV.size.height < subview.bounds.size.height)
            frameImageV.size.height = subview.bounds.size.height;
        subview.contentSize = frameImageV.size;
        
        fWByHRatio = imageV.image.size.width / imageV.image.size.height;
        if (frameImageV.size.width > frameImageV.size.height * fWByHRatio)
            frameImageV.size.width = frameImageV.size.height * fWByHRatio;
        else
            frameImageV.size.height = frameImageV.size.width / fWByHRatio;
        frameImageV.origin.x = (subview.contentSize.width - frameImageV.size.width) / 2;
        frameImageV.origin.y = (subview.contentSize.height - frameImageV.size.height) / 2;
        imageV.frame = frameImageV;
        
        frame.origin.x += frame.size.width;
    }
    NSInteger nIndex = 1;
    if (_imageCurSelected)
        nIndex = [_arrayImages indexOfObject:_imageCurSelected] + 1;
    self.title = [NSString stringWithFormat:@"%ld/%ld", (long)nIndex, (long)[_arrayImages count]];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return _statusBarStyle;
}


- (void)btnClickRemoveCurrentImage
{
    NSString *strTitle = @"要删除这张照片吗？";
    if (@available(iOS 8.0, *))
    {
        UIAlertController *sheet = [UIAlertController alertControllerWithTitle:strTitle message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self removeCurrentSelectedImage];
        }];
        [sheet addAction:cancelAction];
        [sheet addAction:deleteAction];
        [self presentViewController:sheet animated:YES completion:nil];
    }
    else
    {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:strTitle delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册" otherButtonTitles:@"相机", nil];
        [sheet showInView:self.view];
    }
}

- (void)removeCurrentSelectedImage
{
    NSInteger nIndex = [_arrayImages indexOfObject:_imageCurSelected];
    NSMutableArray *mtArray = [NSMutableArray arrayWithArray:_arrayImages];
    [mtArray removeObject:_imageCurSelected];
    self.arrayImages = mtArray;
    if (nIndex > 0)
    {
        nIndex = nIndex - 1;
    }
    self.imageCurSelected = [_arrayImages objectAtIndex:nIndex];
    if ([_delegate respondsToSelector:@selector(imageBrowser:didChangedImages:)])
    {
        [_delegate imageBrowser:self didChangedImages:mtArray];
    }
}

#pragma mark - Gesture

- (void)tapImage:(UITapGestureRecognizer *)tapGesture
{
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:!app.statusBarHidden withAnimation:UIStatusBarAnimationFade];
}

- (void)pinScaleImage:(UIPinchGestureRecognizer *)pinchGesture
{
    UIScrollView *scrollV = (UIScrollView *)pinchGesture.view;
    UIImageView *imgV = [[scrollV subviews] firstObject];
    CGRect frame = imgV.frame;
    frame.size.width = frame.size.width * pinchGesture.scale;
    frame.size.height = frame.size.height * pinchGesture.scale;
//    if (frame.size.width > scrollV.frame.size.width && frame.size.height > scrollV.frame.size.height)
//    {
//        CGFloat fWByHRatioImage = imgV.image.size.width / imgV.image.size.height;
//        frame.size = scrollV.frame.size;
//        if (frame.size.width < frame.size.height * fWByHRatioImage)
//            frame.size.width = frame.size.height * fWByHRatioImage;
//        else
//            frame.size.height = frame.size.width / fWByHRatioImage;
//    }
//    else if (frame.size.width < scrollV.frame.size.width && frame.size.height < scrollV.frame.size.height)
//    {
//        CGFloat fWByHRatioImage = imgV.image.size.width / imgV.image.size.height;
//        frame.size = scrollV.frame.size;
//        if (frame.size.width > frame.size.height * fWByHRatioImage)
//            frame.size.width = frame.size.height * fWByHRatioImage;
//        else
//            frame.size.height = frame.size.width / fWByHRatioImage;
//    }
    CGSize contentSize = frame.size;
    if (frame.size.width < scrollV.frame.size.width)
        contentSize.width = scrollV.frame.size.width;
    if (frame.size.height < scrollV.frame.size.height)
        contentSize.height = scrollV.frame.size.height;
    scrollV.contentSize = contentSize;
    frame.origin.x = (scrollV.contentSize.width - frame.size.width) / 2;
    frame.origin.y = (scrollV.contentSize.height - frame.size.height) / 2;
    imgV.frame = frame;
    
    pinchGesture.scale = 1;
}

#pragma mark - UIScrollViewDelegate

_Pragma("clang diagnostic push")
_Pragma("clang diagnostic ignored \"-Wformat\"")
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == m_scrollView)
    {
        NSInteger nIndex = floor(scrollView.contentOffset.x / scrollView.frame.size.width);
        if (fabs(scrollView.contentOffset.x - scrollView.frame.size.width * nIndex) > (scrollView.frame.size.width / 2))
        {
            nIndex++;
        }
        if (nIndex < 0)
            nIndex = 0;
        else if (nIndex >= [_arrayImages count])
            nIndex = [_arrayImages count] - 1;
        self.title = [NSString stringWithFormat:@"%ld/%ld", nIndex + 1, (unsigned long)[_arrayImages count]];
        _imageCurSelected = [_arrayImages objectAtIndex:nIndex];
    }
}
_Pragma("clang diagnostic pop")

@end
