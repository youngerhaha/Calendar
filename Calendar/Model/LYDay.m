//
//  LYDay.m
//  Test-Calendar
//
//  Created by 李洋 on 15/6/8.
//  Copyright (c) 2015年 李洋. All rights reserved.
//

#import "LYDay.h"

@interface LYDay ()

//公历(gc)
@property (nonatomic, readwrite) int year;
@property (nonatomic, readwrite) int month;
@property (nonatomic, readwrite) int day;

@end

@implementation LYDay

- (instancetype)initWithYear:(int)year month:(int)month andDay:(int)day
{
    self = [super init];
    if (self) {
        self.year = year;
        self.month = month;
        self.day = day;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"year:%d month:%d day:%d", self.year, self.month, self.day];
}

+ (LYDay *)dayWithYear:(int)year month:(int)month andDay:(int)day {
    return [[LYDay alloc]initWithYear:year month:month andDay:day];
}

@end
