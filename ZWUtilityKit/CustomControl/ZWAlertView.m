//
//  ZWAlertView.m
//  ZWUtilityKit
//
//  Created by chenzw on 15/9/14.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import "ZWAlertView.h"
#import "UtilityUIKit.h"
#import "UIView+AddLine.h"

@interface ZWAlertView()
{
    id<UIAlertViewDelegate> m_delegate;
    
    CGSize m_size;
    
    UILabel *m_labelTitle;
    UILabel *m_labelMessage;
    UITapGestureRecognizer *m_tapMessage;
    SEL m_actionMessage;
    id m_target;
    
    NSArray *m_arrayBtns;
}
@end


@implementation ZWAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSAttributedString *)message delegate:(id /**<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super init];
    if (self)
    {
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        
        UIWindow *window = getApplicationWindow();
        m_size.width = window.bounds.size.width - 50;
        
        [self initSubviewWithTitle:title message:message];
        
        NSMutableArray *mtArray = [[NSMutableArray alloc] init];
        UIButton *btn;
        if (cancelButtonTitle != nil)
        {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [btn setTitleColor:RGBCOLOR(0, 122, 255) forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor whiteColor];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [mtArray addObject:btn];
            [self addSubview:btn];
        }
        if (otherButtonTitles != nil)
        {
            va_list arguments;
            va_start(arguments, otherButtonTitles);
            id param = otherButtonTitles;
            do
            {
                btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setTitle:param forState:UIControlStateNormal];
                [btn setTitleColor:RGBCOLOR(0, 122, 255) forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor whiteColor];
                [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [mtArray addObject:btn];
                [self addSubview:btn];
            }while ((param = va_arg(arguments, id)));
            va_end(arguments);
        }
        m_arrayBtns = mtArray;
        
        m_delegate = delegate;
        
        [self updateSize];
    }
    return self;
}

- (void)initSubviewWithTitle:(NSString *)title message:(NSAttributedString *)message
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    UILabel *l = [UILabel new];
    l.text = title;
    l.numberOfLines = 0;
    l.lineBreakMode = NSLineBreakByCharWrapping;
    l.font = [UIFont boldSystemFontOfSize:17];
    l.textAlignment = NSTextAlignmentCenter;
    l.backgroundColor = [UIColor whiteColor];
    [view addSubview:l];
    m_labelTitle = l;
    
    l = [UILabel new];
    l.attributedText = message;
    l.numberOfLines = 0;
    l.lineBreakMode = NSLineBreakByCharWrapping;
    l.font = [UIFont systemFontOfSize:12];
    l.textAlignment = NSTextAlignmentCenter;
    l.backgroundColor = [UIColor whiteColor];
    [view addSubview:l];
    m_labelMessage = l;
}

- (void)updateSize
{
    CGRect frame = CGRectMake(15, 15, m_size.width - 30, 0);
    
    CGFloat fWith = getSizeForLabel(m_labelTitle.text, m_labelTitle.font, NSLineBreakByCharWrapping, CGSizeZero).width + 5;
    NSInteger nLineNum = fWith / m_size.width;
    if (nLineNum * m_size.width < fWith)
    {
        nLineNum++;
    }
    frame.size.height = nLineNum * 22;
    m_labelTitle.frame = frame;
    
    frame.origin.y += (frame.size.height + 10);
    
    fWith = getSizeForLabel(m_labelMessage.text, m_labelMessage.font, NSLineBreakByCharWrapping, CGSizeZero).width + 5;
    nLineNum = fWith / m_size.width;
    if (nLineNum * m_size.width < fWith)
    {
        nLineNum++;
    }
    frame.size.height = nLineNum * 15;
    m_labelMessage.frame = frame;
    
    frame = CGRectMake(0, 0, m_size.width, m_labelMessage.frame.origin.y + m_labelMessage.frame.size.height + 15);
    m_labelTitle.superview.frame = frame;
    
    frame.origin.y += (frame.size.height + 0.5);
    frame.size.height = 43;
    frame.origin.x = 0;
    frame.size.width = (m_size.width - [m_arrayBtns count] + 1) / [m_arrayBtns count];
    for (UIButton *btn in m_arrayBtns)
    {
        btn.frame = frame;
        frame.origin.x += (frame.size.width + 0.5);
    }
    
    m_size.height = m_labelMessage.superview.frame.origin.y + m_labelMessage.superview.frame.size.height;
    m_size.height += 43;
}

- (void)tapMessageTarget:(id)target action:(SEL)aSelector
{
    m_target = target;
    m_actionMessage = aSelector;
    
    m_labelMessage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:m_target action:m_actionMessage];
    [m_labelMessage addGestureRecognizer:tap];
    m_tapMessage = tap;
}

- (void)show
{
    UIWindow *window = getApplicationWindow();
    
    UIView *view = [[UIView alloc] initWithFrame:window.bounds];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    view.backgroundColor = [UIColor clearColor];
    [window addSubview:view];
    
    UIView *viewBack = [[UIView alloc] initWithFrame:window.bounds];
    viewBack.alpha = 0.5;
    viewBack.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    viewBack.backgroundColor = [UIColor blackColor];
    [view addSubview:viewBack];
    
    CGRect frame;
    frame.size = m_size;
    frame.origin.x = (window.bounds.size.width - frame.size.width) / 2;
    frame.origin.y = (window.bounds.size.height - frame.size.height) / 2;
//    self.frame = CGRectInset(frame, 15, 15);
    self.frame = frame;
    [view addSubview:self];
    
//    [UIView animateWithDuration:0.3 animations:^{
//        self.frame = frame;;
//    }];
}

- (void)hide
{
    [self.superview removeFromSuperview];
    removeAllSubviews(self.superview);
}

- (IBAction)btnClicked:(id)sender
{
    NSInteger nIndex = [m_arrayBtns indexOfObject:sender];
    if ([m_delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)])
    {
        [m_delegate alertView:(UIAlertView *)self clickedButtonAtIndex:nIndex];
    }
    [self hide];
}

@end
