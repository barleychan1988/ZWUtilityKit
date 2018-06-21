//
//  ZWLocationAuthor.m
//  SuperCode
//
//  Created by chenpeng on 16/3/30.
//  Copyright © 2016年 chenzw. All rights reserved.
//

#import "ZWLocationAuthor.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "UtilityUIKit.h"

@interface ZWLocationAuthor ()<CLLocationManagerDelegate, UIAlertViewDelegate>
{
    CLLocationManager *m_locationManager;
    CLLocation *m_locationCur;
}
@property (nonatomic, assign)BOOL bRepeat;
@end

@implementation ZWLocationAuthor

NSString *const kMsgLocationUpdate = @"kMsgLocationUpdate";

static ZWLocationAuthor * g_LocalAuthor;

+ (ZWLocationAuthor *)getInstance
{
    @synchronized(self)
    {
        if (g_LocalAuthor == nil)
        {
            g_LocalAuthor = [[self alloc] init];
        }
    }
//    static dispatch_once_t once;
//    dispatch_once(&once, ^{g_LocalAuthor = [[self alloc] init];});
    return g_LocalAuthor;
}

+ (void)releaseInstance
{
    g_LocalAuthor.blockUpdateLocation = nil;
    g_LocalAuthor = nil;
}

- (id)init
{
    if (self = [super init])
    {
    }
    return self;
}

- (void)alertAutorizationDialog
{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    m_locationManager = locationManager;
    
    if ([CLLocationManager locationServicesEnabled])
    {
        locationManager.delegate = self;
        locationManager.distanceFilter = 200;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        switch ([CLLocationManager authorizationStatus])
        {
            case kCLAuthorizationStatusNotDetermined:
            {
                if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
                {
                    [locationManager performSelector:@selector(requestWhenInUseAuthorization)];//用这个方法，plist里要加字段NSLocationWhenInUseUsageDescription
                }
                else if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
                {
                    [locationManager performSelector:@selector(requestAlwaysAuthorization)];//用这个方法，plist中需要NSLocationAlwaysUsageDescription
                }
            }
                break;
            case kCLAuthorizationStatusDenied:
            {
                NSString *strAppName = getAppDisplayName();
                NSString *strMsg = [NSString stringWithFormat:@"请到设置->隐私->定位服务中开启【%@】定位服务", strAppName];
                [self showAlertMsg:strMsg title:@"定位服务已关闭"];
            }
                break;
            default:
                break;
        }
        [locationManager startUpdatingLocation];
    }
    else
    {
        NSString *strAppName = getAppDisplayName();
        NSString *strMsg = [NSString stringWithFormat:@"请到设置->隐私->定位服务中开启【%@】定位服务", strAppName];
        [self showAlertMsg:strMsg title:@"定位服务已关闭"];
    }
}

#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *old = m_locationCur;
    m_locationCur = locations.lastObject;
    if (_blockUpdateLocation)
    {
        _blockUpdateLocation(m_locationCur);
    }
    if (old == nil && m_locationCur != nil)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kMsgLocationUpdate object:m_locationCur];
    }
    //do something else
    if (!_bRepeat)
        [ZWLocationAuthor releaseInstance];
}

- (void)showAlertMsg:(NSString *)strMsg title:(NSString *)strTitle
{
    if (_bIsAlerting) return;
    _bIsAlerting = YES;
    __block UIViewController *vcBlock = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    if (@available(iOS 8.0, *))
    {
        UIAlertController *sheet = [UIAlertController alertControllerWithTitle:strTitle message:strMsg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            self->_bIsAlerting = NO;
            [ZWLocationAuthor releaseInstance];
        }];
        [sheet addAction:cancelAction];
        UIAlertAction *actionSetting = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self->_bIsAlerting = NO;
            //定位服务设置界面
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        [sheet addAction:actionSetting];
        dispatch_async(dispatch_get_main_queue(), ^{
            [vcBlock presentViewController:sheet animated:YES completion:nil];
        });
    }
}

@end

void alertLocationAuthorization(BOOL bRepeat, BlockObject blockUpdateLocation)
{
    [ZWLocationAuthor getInstance].bRepeat = bRepeat;
    [[ZWLocationAuthor getInstance] alertAutorizationDialog];
    [ZWLocationAuthor getInstance].blockUpdateLocation = blockUpdateLocation;
}

BOOL isLocationEnable()
{
    BOOL bRet = [CLLocationManager locationServicesEnabled];
    if (bRet)
    {
        switch ([CLLocationManager authorizationStatus])
        {
            case kCLAuthorizationStatusNotDetermined:
            case kCLAuthorizationStatusRestricted:
            case kCLAuthorizationStatusDenied:
            {
                bRet = NO;
            }
            break;
            default:
                break;
        }
    }
    return bRet;
}

void alertAutorizationDialog()
{
    NSString *strAppName = getAppDisplayName();
    NSString *strMsg = [NSString stringWithFormat:@"请到设置->隐私->定位服务中开启【%@】定位服务", strAppName];
    [[ZWLocationAuthor getInstance] showAlertMsg:strMsg title:@"定位服务已关闭"];
}
