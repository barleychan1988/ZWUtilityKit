//
//  UtilityKit.m
//  checkCar
//
//  Created by chenzhengwang on 14-5-27.
//  Copyright (c) 2014年 zwchen. All rights reserved.
//

#import "UtilityUIKit.h"
#import "UtilityKit.h"


CGSize getSizeForLabel(NSString *str,UIFont *font, NSLineBreakMode lineBreadMode, CGSize size)
{
    if (size.width == 0 && size.height == 0)
    {
        size = CGSizeMake(1000, 1000);
    }
    if (@available(iOS 7.0, *))
    {
        CGRect expectedFrame = [str boundingRectWithSize:size
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          font, NSFontAttributeName,
                                                          nil]
                                                 context:nil];
        expectedFrame.size.width = ceil(expectedFrame.size.width);
        expectedFrame.size.height = ceil(expectedFrame.size.height);
        return expectedFrame.size;
    }
    else
    {
    }
    return CGSizeZero;
}

CGSize getSizeForLabelText(NSString *str,UIFont *font, CGSize size)
{
    return getSizeForLabel(str, font, NSLineBreakByWordWrapping, size);
}

CGSize getSizeForText(NSString *str,UIFont *font)
{
    return getSizeForLabel(str, font, NSLineBreakByWordWrapping, CGSizeMake(10000, 10000));
}

#pragma mark - Resources

NSBundle * bundleResource(NSString *strBundleName)
{
    if (strBundleName == nil || [strBundleName length] == 0)
    {
        return [NSBundle mainBundle];
    }
    NSURL *url = [[NSBundle mainBundle] URLForResource:strBundleName withExtension:@"bundle"];
    if (url == nil)
    {
        return nil;
    }
    return [NSBundle bundleWithURL:url];
}

UIImage * imageInBundle(NSString *strImgName, NSString *strBundleName, NSString *strSubPath)
{
    if ([strBundleName isKindOfClass:[NSString class]] && [strBundleName length] > 0)
    {
        if ([strBundleName hasSuffix:@".bundle"])
        {
            strBundleName = [strBundleName substringToIndex:[strBundleName length] - 8];
        }
    }
    NSBundle *bundle = bundleResource(strBundleName);
    NSString *strImgPath;
    if ([strSubPath length] > 0)
    {
        strImgPath = [bundle pathForResource:strImgName ofType:nil inDirectory:strSubPath];
    }
    else
    {
        strImgPath = [bundle pathForResource:strImgName ofType:nil];
    }
    return [UIImage imageWithContentsOfFile:strImgPath];
}

UIImage * imageNamed(NSString *strImgName, NSString *strBundleName, NSString *strSubPath)
{
    NSString *strImgPath = @"";
    if ([strBundleName isKindOfClass:[NSString class]] && [strBundleName length] > 0)
    {
        if (![strBundleName hasSuffix:@".bundle"])
        {
            strBundleName = [strBundleName stringByAppendingString:@".bundle"];
        }
        strImgPath = strBundleName;
    }
    if ([strSubPath isKindOfClass:[NSString class]] && [strSubPath length] > 0)
    {
        if ([strImgPath length] > 0)
            strImgPath = [strImgPath stringByAppendingString:@"/"];
        strImgPath = [strImgPath stringByAppendingString:strSubPath];
    }
    if ([strImgName isKindOfClass:[NSString class]] && [strImgName length] > 0)
    {
        if ([strImgPath length] > 0)
            strImgPath = [strImgPath stringByAppendingString:@"/"];
        strImgPath = [strImgPath stringByAppendingString:strImgName];
    }
//    strImgPath = [NSString stringWithFormat:@"%@/%@/%@", strBundleName, strSubPath, strImgName];
    return [UIImage imageNamed:strImgPath];
}

UIView * nibInBundle(NSString *strNibName, NSString *strBundleName, NSString *strSubPath, id owner)
{
    NSBundle *bundle = bundleResource(strBundleName);
    return [[bundle loadNibNamed:@"pickView" owner:owner options:NULL] lastObject];
}

UIWindow *getApplicationWindow()
{
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows)
    {
        if (window.windowLevel == UIWindowLevelNormal)
        {
            return window;
        }
    }
    return nil;
}

