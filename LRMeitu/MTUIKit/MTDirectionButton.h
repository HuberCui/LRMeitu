//
//  YTDirectionButton.h
//  Food
//
//  Created by Xuebin Cui on 2020/F/13.
//  Copyright © 2020 宋链. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  方向
 */

typedef NS_ENUM(NSUInteger, MTButtonEdgeInsetsStyle) {
    MTButtonEdgeInsetsStyleTop, // image在上，label在下
    MTButtonEdgeInsetsStyleLeft, // image在左，label在右
    MTButtonEdgeInsetsStyleBottom, // image在下，label在上
    MTButtonEdgeInsetsStyleRight // image在右，label在左
};
@interface MTDirectionButton : UIButton

+(instancetype)buttonWithType:(UIButtonType)buttonType Style:(MTButtonEdgeInsetsStyle)style Space:(CGFloat)space;
-(instancetype)initWithStyle:(MTButtonEdgeInsetsStyle)style Space:(CGFloat)space;
@end
