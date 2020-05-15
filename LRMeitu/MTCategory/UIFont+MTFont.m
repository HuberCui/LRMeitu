//
//  UIFont+MTFont.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "UIFont+MTFont.h"

@implementation UIFont (MTFont)
+ (UIFont *)mt_fontOfSize:(CGFloat)size
{
    NSString *name = @"PingFangSC-Regular";
    UIFont *font = [UIFont fontWithName:name size:size];
    return font ?: [UIFont systemFontOfSize:size];
}

+ (UIFont *)mt_mediumFontOfSize:(CGFloat)size
{
    NSString *name = @"PingFangSC-Medium";
    UIFont *font = [UIFont fontWithName:name size:size];
    return font ?: [UIFont systemFontOfSize:size];
}

+ (UIFont *)mt_boldFontOfSize:(CGFloat)size
{
    NSString *name = @"PingFangSC-Semibold";
    UIFont *font = [UIFont fontWithName:name size:size];
    return font ?: [UIFont systemFontOfSize:size];
}

+ (UIFont *)mt_lightFontOfSize:(CGFloat)size
{
    NSString *name = @"PingFangSC-Light";
    UIFont *font = [UIFont fontWithName:name size:size];
    return font ?: [UIFont systemFontOfSize:size];
}
@end