UINavigationController *getCurrentTopNavController()
{
    UIViewController *vcRoot = getApplicationWindow().rootViewController;
    if ([vcRoot isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tabBarVC = (UITabBarController *)vcRoot;
        vcRoot = tabBarVC.selectedViewController;
    }
    UINavigationController *nav;
    if ([vcRoot isKindOfClass:[UINavigationController class]])
    {
        nav = (UINavigationController *)vcRoot;
    }
    else
    {
        nav = vcRoot.navigationController;
    }
    return nav;
}

NSString *getAppDisplayName()
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *strAppName = [mainBundle objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    if (!strAppName || strAppName.length == 0) {
      strAppName = [mainBundle objectForInfoDictionaryKey:@"CFBundleName"];
    }
    return strAppName;
}

NSString *getDocumentDirectory()
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

void removeAllSubviews(UIView *viewParent)
{
    for (UIView *subview in viewParent.subviews)
    {
        [subview removeFromSuperview];
    }
}

void cancelFirstRespond()
{
    id keyWindow = [[UIApplication sharedApplication] keyWindow];
    SEL selector = NSSelectorFromString(@"firstResponder");
    
    _Pragma("clang diagnostic push")
    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
    UIView   *firstResponder = [keyWindow performSelector:selector];
    _Pragma("clang diagnostic pop")
    
    [firstResponder resignFirstResponder];
}

/*
 *  @brief：查找view子窗口及嵌套子窗口中的第一响应者
 *  @ret：第一响应者，若无则返回nil
 */
UIView *findFirstResponderBeneathView(UIView* view)
{
    // Search recursively for first responder
    for ( UIView *childView in view.subviews )
    {
        if ( [childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder] )
        {
            return childView;
        }
        UIView *result = findFirstResponderBeneathView(childView);
        if ( result )
        {
            return result;
        }
    }
    return nil;
}

#import <AVFoundation/AVFoundation.h>
/*
void playBeepFinished(SystemSoundID soundID,void* sample)
{
    //播放全部结束，因此释放所有资源
    AudioServicesDisposeSystemSoundID(soundID);
//    CFRelease(sample);
    CFRunLoopStop(CFRunLoopGetCurrent());
}

void playBeep(NSString *strFileName)
{
    SystemSoundID soundID;
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:strFileName ofType:nil];
    NSURL *sample = [[NSURL alloc]initWithString:soundFilePath];
    
    OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(sample), &soundID);
    if (err)
    {
        NSLog(@"Error occurred assigning system sound!");
    }
    //添加音频结束时的回调
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, playBeepFinished, (__bridge void * _Nullable)(sample));
    //开始播放
    AudioServicesPlaySystemSound(soundID);
}*/

@interface Player : NSObject<AVAudioPlayerDelegate>
{
    AVAudioPlayer *m_player;
}
@end

@implementation Player

static Player *g_palyer = nil;

+ (Player *)sharedInstance
{
    @synchronized(self)
    {
        if (g_palyer == nil)
        {
            g_palyer = [[Player alloc] init];
        }
    }
    return g_palyer;
}

- (void) playAudio:(NSString *)strFileName
{
    if (m_player == nil)
    {
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:strFileName ofType:nil];
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath];
        m_player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    }
    [m_player prepareToPlay];
    [m_player setDelegate:self];
    [m_player play];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    g_palyer= nil;
}

@end

void playBeep(NSString *strFileName)
{
    [[Player sharedInstance] playAudio:strFileName];
}

#pragma mark - Alert

void showAlertMsg(UIViewController<UIAlertViewDelegate> *vc, NSString *strMsg, NSString *strTitle, NSString *strBtnTitleOk, NSString *strBtnTitleCancel, BlockObject handleOk, BlockObject handleCancel)
{
    if (@available(iOS 8.0, *))
    {
        UIAlertController *sheet = [UIAlertController alertControllerWithTitle:strTitle message:strMsg preferredStyle:UIAlertControllerStyleAlert];
        if (strBtnTitleCancel.length > 0)
        {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:strBtnTitleCancel style:UIAlertActionStyleCancel handler:handleCancel];
            [sheet addAction:cancelAction];
        }
        if (strBtnTitleOk.length > 0)
        {
            UIAlertAction *actionSetting = [UIAlertAction actionWithTitle:strBtnTitleOk style:UIAlertActionStyleDefault handler:handleOk];
            [sheet addAction:actionSetting];
        }
        if (![vc isKindOfClass:[UIViewController class]])
        {
            __block UIViewController *vcBlock = [[[UIApplication sharedApplication] delegate] window].rootViewController;
            dispatch_async(dispatch_get_main_queue(), ^{
                [vcBlock presentViewController:sheet animated:YES completion:nil];
            });
        }
        else
            dispatch_async(dispatch_get_main_queue(), ^{
                [vc presentViewController:sheet animated:YES completion:nil];
            });
    }
    else
    {
        UIAlertView *sheet = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:vc cancelButtonTitle:strBtnTitleCancel otherButtonTitles:strBtnTitleOk, nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [sheet show];
        });
    }
}
