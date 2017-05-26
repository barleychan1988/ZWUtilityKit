//
//  CustomAlertView.m
//  TestNav
//
//  Created by 陈正旺 on 15/3/13.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import "CustomAlertView.h"

#define fWidth 270.0

@interface CustomAlertView()
{
    id<UIAlertViewDelegate>  m_delegate;
    UIView *m_viewBackground;
    UIView *m_viewBtnPlane;//按钮
    
    UIView *m_viewTitlePlane;//标题栏
    UILabel *m_labelTitle;
    UIImageView *m_imageViewTitle;//标题栏背景
    
    UIView *m_viewContentPlane;//内容栏
    UILabel *m_labelMessage;
    
    NSArray *m_arrayBtnTitle;
}
@end

@implementation CustomAlertView

#pragma mark - property

- (void)setStrTitle:(NSString *)strTitle
{
    if (m_labelTitle == nil)
    {
        m_labelTitle = [[UILabel alloc] initWithFrame:m_viewTitlePlane.bounds];
        m_labelTitle.backgroundColor = [UIColor clearColor];
        m_labelTitle.textAlignment = NSTextAlignmentCenter;
        m_labelTitle.font = [UIFont boldSystemFontOfSize:18];
        m_labelTitle.textColor = [UIColor blackColor];
        m_labelTitle.autoresizesSubviews = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [m_viewTitlePlane addSubview:m_labelTitle];
    }
    _strTitle = strTitle;
    m_labelTitle.text = _strTitle;
}

- (void)setStrMessage:(NSString *)strMessage
{
    if ([strMessage length] <= 0)
    {
        return;
    }
    _strMessage = strMessage;
    
    if (m_labelMessage == nil)
    {
        m_labelMessage = [[UILabel alloc] init];
        m_labelMessage.backgroundColor = [UIColor clearColor];
        m_labelMessage.textAlignment = NSTextAlignmentCenter;
        m_labelMessage.font = [UIFont systemFontOfSize:15];
        m_labelMessage.textColor = [UIColor blackColor];
        m_labelMessage.frame = CGRectMake(15, 10, fWidth - 30, 44);
        m_labelMessage.autoresizesSubviews = UIViewAutoresizingFlexibleWidth;
        m_labelMessage.numberOfLines = 0;
        m_labelMessage.lineBreakMode = NSLineBreakByWordWrapping;
        [m_viewContentPlane addSubview:m_labelMessage];
    }
    m_labelMessage.text = _strMessage;
    
    CGRect frame = m_labelMessage.frame;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        CGRect expectedFrame = [_strMessage boundingRectWithSize:CGSizeMake(m_labelMessage.frame.size.width, 1000)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              m_labelMessage.font, NSFontAttributeName,
                                                              nil]
                                                     context:nil];
        expectedFrame.size.width = ceil(expectedFrame.size.width);
        expectedFrame.size.height = ceil(expectedFrame.size.height);
        frame.size.height = expectedFrame.size.height;
    }
    else
    {
_Pragma("clang diagnostic push")
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        frame.size.height = [_strMessage sizeWithFont:m_labelMessage.font
                         constrainedToSize:CGSizeMake(m_labelMessage.frame.size.width, 1000)
                             lineBreakMode:NSLineBreakByWordWrapping].height;
#pragma clang diagnostic pop
    }
    m_labelMessage.frame = frame;
    if (_viewAddtion)
    {
        CGRect frame = _viewAddtion.frame;
        frame.origin.y = m_labelMessage.frame.origin.y + m_labelMessage.frame.size.height + 10;
        _viewAddtion.frame = frame;
    }
}

- (void)setAttributedMessage:(NSAttributedString *)attributedMessage
{
    if ([attributedMessage length] <= 0)
    {
        return;
    }
    _attributedMessage = attributedMessage;
    self.strMessage = [_attributedMessage string];
    m_labelMessage.attributedText = _attributedMessage;
}

