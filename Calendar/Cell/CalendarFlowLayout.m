//
//  CalendarFlowLayout.m
//  LYG
//
//  Created by 李洋 on 16/4/2.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import "CalendarFlowLayout.h"

@implementation CalendarFlowLayout

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.itemSize = CGSizeMake((SCREEN_WIDTH-8)/7, 48);
        self.minimumLineSpacing = 1;
        self.minimumInteritemSpacing = 1;
        self.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

@end
