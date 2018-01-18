//
//  CalendarMonth.h
//  Test-Calendar
//
//  Created by 李洋 on 15/6/8.
//  Copyright (c) 2015年 李洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYMonth.h"

//日历上的每个月
@interface CalendarMonth : NSObject

//公历
@property (nonatomic, readonly, strong) NSArray *days;

//公历年份
@property (nonatomic, readonly) int year;
//公历月份
@property (nonatomic, readonly) int month;

//本月
+ (CalendarMonth *)thisCalendarMonth;

//上月
+ (CalendarMonth *)lastCalendarMonth:(CalendarMonth *)calendarMonth;

//下月
+ (CalendarMonth *)nextCalendarMonth:(CalendarMonth *)calendarMonth;

//通过year和month来创建CalendarMonth
+ (CalendarMonth *)calendarMonthWithYear:(int)year andMonth:(int)month;

@end
