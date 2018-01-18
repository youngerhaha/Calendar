//
//  CalendarMonth.m
//  Test-Calendar
//
//  Created by 李洋 on 15/6/8.
//  Copyright (c) 2015年 李洋. All rights reserved.
//

#import "CalendarMonth.h"

@interface CalendarMonth ()

//公历
@property (nonatomic, readwrite, strong) LYMonth *lyMonth;
@property (nonatomic, readwrite, strong) NSArray *days;

@end

@implementation CalendarMonth

//懒加载，生成日历上的一个月（42天）
- (NSArray *)days {
    if (!_days) {
        NSMutableArray *allDays = [NSMutableArray arrayWithCapacity:42];
        
        LYMonth *thisMonth = self.lyMonth;
        LYMonth *lastMonth = [LYMonth lastMonth:thisMonth];
        LYMonth *nextMonth = [LYMonth nextMonth:thisMonth];
        
        int lastMonthDayNum = (int)lastMonth.days.count;
        int thisMonthDayNum = (int)thisMonth.days.count;
        
        int i=0;
        int weekDayForFirstDayInMonth = thisMonth.weekDayForFirstDayInMonth;
        
        //上个月的days
        for (; i<weekDayForFirstDayInMonth; i++) {
            LYDay *day = lastMonth.days[lastMonthDayNum-weekDayForFirstDayInMonth+i];
            day.inCurrentMonth = NO;
            [allDays addObject:day];
        }
        
        //本月的days
        for (;i<weekDayForFirstDayInMonth+thisMonthDayNum;i++) {
            LYDay *day = thisMonth.days[i-weekDayForFirstDayInMonth];
            day.inCurrentMonth = YES;
            [allDays addObject:day];
        }
        
        //下个月的days
        for (; i<42; i++) {
            LYDay *day = nextMonth.days[i-weekDayForFirstDayInMonth-thisMonthDayNum];
            day.inCurrentMonth = NO;
            [allDays addObject:day];
        }
        
        //日历上的一个月（42天）
        _days = [allDays copy];
    }
    return _days;
}

- (int)year {
    return self.lyMonth.year;
}

- (int)month {
    return self.lyMonth.month;
}

- (NSString *)description
{
    NSMutableString *mutString = [NSMutableString string];
    for (int i=0; i<42; i++) {
        LYDay *day = self.days[i];
        [mutString appendFormat:@"%@\n",day];
    }
    return [mutString copy];
}

#pragma mark - Static Functions

//本月
+ (CalendarMonth *)thisCalendarMonth {
    LYMonth *thisMonth = [LYMonth thisMonth];
    CalendarMonth *cMonth = [CalendarMonth calendarMonthWithLYMonth:thisMonth];
    return cMonth;
}

//上月
+ (CalendarMonth *)lastCalendarMonth:(CalendarMonth *)calendarMonth {
    LYMonth *lastMonth = [LYMonth lastMonth:calendarMonth.lyMonth];
    CalendarMonth *lastCMonth = [CalendarMonth calendarMonthWithLYMonth:lastMonth];
    return lastCMonth;
}

//下月
+ (CalendarMonth *)nextCalendarMonth:(CalendarMonth *)calendarMonth {
    LYMonth *nextMonth = [LYMonth nextMonth:calendarMonth.lyMonth];
    CalendarMonth *nextCMonth = [CalendarMonth calendarMonthWithLYMonth:nextMonth];
    return nextCMonth;
}

//通过year和month来创建CalendarMonth
+ (CalendarMonth *)calendarMonthWithYear:(int)year andMonth:(int)month {
    LYMonth *lyMonth = [LYMonth monthWithYear:year andMonth:month];
    CalendarMonth *calendarMonth = [CalendarMonth calendarMonthWithLYMonth:lyMonth];
    return calendarMonth;
}

//通过lyMonth创建calendarMonth
+ (CalendarMonth *)calendarMonthWithLYMonth:(LYMonth *)lyMonth {
    CalendarMonth *calendarMonth = [[CalendarMonth alloc]init];
    calendarMonth.lyMonth = lyMonth;
    return calendarMonth;
}

@end
