//
//  LYMonth.h
//  Test-Calendar
//
//  Created by 李洋 on 15/6/8.
//  Copyright (c) 2015年 李洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYDay.h"

//月
@interface LYMonth : NSObject

//公历（公历）
//公历年份
@property (nonatomic, readonly) int year;
//公历月份
@property (nonatomic, readonly) int month;
//该月所有的天
@property (nonatomic, readonly, copy) NSArray *days;

//本月第一天是该周的星期几
@property (nonatomic, readonly) WeekDayForFirstDayInMonth weekDayForFirstDayInMonth;

//本月
+ (LYMonth *)thisMonth;
//上个月
+ (LYMonth *)lastMonth:(LYMonth *)month;
//下个月
+ (LYMonth *)nextMonth:(LYMonth *)month;

//通过year和month来创建LYMonth
+ (LYMonth *)monthWithYear:(int)year andMonth:(int)month;

@end
