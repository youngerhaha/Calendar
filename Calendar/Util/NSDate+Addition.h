//
//  NSDate+Addition.h
//  Calendar
//
//  Created by 李洋 on 2018/1/17.
//  Copyright © 2018年 李洋. All rights reserved.
//

#import <Foundation/Foundation.h>

//本月第一天是星期几
typedef enum : int {
    Sunday=0,
    Monday,
    Tuesday,
    Wednesday,
    Thursday,
    Friday,
    Saturday,
} WeekDayForFirstDayInMonth;

@interface NSDate (Addition)

// 某年某月的1号对应的日期
+ (NSDate *)firstDateWithYear:(int)year andMonth:(int)month;

//某月的天数
+ (int)dayNumInYear:(int)year andMonth:(int)month;

//某年是否为闰年
+ (BOOL)isYearLeapYear:(int)year;

//现在的年月日和本月第一天是周几
+ (void)currentYear:(int *)year month:(int *)month day:(int *)day;

+ (WeekDayForFirstDayInMonth)weekDayForFirstDayInMonthWithYear:(int)year andMonth:(int)month;

@end
