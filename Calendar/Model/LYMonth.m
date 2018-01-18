//
//  LYMonth.m
//  Test-Calendar
//
//  Created by 李洋 on 15/6/8.
//  Copyright (c) 2015年 李洋. All rights reserved.
//

#import "LYMonth.h"

@interface LYMonth ()

//公历
@property (nonatomic, readwrite) int year;
@property (nonatomic, readwrite) int month;
//该月所有的天
@property (nonatomic, readwrite, copy) NSArray *days;

//本月第一天是该周的星期几
@property (nonatomic, readwrite) WeekDayForFirstDayInMonth weekDayForFirstDayInMonth;

@end

@implementation LYMonth

//懒加载方式
- (NSArray *)days {
    if (!_days) {
        //添加本月的所有天
        NSMutableArray *allDays = [NSMutableArray array];
        for (int i = 0; i< [NSDate dayNumInYear:self.year andMonth:self.month]; i++) {
            LYDay *lyDay = [LYDay dayWithYear:self.year month:self.month andDay:i+1];
            [allDays addObject:lyDay];
        }
        
        //设置今天
        int year,month,day,weekDayForFirstDayInMonth;
        [NSDate currentYear:&year month:&month day:&day];
        if (self.year == year && self.month == month) {
            LYDay *lyDay = allDays[day-1];
            lyDay.today = YES;
        }
        
        _days = [allDays copy];

    }
    return _days;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"year:%d month:%d weekDayForFirstDayInMonth:%d", self.year, self.month, self.weekDayForFirstDayInMonth];
}

#pragma mark - Static Functions

//本月
+ (LYMonth *)thisMonth {
    int year,month,day,weekDayForFirstDayInMonth;
    [NSDate currentYear:&year month:&month day:&day];
    LYMonth *lyMonth = [LYMonth monthWithYear:year andMonth:month];
    return lyMonth;
}

//上个月
+ (LYMonth *)lastMonth:(LYMonth *)lyMonth {
    int year = lyMonth.year;
    int month = lyMonth.month;
    if (month == 1) {
        year--;
        month = 12;
    } else {
        month--;
    }
    
    LYMonth *lastMonth = [LYMonth monthWithYear:year andMonth:month];
    return lastMonth;
}

//下个月
+ (LYMonth *)nextMonth:(LYMonth *)lyMonth {
    int year = lyMonth.year;
    int month = lyMonth.month;
    if (month == 12) {
        year++;
        month = 1;
    } else {
        month++;
    }
    
    LYMonth *nextMonth = [LYMonth monthWithYear:year andMonth:month];
    return nextMonth;
}

//year和month来创建LYMonth
+ (LYMonth *)monthWithYear:(int)year andMonth:(int)month {
    WeekDayForFirstDayInMonth weekDayForFirstDayInMonth = [NSDate weekDayForFirstDayInMonthWithYear:year andMonth:month];
    LYMonth *lyMonth = [[LYMonth alloc]init];
    lyMonth.year = year;
    lyMonth.month = month;
    lyMonth.weekDayForFirstDayInMonth = weekDayForFirstDayInMonth;
    return lyMonth;
}

@end