- (void)setViewAddtion:(UIView *)viewAddtion
{
    if (viewAddtion == nil || ![viewAddtion isKindOfClass:[UIView class]])
    {
        return;
    }
    _viewAddtion = viewAddtion;
    CGRect frame = _viewAddtion.frame;
    frame.origin.y = m_labelMessage.frame.origin.y + m_labelMessage.frame.size.height + 10;
    if (frame.size.width == 0)
    {
        frame.size.width = m_viewContentPlane.frame.size.width;
    }
    else if (frame.size.width > m_viewContentPlane.frame.size.width)
    {
        frame.size.width = m_viewContentPlane.frame.size.width;
    }
    frame.origin.x = (m_viewContentPlane.frame.size.width - frame.size.width ) / 2;
    _viewAddtion.frame = frame;
    
    if (m_viewContentPlane)
    {
        frame = m_viewContentPlane.frame;
        frame.size.height += (viewAddtion.frame.size.height + 10);
        m_viewContentPlane.frame = frame;
        [m_viewContentPlane addSubview:_viewAddtion];
        m_viewBackground.center = m_viewBackground.superview.center;
    }
}

#pragma mark -

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    if (self = [super init])
    {
        _colorSeparatorLine = [UIColor colorWithRed:(158)/255.0f green:(158)/255.0f blue:(158)/255.0f alpha:1];
        _colorBtnTitle = [UIColor colorWithRed:(56)/255.0f green:(56)/255.0f blue:(56)/255.0f alpha:1];
        
        NSMutableArray *mtArray = [[NSMutableArray alloc] initWithCapacity:2];
        [mtArray addObject:cancelButtonTitle];
        
        if (otherButtonTitles == nil)
            return self;
        [mtArray addObject:otherButtonTitles];
        va_list arguments;
        va_start(arguments, otherButtonTitles);
        id param;
        while ((param = va_arg(arguments, id)))
        {
            [mtArray addObject:param];
        }
        va_end(arguments);
        m_arrayBtnTitle = mtArray;
        
        [self initControls];
        
        self.strTitle = title;
        self.strMessage = message;
        
        UIImage *image = [UIImage imageNamed:@"CustomAlertView.bundle/titleBackground"];
        [self setTitleBackgroundImage:image];
        
        m_delegate = delegate;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)initControls
{
    //按钮
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    view.autoresizesSubviews = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    m_viewBtnPlane = view;
    CGRect frame = CGRectMake(0, 0, fWidth, 0);
    NSInteger nCount = [m_arrayBtnTitle count];
    if (nCount == 2)//两个按钮
    {
        frame.size.height = 44.5;
        
        UIView *viewSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fWidth, 0.5)];
        viewSeparator.backgroundColor = _colorSeparatorLine;
        [m_viewBtnPlane addSubview:viewSeparator];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0.5 + viewSeparator.frame.origin.y, (fWidth - 0.5) / 2, 44);
        [btn setTitleColor:_colorBtnTitle forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClickedOk:) forControlEvents:UIControlEventTouchUpInside];
        [m_viewBtnPlane addSubview:btn];
        NSString *title = [m_arrayBtnTitle firstObject];
        [btn setTitle:title forState:UIControlStateNormal];
        UIButton *btnLeft = btn;
        btn.tag = 0;
        //分割线
        viewSeparator = [[UIView alloc] initWithFrame:CGRectMake(btn.frame.size.width + btn.frame.origin.x, 0, 0.5, 44)];
        viewSeparator.backgroundColor = _colorSeparatorLine;
        [m_viewBtnPlane addSubview:viewSeparator];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(viewSeparator.frame.origin.x + viewSeparator.frame.size.width, btnLeft.frame.origin.y, (fWidth - 0.5) / 2, 44);
        [btn setTitleColor:_colorBtnTitle forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClickedOk:) forControlEvents:UIControlEventTouchUpInside];
        [m_viewBtnPlane addSubview:btn];
        title = [m_arrayBtnTitle lastObject];
        [btn setTitle:title forState:UIControlStateNormal];
        UIButton *btnRight = btn;
        btn.tag = 1;
        
        UIImage *image = [UIImage imageNamed:@"CustomAlertView.bundle/btnLeftBk"];
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height / 2 - 1, image.size.width / 2 - 1, image.size.height / 2 - 1, image.size.width / 2 - 1)];
        [btnLeft setBackgroundImage:image forState:UIControlStateNormal];
        image = [UIImage imageNamed:@"CustomAlertView.bundle/btnLeftClickedBk"];
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height / 2 - 1, image.size.width / 2 - 1, image.size.height / 2 - 1, image.size.width / 2 - 1)];
        [btnLeft setBackgroundImage:image forState:UIControlStateHighlighted];
        
        image = [UIImage imageNamed:@"CustomAlertView.bundle/btnRightBk"];
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height / 2 - 1, image.size.width / 2 - 1, image.size.height / 2 - 1, image.size.width / 2 - 1)];
        [btnRight setBackgroundImage:image forState:UIControlStateNormal];
        image = [UIImage imageNamed:@"CustomAlertView.bundle/btnRightClickedBk"];
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height / 2 - 1, image.size.width / 2 - 1, image.size.height / 2 - 1, image.size.width / 2 - 1)];
        [btnRight setBackgroundImage:image forState:UIControlStateHighlighted];
    }
    else
    {
        frame.size.height = 44.5 * [m_arrayBtnTitle count];
        
        NSEnumerator *titlesBtn = [m_arrayBtnTitle reverseObjectEnumerator];
        UIButton *btn;
        int n = 0;
        UIImage *imageBtnNormalBk = [UIImage imageNamed:@"CustomAlertView.bundle/btnLeftBk"];
        CGImageRef imgRef = CGImageCreateWithImageInRect(imageBtnNormalBk.CGImage, CGRectMake(imageBtnNormalBk.size.height / 2 - 1, imageBtnNormalBk.size.width / 2 - 1, 1, 1));
        imageBtnNormalBk = [UIImage imageWithCGImage:imgRef];
        CFRelease(imgRef);
        UIImage *imageBtnClickedBk = [UIImage imageNamed:@"CustomAlertView.bundle/btnLeftClickedBk"];
        imgRef = CGImageCreateWithImageInRect(imageBtnClickedBk.CGImage, CGRectMake(imageBtnClickedBk.size.height / 2 - 1, imageBtnClickedBk.size.width / 2 - 1, 1, 1));
        imageBtnClickedBk = [UIImage imageWithCGImage:imgRef];
        CFRelease(imgRef);
        
        for (NSString *title in titlesBtn)
        {
            UIView *viewSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5 * n, fWidth, 0.5)];
            viewSeparator.backgroundColor = [UIColor colorWithRed:(158)/255.0f green:(158)/255.0f blue:(158)/255.0f alpha:1];
            [m_viewBtnPlane addSubview:viewSeparator];
            
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0.5 + viewSeparator.frame.origin.y, fWidth, 44);
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:_colorBtnTitle forState:UIControlStateNormal];
            [btn setBackgroundImage:imageBtnNormalBk forState:UIControlStateNormal];
            [btn setBackgroundImage:imageBtnClickedBk forState:UIControlStateHighlighted];
            btn.tag = nCount - n - 1;
            [btn addTarget:self action:@selector(btnClickedOk:) forControlEvents:UIControlEventTouchUpInside];
            [m_viewBtnPlane addSubview:btn];
            
            n++;
        }
        imageBtnNormalBk = [UIImage imageNamed:@"CustomAlertView.bundle/btnBk"];
        imageBtnNormalBk = [imageBtnNormalBk resizableImageWithCapInsets:UIEdgeInsetsMake(imageBtnNormalBk.size.height / 2 - 1, imageBtnNormalBk.size.width / 2 - 1, imageBtnNormalBk.size.height / 2 - 1, imageBtnNormalBk.size.width / 2 - 1)];
        imageBtnClickedBk = [UIImage imageNamed:@"CustomAlertView.bundle/btnClickedBk"];
        imageBtnClickedBk = [imageBtnClickedBk resizableImageWithCapInsets:UIEdgeInsetsMake(imageBtnClickedBk.size.height / 2 - 1, imageBtnClickedBk.size.width / 2 - 1, imageBtnClickedBk.size.height / 2 - 1, imageBtnClickedBk.size.width / 2 - 1)];
        [btn setBackgroundImage:imageBtnNormalBk forState:UIControlStateNormal];
        [btn setBackgroundImage:imageBtnClickedBk forState:UIControlStateHighlighted];
        
    }
    m_viewBtnPlane.frame = frame;//实际上是设置大小
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fWidth, 0)];
    m_viewBackground = view;
    view.backgroundColor = [UIColor clearColor];
    [m_viewBackground addSubview:m_viewBtnPlane];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fWidth, 0)];
    view.autoresizesSubviews = UIViewAutoresizingFlexibleWidth;
    m_viewContentPlane = view;
    view.backgroundColor = [UIColor whiteColor];
    [m_viewBackground addSubview:m_viewContentPlane];
    //标题区
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fWidth, 40)];
    m_viewTitlePlane = view;
    view.autoresizesSubviews = UIViewAutoresizingFlexibleWidth;
    view.backgroundColor = [UIColor whiteColor];
    [m_viewBackground addSubview:m_viewTitlePlane];
}

