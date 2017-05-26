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

@interface ZWLocationAuthor ()<CLLocationManagerDelegate, UIAlertViewDelegate>
{
    CLLocationManager *m_locationManager;
    CLLocation *m_locationCur;
}
@property (nonatomic, assign)BOOL bRepeat;
@end

@implementation ZWLocationAuthor

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
                NSString *strAppName = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleNameKey];
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
        NSString *strAppName = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleNameKey];
        NSString *strMsg = [NSString stringWithFormat:@"请到设置->隐私->定位服务中开启【%@】定位服务", strAppName];
        [self showAlertMsg:strMsg title:@"定位服务已关闭"];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    m_locationCur = newLocation;
    if (_blockUpdateLocation)
    {
        _blockUpdateLocation(newLocation);
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
    if (IOS8)
    {
#ifdef __IPHONE_8_0
        UIAlertController *sheet = [UIAlertController alertControllerWithTitle:strTitle message:strMsg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            _bIsAlerting = NO;
            [ZWLocationAuthor releaseInstance];
        }];
        [sheet addAction:cancelAction];
        UIAlertAction *actionSetting = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //定位服务设置界面
            NSString *strSettingUrl;
            if ([CLLocationManager locationServicesEnabled])
                strSettingUrl = UIApplicationOpenSettingsURLString;
            else
                strSettingUrl = @"prefs:root=LOCATION_SERVICES";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strSettingUrl]];
        }];
        [sheet addAction:actionSetting];
        dispatch_async(dispatch_get_main_queue(), ^{
            [vcBlock presentViewController:sheet animated:YES completion:nil];
        });
#endif
    }
    else
    {
        UIAlertView *sheet = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];        
        dispatch_async(dispatch_get_main_queue(), ^{
            [sheet show];
        });
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        //定位服务设置界面
        NSString *strSettingUrl = @"prefs:root=LOCATION_SERVICES";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strSettingUrl]];
    }
    _bIsAlerting = NO;
    [ZWLocationAuthor releaseInstance];
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