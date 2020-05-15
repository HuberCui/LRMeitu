//
//  UIColor+MTColor.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "UIColor+MTColor.h"


@implementation UIColor (MTColor)
- (UIImage *)mt_image
{
    //  宽高 1.0只要有值就够了
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    //  在这个范围内开启一段上下文
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //  在这段上下文中获取到颜色UIColor
    CGContextSetFillColorWithColor(context, self.CGColor);
    
    //  用这个颜色填充这个上下文
    CGContextFillRect(context, rect);
    
    //  从这段上下文中获取Image属性
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIColor *)mt_getColorWithEAEAEA{
    return [self mt_colorWithHexString:@"#EAEAEA"];
}

+ (UIColor *)mt_getColorWithF2F3F5{
    return [self mt_colorWithHexString:@"#F2F3F5"];
}

+ (UIColor *)mt_getColorWith999999{
    return [self mt_colorWithHexString:@"#999999"];
}

+ (UIColor *)mt_getColorWith333333{
    return [self mt_colorWithHexString:@"#333333"];
}

+ (UIColor *)mt_getColorWith666666{
    return [self mt_colorWithHexString:@"#666666"];
}

+ (UIColor *)mt_getColorWith2089EB{
    return [self mt_colorWithHexString:@"#2089EB"];
}

+ (UIColor *)mt_getColorWithDCDCDC{
    return [self mt_colorWithHexString:@"#DCDCDC"];
}

+ (UIColor *)mt_colorWithHexString:(NSString *)color
{
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
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
    
}
@end
