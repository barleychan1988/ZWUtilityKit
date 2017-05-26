//
//  WMCustomDatePicker.h
//  datePicker
//
//  Created by Mac on 15-4-29.
//  Copyright (c) 2015年 wmeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, WMDateStyle)
{
    WMDateStyle_YearMonthDayHourMinute = 0,
    WMDateStyle_YearMonthDayHourMinuteSecond,
    WMDateStyle_YearMonthDayHour,
    WMDateStyle_YearMonthDay,
    WMDateStyle_YearMonth,
    WMDateStyle_Year,
    WMDateStyle_MonthDayHourMinute,
    WMDateStyle_HourMinute
};

@class WMCustomDatePicker;

@protocol WMCustomDatePickerDelegate <NSObject>
@optional
//选择完成之后调用
-(void)finishDidSelectDatePicker:(WMCustomDatePicker *)datePicker
                            year:(NSString *)year
                           month:(NSString *)month
                             day:(NSString *)day
                            hour:(NSString *)hour
                          minute:(NSString *)minute
                          second:(NSString *)strSecond
                         weekDay:(NSString *)weekDay;
-(void)finishDidSelectDatePicker:(WMCustomDatePicker *)datePicker
                            date:(NSDate *)date;
@end


@interface WMCustomDatePicker : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, assign)id<WMCustomDatePickerDelegate>delegate;
@property (nonatomic, assign) WMDateStyle datePickerStyle;
@property (nonatomic, strong) NSDate *ScrollToDate;//滚到指定日期
@property (nonatomic, strong) NSDate *maxLimitDate;//限制最大时间（没有设置默认2049）
@property (nonatomic, strong) NSDate *minLimitDate;//限制最小时间（没有设置默认1970）

@property (nonatomic, strong) NSDate *date;//选择器的时间

@property (nonatomic, retain)UIColor *colorNormal;//default is black color.
@property (nonatomic, retain)UIColor *colorDisable;//default is gray color.
@property (nonatomic, retain)UIFont *fontMaxData;//修改最大的文字大小.default is 20.
@property (nonatomic, assign)NSInteger nIntervalMin;//设置分钟时间间隔
@property (nonatomic, assign)NSInteger nIntervalSecond;//设置秒钟时间间隔

/**
 *  初始化datepicker
 *
 *  @param frame       位置
 *  @param delegate    代理
 *  @param WMDateStyle 类型
 *
 *  @return WMCustomDatePicker的对象
 */
- (id)initWithframe:(CGRect)frame Delegate:(id<WMCustomDatePickerDelegate>)delegate PickerStyle:(WMDateStyle)WMDateStyle;
/**
 *  初始化datepicker
 *
 *  @param frame       位置
 *  @param WMDateStyle 类型
 *  @param finish      block块的返回
 *
 *  @return WMCustomDatePicker的对象
 */
- (id)initWithframe:(CGRect)frame PickerStyle:(WMDateStyle)WMDateStyle  didSelectedDateFinish:(void(^)(WMCustomDatePicker *picker,NSDate *date))finish;
/**
 *  初始化datepicker
 *
 *  @param frame       位置
 *  @param WMDateStyle 类型
 *  @param finishBack  black块的返回
 *
 *  @return WMCustomDatePicker的对象
 */
- (id)initWithframe:(CGRect)frame PickerStyle:(WMDateStyle)WMDateStyle  didSelectedDateFinishBack:(void(^)(WMCustomDatePicker *picker,NSString *year,NSString *month,NSString *day,NSString *hour,NSString *minute,NSString *strSecond,NSString *weekDay))finishBack;


@end
