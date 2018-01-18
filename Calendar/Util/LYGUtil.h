//
//  LYGUtil.h
//  LYG
//
//  Created by 李洋 on 15/7/28.
//  Copyright (c) 2015年 李洋. All rights reserved.
//


@interface LYGUtil : NSObject

#pragma mark - NSString (Verify)

//验证电话号码是否有效
+ (BOOL)isPhoneNumberValidate:(NSString *)phoneNumber;

//验证邮箱地址是否有效
+ (BOOL)isEmailAddressValidate:(NSString *)emailAddress;

//验证身份证号是否有效
+ (BOOL)isIdentityCardValidate:(NSString *)identityCard;

#pragma mark - NSString (md5)

//string的md5
+ (NSString *)md5WithString:(NSString *)string;

#pragma mark - NSString (NSDate)

//根据dateFormat，返回date对应的string
+ (NSString *)stringWithDate:(NSDate *)date andDateFormat:(NSString *)dateFormat;

#pragma mark - UIView (CornerRadius)

//设置view的圆角半径
+ (void)setRoundedCornerRadius:(float)radius forView:(UIView *)view;

#pragma mark - UIView (NSLayoutConstraint)

//subview添加到superView中，bounds完全相同
+ (void)addConstraintsForSubview:(UIView *)subview addedToSuperView:(UIView *)superView;

#pragma mark - UIView (UIBarButtonItem)

//创建barButtonItem
+ (UIBarButtonItem *)barButtonItemWithWithImageNamed:(NSString *)imageName hightlightedImageNamed:(NSString *)h_imageName target:(id)target andSelector:(SEL)sel;

//设置BarButtonItem的默认标题文字属性
+ (void)setDefaultTitleTextAttributesForBarButtonItem:(UIBarButtonItem *)barButtonItem;

//找到所有的barButtonItems
+ (NSMutableArray *)barButtonItemsInNavWithViewController:(UIViewController *)viewController;

#pragma mark - UIView (UIImage)

//通过一个视图里面的内容创建图片
- (UIImage *)createImageWithView:(UIView *)view;

@end