- (void)dealloc
{
    NSLog(@"CustomAlertView dealloc");
}

- (void)layoutSubviews
{
//    CGRect frame = m_viewTitlePlane.frame;
//    frame.origin.x = 0;
//    frame.origin.y = 0;
//    m_viewTitlePlane.frame = frame;
    
    //标题对齐方式设置
    CGSize sizeMsgText;
    NSString *message = m_labelMessage.text;
    if ([m_labelMessage.attributedText length] > 0)
    {
        message = [m_labelMessage.attributedText string];
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        CGRect expectedFrame = [message boundingRectWithSize:CGSizeMake(1000, 1000)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              m_labelMessage.font, NSFontAttributeName,
                                                              nil]
                                                     context:nil];
        expectedFrame.size.width = ceil(expectedFrame.size.width);
        expectedFrame.size.height = ceil(expectedFrame.size.height);
        sizeMsgText = expectedFrame.size;
    }
    else
    {
        _Pragma("clang diagnostic push")
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        sizeMsgText = [message sizeWithFont:m_labelMessage.font
                         constrainedToSize:CGSizeMake(m_labelMessage.frame.size.width, 1000)
                             lineBreakMode:NSLineBreakByWordWrapping];
        #pragma clang diagnostic pop
    }
    if (sizeMsgText.width > m_labelMessage.frame.size.width)
    {
        m_labelMessage.textAlignment = NSTextAlignmentLeft;
    }
    else
    {
        m_labelMessage.textAlignment = NSTextAlignmentCenter;
    }
    //内容区
    CGRect frame = CGRectMake(0, m_viewTitlePlane.frame.origin.y + m_viewTitlePlane.frame.size.height, m_viewBackground.frame.size.width, m_labelMessage.frame.origin.y + m_labelMessage.frame.size.height + 10);
    if (_viewAddtion)
    {
        frame.size.height = _viewAddtion.frame.origin.y + _viewAddtion.frame.size.height + 10;
    }
    m_viewContentPlane.frame = frame;
    
    frame.origin.y += frame.size.height;
    frame.size.height = m_viewBtnPlane.frame.size.height;
    m_viewBtnPlane.frame = frame;
    
    frame = m_viewBackground.frame;
    frame.size.height = m_viewTitlePlane.frame.size.height + m_viewContentPlane.frame.size.height + m_viewBtnPlane.frame.size.height;
    m_viewBackground.frame = frame;
    m_viewBackground.center = m_viewBackground.superview.center;
}

