//
//  UIColor+WSK.m
//  CTCockpit
//
//  Created by 何 振东 on 12-9-26.
//
//

#import "UIColor+Addition.h"

@implementation UIColor (Addition)

+ (UIColor *)red:(int)red green:(int)green blue:(int)blue alpha:(CGFloat)alpha {
    UIColor *color = [UIColor colorWithRed:red / 255.f green:green / 255.f blue:blue / 255.f alpha:alpha];
    return color;
}

+ (NSArray *)convertColorToRBG:(UIColor *)uicolor {
    CGColorRef color = [uicolor CGColor];
    int numComponents = (int)CGColorGetNumberOfComponents(color);
    NSArray *array = nil;

    if (numComponents == 4) {
        int rValue, gValue, bValue;
        const CGFloat *components = CGColorGetComponents(color);
        rValue = (int) (components[0] * 255);
        gValue = (int) (components[1] * 255);
        bValue = (int) (components[2] * 255);

        array = [NSArray arrayWithObjects:[NSNumber numberWithInt:rValue], [NSNumber numberWithInt:gValue], [NSNumber numberWithInt:bValue], nil];
    }

    return array;
}

UIColor *UIColorFromHex(NSInteger colorInHex) {
    // colorInHex should be value like 0xFFFFFF
    return [UIColor colorWithRed:((float) ((colorInHex & 0xFF0000) >> 16)) / 0xFF
                           green:((float) ((colorInHex & 0xFF00) >> 8)) / 0xFF
                            blue:((float) (colorInHex & 0xFF)) / 0xFF
                           alpha:1.0];
}

+ (UIColor *)convertHexColorToUIColor:(NSInteger)hexColor {
    return [UIColor colorWithRed:((float) ((hexColor & 0xFF0000) >> 16)) / 0xFF
                           green:((float) ((hexColor & 0xFF00) >> 8)) / 0xFF
                            blue:((float) (hexColor & 0xFF)) / 0xFF
                           alpha:1.0];
}

+ (UIColor *)getColorRGB:(NSString *)color {
    return [self getColorRGB:color withAlpha:1.0];
}

+ (UIColor *)getColorRGB:(NSString *)color withAlpha:(CGFloat)alpha {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }

    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];

    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;

    //r
    NSString *rString = [cString substringWithRange:range];

    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];

    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];

    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];


}


@end
