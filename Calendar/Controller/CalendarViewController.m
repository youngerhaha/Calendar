//
//  CalendarViewController.h
//  Test-Calendar
//
//  Created by 李洋 on 15/6/5.
//  Copyright (c) 2015年 李洋. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarCollectionCell.h"
#import "CalendarMonth.h"
#import "PopupPickerView.h"

#define kCollectionViewHeight self.collectionView.bounds.size.height

@interface CalendarViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,PopupPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


//包含5个CalendarMonth
@property (nonatomic, strong) NSArray *cMonths;

//当前月份
@property (nonatomic) int currentMonth;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.collectionView.scrollsToTop = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:StringWithClass(CalendarCollectionCell) bundle:nil] forCellWithReuseIdentifier:StringWithClass(CalendarCollectionCell)];
    
    CalendarMonth *cMonth = [CalendarMonth thisCalendarMonth];
    [self updateUIWithMiddleCalendarMonth:cMonth];
}

- (void)updateUIWithMiddleCalendarMonth:(CalendarMonth *)middleCMonth {
    [self configureCMonthsWithMiddleCalendarMonth:middleCMonth];
    
    self.currentMonth = middleCMonth.month;
    [self updateTimeLabelAndMonthLabelByCalendarMonth:middleCMonth];
    
    int middle = (int)self.cMonths.count/2;
    self.collectionView.contentOffset = CGPointMake(0, self.collectionView.bounds.size.height*middle);
}

//通过中间月份来生成七个相邻月份
- (void)configureCMonthsWithMiddleCalendarMonth:(CalendarMonth *)middleCMonth {
    CalendarMonth *lastCMonth = [CalendarMonth lastCalendarMonth:middleCMonth];
    CalendarMonth *lastLastCMonth = [CalendarMonth lastCalendarMonth:lastCMonth];
    CalendarMonth *nextCMonth = [CalendarMonth nextCalendarMonth:middleCMonth];
    CalendarMonth *nextNextCMonth = [CalendarMonth nextCalendarMonth:nextCMonth];
    self.cMonths = @[lastLastCMonth,lastCMonth,middleCMonth,nextCMonth,nextNextCMonth];
}

- (void)updateTimeLabelAndMonthLabelByCalendarMonth:(CalendarMonth *)cMonth {
    NSString *timeString = [NSString stringWithFormat:@"%d年%d月",cMonth.year,cMonth.month];
    self.navigationItem.title = timeString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)settingDate:(UIBarButtonItem *)sender {
    // pickerView的数据源
    NSMutableArray *yearArr = [NSMutableArray arrayWithCapacity:200];
    NSMutableArray *monthArr = [NSMutableArray arrayWithCapacity:12];
    // 200个年份
    for (int i=0;i<200;i++) {
        [yearArr addObject:[NSString stringWithFormat:@"%d年", 1900+i]];
    }
    // 12个月份
    for (int j=0;j<12;j++) {
        [monthArr addObject:[NSString stringWithFormat:@"%d月", 1+j]];
    }
    
    // 预选当前年月
    int middle = (int)self.cMonths.count/2;
    CalendarMonth *cMonth = self.cMonths[middle];
    NSArray *preSelectTitles = @[[NSString stringWithFormat:@"%d年",cMonth.year],[NSString stringWithFormat:@"%d月",cMonth.month]];
    [PopupPickerView showPopupPickerViewWithDelegate:self andDataSourceArray:@[[yearArr copy],[monthArr copy]] preSelectTitles:preSelectTitles];
}

- (IBAction)todayItemClicked:(UIBarButtonItem *)sender {
    CalendarMonth *cMonth = [CalendarMonth thisCalendarMonth];
    [self updateUIWithMiddleCalendarMonth:cMonth];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.cMonths.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 42;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {    
    CalendarCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:StringWithClass(CalendarCollectionCell) forIndexPath:indexPath];
    CalendarMonth *cMonth = self.cMonths[indexPath.section];
    cell.day = cMonth.days[indexPath.row];
    return cell;
}

#pragma mark - UIScrollViewDelegate

//停止时更新
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //更新monthLabel
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
    NSIndexPath *indexPath = indexPaths[indexPaths.count/2];
    CalendarMonth *cMonth = self.cMonths[indexPath.section];
    
    if (self.currentMonth != cMonth.month) {
        [self updateUIWithMiddleCalendarMonth:cMonth];
        [self.collectionView reloadData];
    }
}

#pragma mark - PopupPickerViewDelegate

- (void)popupPickerViewDidSelectItemTitles:(NSArray *)itemTitles {
    int year = [[itemTitles[0] stringByReplacingOccurrencesOfString:@"年" withString:@""] intValue];
    int month = [[itemTitles[1] stringByReplacingOccurrencesOfString:@"月" withString:@""] intValue];
    CalendarMonth *cMonth = [CalendarMonth calendarMonthWithYear:year andMonth:month];
    [self updateUIWithMiddleCalendarMonth:cMonth];
    [self.collectionView reloadData];
}

@end
