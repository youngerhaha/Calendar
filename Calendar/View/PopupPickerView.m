//
//  PopupPickerView.m
//  Pengyouquan
//
//  Created by 李洋 on 15/6/30.
//  Copyright (c) 2015年 李洋. All rights reserved.
//

#import "PopupPickerView.h"

#define ShowPopupPickerViewTimeInterval 0.5
#define DismissPopupPickerViewTimeInterval 0.3

static PopupPickerView *popupPickerView = nil;

@interface PopupPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, weak) id<PopupPickerViewDelegate> delegate;

//取消视图
@property (weak, nonatomic) IBOutlet UIView *cancelView;
//辅助视图
@property (weak, nonatomic) IBOutlet UIView *accessoryView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

//pickerView的数据源
@property (nonatomic, strong) NSArray *pickerViewDataSource;

//pickerView的预选中title数组
@property (nonatomic, strong) NSArray *preSelectTitles;

@end

@implementation PopupPickerView

+ (instancetype)getViewFromNib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelPopupPickerView:)];
    [self.cancelView addGestureRecognizer:tapGR];
    
    //应用进入后台时，首先将PopupDatePicker移除，以免多个视图或者控制器弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)cancelPopupPickerView:(UITapGestureRecognizer *)tapGR {
    [popupPickerView dismiss];
}

//在keyWindow中显示PopupPickerView
- (void)show {
    
#ifdef PopupPickerViewAnimationOn

    CGRect accessoryViewFrame = self.accessoryView.frame;
    CGRect pickerViewFrame = self.pickerView.frame;
    self.accessoryView.frame = CGRectMake(accessoryViewFrame.origin.x, SCREEN_HEIGHT, accessoryViewFrame.size.width, accessoryViewFrame.size.height);
    self.pickerView.frame = CGRectMake(pickerViewFrame.origin.x, SCREEN_HEIGHT+accessoryViewFrame.size.height, pickerViewFrame.size.width, pickerViewFrame.size.height);
    
    [UIView animateWithDuration:ShowPopupPickerViewTimeInterval animations:^{
        self.accessoryView.frame = accessoryViewFrame;
        self.pickerView.frame = pickerViewFrame;
    }];
    
#else
    
#endif
    
    //选择预选的选项
    for (int i=0;i<self.pickerViewDataSource.count && self.pickerViewDataSource.count == self.preSelectTitles.count;i++) {
        NSArray *sourceArr = self.pickerViewDataSource[i];
        NSString *preSelectTitle = self.preSelectTitles[i];
        NSUInteger index = [sourceArr indexOfObject:preSelectTitle];
        [self.pickerView selectRow:index inComponent:i animated:NO];
    }
}

+ (void)dismissPopupPickerView {
    if (popupPickerView) [popupPickerView dismiss];
}

//从keyWindow中移除PopupPickerView
- (void)dismiss {
    
#ifdef PopupPickerViewAnimationOn
    if ([self.delegate respondsToSelector:@selector(popupPickerViewWillDismiss)]) {
        [self.delegate popupPickerViewWillDismiss];
    }
    [UIView animateWithDuration:DismissPopupPickerViewTimeInterval animations:^{
        CGRect accessoryViewFrame = self.accessoryView.frame;
        CGRect pickerViewFrame = self.pickerView.frame;
        self.accessoryView.frame = CGRectMake(accessoryViewFrame.origin.x, SCREEN_HEIGHT, accessoryViewFrame.size.width, accessoryViewFrame.size.height);
        self.pickerView.frame = CGRectMake(pickerViewFrame.origin.x, SCREEN_HEIGHT+accessoryViewFrame.size.height, pickerViewFrame.size.width, pickerViewFrame.size.height);
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(popupPickerViewDidDismiss)]) {
            [self.delegate popupPickerViewDidDismiss];
        }
        [self removeFromSuperview];
        popupPickerView = nil;
    }];
    
#else
    if ([self.delegate respondsToSelector:@selector(popupPickerViewDidDismiss)]) {
        [self.delegate popupPickerViewDidDismiss];
    }
    [self removeFromSuperview];
    popupPickerView = nil;
#endif
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

#pragma mark - IBAction

- (IBAction)confirmButtonClicked:(UIButton *)sender {
    NSMutableArray *selectedTitles = [NSMutableArray arrayWithCapacity:self.pickerViewDataSource.count];
    //添加每个component中的被选择的title到selectedTitles中
    for (NSInteger i=0; i<self.pickerViewDataSource.count; i++) {
        NSInteger selectedRow = [popupPickerView.pickerView selectedRowInComponent:i];
        [selectedTitles addObject:self.pickerViewDataSource[i][selectedRow] ];
    }
    
    [self.delegate popupPickerViewDidSelectItemTitles:[selectedTitles copy]];
    [popupPickerView dismiss];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.pickerViewDataSource.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *rowsArr = self.pickerViewDataSource[component];
    return rowsArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSArray *rowsArr = self.pickerViewDataSource[component];
    return rowsArr[row];
}

#pragma mark - Static methods

//在keyWindow里面添加popupPickerView
//采用默认的动画效果,dataSourceArray的格式为：其元素为数组，该数组中的元素全部为字符串
//preSelectTitles:预选中title数组
+ (void)showPopupPickerViewWithDelegate:(id<PopupPickerViewDelegate>)delegate andDataSourceArray:(NSArray *)dataSourceArray preSelectTitles:(NSArray *)preSelectTitles {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    popupPickerView = [PopupPickerView getViewFromNib];
    popupPickerView.pickerViewDataSource = dataSourceArray;
    popupPickerView.preSelectTitles = preSelectTitles;
    popupPickerView.delegate = delegate;
    popupPickerView.frame = keyWindow.bounds;
    [keyWindow addSubview:popupPickerView];
    
    [popupPickerView show];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
