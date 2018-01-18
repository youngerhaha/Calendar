//
//  CalendarCollectionCell.m
//  LYG
//
//  Created by 李洋 on 16/4/2.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import "CalendarCollectionCell.h"

@interface CalendarCollectionCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation CalendarCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderWidth = 2;
}

- (void)setDay:(LYDay *)day {
    _day = day;
    
    self.titleLabel.text = [NSString stringWithFormat:@"%d",day.day];
    
    //该天是否为本月的（本月标黑色）
    if (day.isInCurrentMonth) {
        self.titleLabel.textColor = [UIColor blackColor];

        //该天是否为今天（今天标红色）
        if (day.isToday) {
            self.layer.borderColor = [UIColor redColor].CGColor;
        } else {
            self.layer.borderColor = [UIColor whiteColor].CGColor;
        }
        
        self.backgroundColor = [UIColor getColorRGB:@"C7FFC0"];
        self.titleLabel.textColor = [UIColor getColorRGB:@"A40E1E"];
        
    } else {
        self.titleLabel.textColor = [UIColor lightGrayColor];
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.backgroundColor = [UIColor red:255 green:255 blue:255 alpha:1];
    }
    
}

@end
