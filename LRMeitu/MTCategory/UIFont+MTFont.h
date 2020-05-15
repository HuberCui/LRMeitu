//
//  UIFont+MTFont.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (MTFont)
+ (UIFont *)mt_lightFontOfSize:(CGFloat)size;
+ (UIFont *)mt_boldFontOfSize:(CGFloat)size;
+ (UIFont *)mt_mediumFontOfSize:(CGFloat)size;
+ (UIFont *)mt_fontOfSize:(CGFloat)size;
@end

NS_ASSUME_NONNULL_END
