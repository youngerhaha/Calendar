//
//  NSDate+Addition.m
//  Calendar
//
//  Created by 李洋 on 2018/1/17.
//  Copyright © 2018年 李洋. All rights reserved.
//

#import "NSDate+Addition.h"

@implementation NSDate (Addition)

// 某年某月的1号对应的日期
+ (NSDate *)firstDateWithYear:(int)year andMonth:(int)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = year;
    dateComponents.month = month;
    dateComponents.day = 01;

    return [calendar dateFromComponents:dateComponents];
}

//某月的天数
+ (int)dayNumInYear:(int)year andMonth:(int)month {
    int daysInMon[12]={ 31, 28, 31, 30, 31, 30, 31, 31, 30,  31, 30, 31};
    BOOL isLeapYear = [NSDate isYearLeapYear:year];
    int days = 0;
    if (month >= 1 && month <= 12) {
        days = month == 2 ? (daysInMon[month-1] + isLeapYear) : daysInMon[month-1];
    }
    return days;
}

//某年是否为闰年
+ (BOOL)isYearLeapYear:(int)year {
    if (year % 400 == 0 || ((year % 4 == 0) && (year % 100 != 0))) {
        return YES;
    } else {
        return NO;
    }
}

//现在的年月日
+ (void)currentYear:(int *)year month:(int *)month day:(int *)day {
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
    *year = (int)[comps year];
    *month = (int)[comps month];
    *day = (int)[comps day];
}

//某年某月1号是周几
+ (WeekDayForFirstDayInMonth)weekDayForFirstDayInMonthWithYear:(int)year andMonth:(int)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *firstDateInMonth = [NSDate firstDateWithYear:year andMonth:month];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitWeekday) fromDate:firstDateInMonth];
    return (int)[comps weekday] - 1;
}

@end
