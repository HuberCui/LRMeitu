//
//  UIView+MTView.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "UIView+MTView.h"


@implementation UIView (MTView)
+ (UINib *)mt_nib
{
    return [UINib nibWithNibName:NSStringFromClass(self) bundle:[NSBundle bundleForClass:self]];
}

+ (UIView *)mt_nibView
{
    return [[NSBundle bundleForClass:self] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (CGFloat)mt_x
{
    return CGRectGetMinX(self.frame);
}

- (void)setMt_x:(CGFloat)mt_x
{
    CGRect frame = self.frame;
    frame.origin.x = mt_x;
    self.frame = frame;
}

- (CGFloat)mt_y
{
    return CGRectGetMinY(self.frame);
}

- (void)setMt_y:(CGFloat)mt_y
{
    CGRect frame = self.frame;
    frame.origin.y = mt_y;
    self.frame = frame;
}

- (CGFloat)mt_maxX
{
    return CGRectGetMaxX(self.frame);
}

- (void)setMt_maxX:(CGFloat)mt_maxX
{
    CGRect frame = self.frame;
    frame.origin.x = mt_maxX - CGRectGetWidth(self.frame);
    self.frame = frame;
}

- (CGFloat)mt_maxY
{
    return CGRectGetMaxY(self.frame);
}

- (void)setMt_maxY:(CGFloat)mt_maxY
{
    CGRect frame = self.frame;
    frame.origin.y = mt_maxY - CGRectGetHeight(self.frame);
    self.frame = frame;
}

- (CGFloat)mt_width
{
    return CGRectGetWidth(self.frame);
}

- (void)setMt_width:(CGFloat)mt_width
{
    CGRect frame = self.frame;
    frame.size.width = mt_width;
    self.frame = frame;
}

- (CGFloat)mt_height
{
    return CGRectGetHeight(self.frame);
}

- (void)setMt_height:(CGFloat)mt_height
{
    CGRect frame = self.frame;
    frame.size.height = mt_height;
    self.frame = frame;
}

- (CGFloat)mt_centerX
{
    return self.center.x;
}

- (void)setMt_centerX:(CGFloat)mt_centerX
{
    CGPoint point = self.center;
    point.x = mt_centerX;
    self.center = point;
}


- (CGFloat)mt_centerY
{
    return self.center.y;
}

- (void)setMt_centerY:(CGFloat)mt_centerY
{
    CGPoint point = self.center;
    point.y = mt_centerY;
    self.center = point;
}

- (CGPoint)mt_origin
{
    return self.frame.origin;
}

- (void)setMt_origin:(CGPoint)mt_origin
{
    CGRect frame = self.frame;
    frame.origin = mt_origin;
    self.frame = frame;
}

- (CGSize)mt_size
{
    return self.frame.size;
}

- (void)setMt_size:(CGSize)mt_size
{
    CGRect frame = self.frame;
    frame.size = mt_size;
    self.frame = frame;
}

- (UIImage *)mt_image
{
    CGSize size = self.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIViewController *)mt_viewController
{
    for (UIView *view = self; view; view = view.superview) {
        __kindof UIResponder *nextResponder = view.nextResponder;
        if ([nextResponder isKindOfClass:UIViewController.class]) {
            return nextResponder;
        }
    }
    return nil;
}

- (void)setMt_borderWidth:(CGFloat)mt_borderWidth
{
    self.layer.borderWidth = mt_borderWidth;
}

- (CGFloat)mt_borderWidth
{
    return self.layer.borderWidth;
}

- (UIColor *)mt_borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setMt_borderColor:(UIColor *)mt_borderColor
{
    self.layer.borderColor = mt_borderColor.CGColor;
}

- (void)setMt_cornerRadius:(CGFloat)mt_cornerRadius
{
    self.layer.cornerRadius = mt_cornerRadius;
}

- (CGFloat)mt_cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)mt_borderWithWidth:(CGFloat)width
                     color:(UIColor *)color
{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

- (void)mt_filletWithHalfHeight
{
    [self mt_filletWithRadius:self.mt_height/2.0];
}

- (void)mt_filletWithHalfWidth
{
    [self mt_filletWithRadius:self.mt_width/2.0];
}

- (void)mt_filletWithRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)mt_filletWithCorners:(UIRectCorner)corners
                      radius:(CGFloat)radius
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    self.layer.mask = layer;
}

- (void)mt_addSubviews:(NSArray *)subviews
{
    for (UIView *view in subviews) {
        [self addSubview:view];
    }
}

- (void)mt_removeSubviews
{
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

- (void)mt_removeSublayers
{
    while (self.layer.sublayers.count) {
        [self.layer.sublayers.lastObject removeFromSuperlayer];
    }
}

- (void)mt_setShadowWithColor:(UIColor *)color
                       offset:(CGSize)offset
                      opacity:(CGFloat)opacity
                 shadowRadius:(CGFloat)shadowRadius
                 cornerRadius:(CGFloat)cornerRadius
{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = shadowRadius;
    self.layer.cornerRadius = cornerRadius;
}

- (void)mt_setShadow
{
    [self mt_setShadowWithColor:HexColor(052A60) offset:CGSizeMake(0, 2) opacity:0.08 shadowRadius:5 cornerRadius:8];
}

- (void)mt_setSketchShadowWithColor:(UIColor *)color
                            opacity:(CGFloat)opacity
                             offset:(CGSize)offset
                             spread:(CGFloat)spread
                       shadowRadius:(CGFloat)shadowRadius
                       cornerRadius:(CGFloat)cornerRadius
{
    CALayer *layer = self.layer;
    layer.shadowOffset = offset;
    layer.shadowRadius = shadowRadius * 0.5;
    layer.shadowColor = color.CGColor;
    layer.shadowOpacity = opacity;
    
    CGRect rect = CGRectInset(layer.bounds, -spread, -spread);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    layer.shadowPath = path.CGPath;
}


- (void)setHorizontalDashWithLength:(CGFloat)length
                            spacing:(CGFloat)spacing
                              color:(UIColor *)color
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.bounds = self.bounds;
    shapeLayer.position = CGPointMake(self.mt_width/2.0, self.mt_height);
    shapeLayer.fillColor = UIColor.clearColor.CGColor;
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.lineWidth = self.mt_height;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineDashPattern = @[@(length), @(spacing)];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, self.mt_width, 0);
    shapeLayer.path = path;
    CGPathRelease(path);
    [self.layer addSublayer:shapeLayer];
}

- (void)setVerticalDashWithLength:(CGFloat)length
                          spacing:(CGFloat)spacing
                            color:(UIColor *)color
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.bounds = self.bounds;
    shapeLayer.position = CGPointMake(self.mt_width, self.mt_height/2.0);
    shapeLayer.fillColor = UIColor.clearColor.CGColor;
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.lineWidth = self.mt_width;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineDashPattern = @[@(length), @(spacing)];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 0, self.mt_height);
    shapeLayer.path = path;
    CGPathRelease(path);
    
    [self.layer addSublayer:shapeLayer];
    
    
}
@end
