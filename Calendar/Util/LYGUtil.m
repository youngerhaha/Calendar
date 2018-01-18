//
//  LYGUtil.m
//  LYG
//
//  Created by 李洋 on 15/7/28.
//  Copyright (c) 2015年 李洋. All rights reserved.
//

#import "LYGUtil.h"
#import <CommonCrypto/CommonDigest.h>

@implementation LYGUtil

#pragma mark - NSString (Verify)

//验证电话号码是否有效
+ (BOOL)isPhoneNumberValidate:(NSString *)phoneNumber {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181(增加)
     22         */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:phoneNumber] == YES)
        || ([regextestcm evaluateWithObject:phoneNumber] == YES)
        || ([regextestct evaluateWithObject:phoneNumber] == YES)
        || ([regextestcu evaluateWithObject:phoneNumber] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

//验证邮箱地址是否有效
+ (BOOL)isEmailAddressValidate:(NSString *)emailAddress {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailAddress];
}

//验证身份证号是否有效
+ (BOOL)isIdentityCardValidate:(NSString *)identityCard {
    if (identityCard.length <= 0) {
        return NO;
    }
    
    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [identityCardPredicate evaluateWithObject:identityCard];
}

#pragma mark - NSString (md5)

+ (NSString *)md5WithString:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

#pragma mark - NSString (NSDate)

//根据dateFormat，返回date对应的string
//例如：dateFormat,"yyyy-MM-dd"
+ (NSString *)stringWithDate:(NSDate *)date andDateFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return [dateFormatter stringFromDate:date];
}

#pragma mark - UIView (CornerRadius)

+ (void)setRoundedCornerRadius:(float)cornerRadius forView:(UIView *)view {
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YES;
}

#pragma mark - UIView (NSLayoutConstraint)

//subview添加到superView中，bounds完全相同
+ (void)addConstraintsForSubview:(UIView *)subview addedToSuperView:(UIView *)superView {
    [superView addSubview:subview];

    NSLayoutConstraint *cs1 = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *cs2 = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *cs3 = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *cs4 = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [superView addConstraints:@[cs1,cs2,cs3,cs4]];
}

#pragma mark - UIView (UIBarButtonItem)

+ (UIBarButtonItem *)barButtonItemWithWithImageNamed:(NSString *)imageName hightlightedImageNamed:(NSString *)h_imageName target:(id)target andSelector:(SEL)sel {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:h_imageName] forState:UIControlStateHighlighted];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return barButtonItem;
}

+ (void)setDefaultTitleTextAttributesForBarButtonItem:(UIBarButtonItem *)barButtonItem {
    //设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //文字颜色
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //文字大小
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    
    //文字属性2
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    [barButtonItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [barButtonItem setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    [barButtonItem setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
    //设置barButtonItem的tintColor
    barButtonItem.tintColor = [UIColor whiteColor];
}

+ (NSMutableArray *)barButtonItemsInNavWithViewController:(UIViewController *)viewController {
    NSMutableArray *barButtonItems = [NSMutableArray array];
    if (viewController.navigationItem.leftBarButtonItems.count>0) {
        [barButtonItems addObjectsFromArray:viewController.navigationItem.leftBarButtonItems];
    }
    if (viewController.navigationItem.rightBarButtonItems.count>0) {
        [barButtonItems addObjectsFromArray:viewController.navigationItem.rightBarButtonItems];
    }
    return barButtonItems;
}

#pragma mark - UIView (UIImage)

//通过一个视图里面的内容创建图片
- (UIImage *)createImageWithView:(UIView *)view {
    //创建一块画布
    UIGraphicsBeginImageContext(view.frame.size);
    //把view的内容渲染到画布中
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //把画布中的图片取出来
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //结束渲染
    UIGraphicsEndImageContext();
    return image;
}


@end
