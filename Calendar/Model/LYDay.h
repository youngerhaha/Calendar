//
//  LYDay.h
//  Test-Calendar
//
//  Created by 李洋 on 15/6/8.
//  Copyright (c) 2015年 李洋. All rights reserved.
//

#import <Foundation/Foundation.h>

//天（公历）
@interface LYDay : NSObject

//公历年份
@property (nonatomic, readonly) int year;
//公历月份
@property (nonatomic, readonly) int month;
//公历日
@property (nonatomic, readonly) int day;

//是否在当前月
@property (nonatomic, getter=isInCurrentMonth) BOOL inCurrentMonth;
//该天是不是今天
@property (nonatomic, getter=isToday) BOOL today;

+ (LYDay *)dayWithYear:(int)year month:(int)month andDay:(int)day;

@end
