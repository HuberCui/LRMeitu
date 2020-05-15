//
//  UIColor+MTColor.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (MTColor)
@property (readonly) UIImage *mt_image;

+ (UIColor *)mt_getColorWithEAEAEA;

+ (UIColor *)mt_getColorWithF2F3F5;

+ (UIColor *)mt_getColorWith333333;

+ (UIColor *)mt_getColorWith666666;

+ (UIColor *)mt_getColorWith2089EB;

+ (UIColor *)mt_getColorWithDCDCDC;

+ (UIColor *)mt_getColorWith999999;

+ (UIColor *)mt_colorWithHexString:(NSString *)color;

@end

NS_ASSUME_NONNULL_END
