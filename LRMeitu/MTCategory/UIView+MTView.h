//
//  UIView+MTView.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MTView)

@property (nonatomic, readonly, class) UINib *mt_nib;
@property (nonatomic, readonly, class) __kindof UIView *mt_nibView;

@property (nonatomic, assign) CGFloat mt_x;
@property (nonatomic, assign) CGFloat mt_y;

@property (assign, nonatomic) CGFloat mt_maxX;
@property (assign, nonatomic) CGFloat mt_maxY;

@property (assign, nonatomic) CGFloat mt_height;
@property (assign, nonatomic) CGFloat mt_width;

@property (assign, nonatomic) CGFloat mt_centerX;
@property (assign, nonatomic) CGFloat mt_centerY;

@property (assign, nonatomic) CGPoint mt_origin;
@property (assign, nonatomic) CGSize mt_size;

@property (readonly) UIImage *mt_image;

@property (readonly) UIViewController *mt_viewController;

@property (nonatomic, assign) IBInspectable CGFloat mt_cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat mt_borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *mt_borderColor;

/**
 添加描边

 @param width 描边宽度
 @param color 描边颜色
 */
- (void)mt_borderWithWidth:(CGFloat)width
                     color:(UIColor *)color;

/**
 按高度一般倒圆角
 */
- (void)mt_filletWithHalfHeight;

/**
 按宽度一般倒圆角
 */
- (void)mt_filletWithHalfWidth;

/**
 根据半径倒圆角

 @param radius 半径
 */
- (void)mt_filletWithRadius:(CGFloat)radius;

/**
 根据半径倒指定角的圆角

 @param corners 指定角落
 @param radius 半径
 */
- (void)mt_filletWithCorners:(UIRectCorner)corners
                      radius:(CGFloat)radius;

/**
 设置阴影

 @param color 阴影颜色
 @param offset 偏移
 @param opacity 透明度
 @param shadowRadius 阴影半径
 @param cornerRadius 圆角半径
 */
- (void)mt_setShadowWithColor:(UIColor *)color
                       offset:(CGSize)offset
                      opacity:(CGFloat)opacity
                 shadowRadius:(CGFloat)shadowRadius
                 cornerRadius:(CGFloat)cornerRadius;

/**
 为view设置常用的阴影
 */
- (void)mt_setShadow;


/// 一个针对Sketch阴影的设置方法
/// @param color 对应Sketch的Hex颜色
/// @param opacity 对应Sketch的Alpha
/// @param offset 对应Sketch的X，Y
/// @param spread 对应Sketch的扩展
/// @param shadowRadius 对应Sketch的模糊
/// @param cornerRadius 对应Sketch的圆角半径
- (void)mt_setSketchShadowWithColor:(UIColor *)color
                            opacity:(CGFloat)opacity
                             offset:(CGSize)offset
                             spread:(CGFloat)spread
                       shadowRadius:(CGFloat)shadowRadius
                       cornerRadius:(CGFloat)cornerRadius;

- (void)mt_addSubviews:(NSArray *)subviews;
- (void)mt_removeSubviews;
- (void)mt_removeSublayers;


/// 画水平虚线
/// @param length 虚线长度
/// @param spacing 虚线间距
/// @param color 颜色
- (void)setHorizontalDashWithLength:(CGFloat)length
                            spacing:(CGFloat)spacing
                              color:(UIColor *)color;

/// 画竖直虚线
/// @param length 虚线长度
/// @param spacing 虚线间距
/// @param color 颜色
- (void)setVerticalDashWithLength:(CGFloat)length
                          spacing:(CGFloat)spacing
                            color:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
