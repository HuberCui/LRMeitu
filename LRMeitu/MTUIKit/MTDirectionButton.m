//
//  YTDirectionButton.m
//  Food
//
//  Created by Xuebin Cui on 2020/F/13.
//  Copyright © 2020 宋链. All rights reserved.
//

#import "MTDirectionButton.h"

@interface MTDirectionButton()
/** 图标类型 */
@property (nonatomic, assign) MTButtonEdgeInsetsStyle iconStyle;

@property (nonatomic, assign) CGFloat space;
@end
@implementation MTDirectionButton
-(instancetype)initWithStyle:(MTButtonEdgeInsetsStyle)style Space:(CGFloat)space{
    if (self = [super init]) {
        self.iconStyle = style;
        self.space = space;
       
    }
    return self;
}

+(instancetype)buttonWithType:(UIButtonType)buttonType Style:(MTButtonEdgeInsetsStyle)style Space:(CGFloat)space{
     MTDirectionButton *btn = [super buttonWithType:buttonType];
     btn.iconStyle = style;
     btn.space = space;
     return btn;
}


-(void)layoutSubviews{
  [super layoutSubviews];
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
 
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
 
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
 
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (self.iconStyle) {
        case MTButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-self.space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-self.space/2.0, 0);
        }
            break;
        case MTButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -self.space/2.0, 0, self.space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, self.space/2.0, 0, -self.space/2.0);
        }
            break;
        case MTButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-self.space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-self.space/2.0, -imageWith, 0, 0);
        }
            break;
        case MTButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+self.space/2.0, 0, -labelWidth-self.space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-self.space/2.0, 0, imageWith+self.space/2.0);
        }
            break;
        default:
            break;
    }
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
    
}
@end

