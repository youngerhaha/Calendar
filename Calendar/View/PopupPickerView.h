//
//  PopupPickerView.h
//  Pengyouquan
//
//  Created by 李洋 on 15/6/30.
//  Copyright (c) 2015年 李洋. All rights reserved.
//

//PopupDatePicker显示和隐藏时是否有动画（默认是有动画，没有动画就注释掉）
#define PopupPickerViewAnimationOn

@class PopupPickerView;

@protocol PopupPickerViewDelegate <NSObject>

@required
- (void)popupPickerViewDidSelectItemTitles:(NSArray *)itemTitles;

@optional
//popupPickerView即将消失
- (void)popupPickerViewWillDismiss;

//popupPickerView已经消失
- (void)popupPickerViewDidDismiss;

@end

//在keyWindow中显示的自定义PickerView
@interface PopupPickerView : UIView

+ (instancetype)getViewFromNib;

//采用默认的动画效果,dataSourceArray的格式为：其元素为数组，该数组中的元素全部为字符串
//preSelectTitles:预选中title数组
+ (void)showPopupPickerViewWithDelegate:(id<PopupPickerViewDelegate>)delegate andDataSourceArray:(NSArray *)dataSourceArray preSelectTitles:(NSArray *)preSelectTitles;

//从keyWindow中移除PopupPickerView
+ (void)dismissPopupPickerView;

@end