- (void)setTitleBackgroundImage:(UIImage *)image
{
    if (m_imageViewTitle == nil && image != nil)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, m_viewTitlePlane.frame.size.width, m_viewTitlePlane.frame.size.height);
        imageView.autoresizesSubviews = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [m_viewTitlePlane addSubview:imageView];
        [m_viewTitlePlane bringSubviewToFront:m_labelTitle];
        m_imageViewTitle = imageView;
        m_viewTitlePlane.backgroundColor = [UIColor clearColor];
    }
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height / 2 - 1, image.size.width / 2 - 1, image.size.height / 2 - 1, image.size.width / 2 - 1)];
    m_imageViewTitle.image = image;
}

- (void)show
{
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows)
    {
        if (window.windowLevel == UIWindowLevelNormal)
        {
            self.frame = window.frame;
            [window addSubview:self];
            [window addSubview:m_viewBackground];
            break;
        }
    }
    self.backgroundColor = [UIColor lightGrayColor];
    self.alpha = 0.5;
    self.center = self.superview.center;
    m_viewBackground.center = m_viewBackground.superview.center;
}

- (void)dissmis
{
    [m_viewBackground removeFromSuperview];
    [self removeFromSuperview];
}

- (IBAction)btnClickedOk:(id)sender
{
    NSInteger nIndex = ((UIButton *)sender).tag;
    if ([m_delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)])
    {
        [m_delegate alertView:(UIAlertView *)self clickedButtonAtIndex:nIndex];
    }
    [self dissmis];
}
/*
 // Called when a button is clicked. The view will be automatically dismissed after this call returns
 - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
 
 // Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
 // If not defined in the delegate, we simulate a click in the cancel button
 - (void)alertViewCancel:(UIAlertView *)alertView;
 
 - (void)willPresentAlertView:(UIAlertView *)alertView;  // before animation and showing view
 - (void)didPresentAlertView:(UIAlertView *)alertView;  // after animation
 
 - (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
 - (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation
 
 // Called after edits in any of the default fields added by the style
 - (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView;
 */
@end
