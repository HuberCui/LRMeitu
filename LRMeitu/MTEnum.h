//
//  MTEnum.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/28.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#ifndef MTEnum_h
#define MTEnum_h
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UIFont+MTFont.h"
#import "UIColor+MTColor.h"
#import "UIView+MTView.h"
#import <Masonry.h>
typedef NS_ENUM (NSUInteger,MTGridStyle){
    MTGridOne,
    MTGridLOneROne,
    MTGridLOneRTwo,
    MTGridLTwoRTwo,
    MTGridLTwoRThree,
    MTGridLThreeRThree,
};

typedef NS_ENUM (NSUInteger,MTEditStyle){
    MTEditEmotionStyle,//贴图
    MTEditTextStyle,//文字
    MTEditEdgesStyle,//边框
    MTEditBoderStyle//轮廓
};
typedef NS_ENUM(NSInteger,FromBoderOrPro) {
    FromBoder,
    FromProduct
};
#endif /* MTEnum_h */
