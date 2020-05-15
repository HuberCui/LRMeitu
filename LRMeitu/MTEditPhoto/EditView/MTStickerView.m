//
//  MTStickerView.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/3/3.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTStickerView.h"
#import "MTStickerMoveView.h"

@interface MTStickerView()
@property (nonatomic,strong) MTStickerMoveView *selectMovingView;
@property (nonatomic, assign, getter=isHitTestSubView) BOOL hitTestSubView;
@end
@implementation MTStickerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       self.backgroundColor = [UIColor clearColor];
          self.clipsToBounds = YES;
        _screenScale = 1.f;
          _minScale = .2f;
          _maxScale = 3.f;
      
    }
    return self;
}
#pragma mark - 解除响应事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    self.hitTestSubView = [view isDescendantOfView:self];
    return (view == self ? nil : view);
}

- (BOOL)isEnable
{
    return self.isHitTestSubView && self.selectMovingView.isActive;
}
- (void)setTapEnded:(void (^)(MTStickerItem *, BOOL))tapEnded
{
    _tapEnded = tapEnded;
    for (MTStickerMoveView *subView in self.subviews) {
        if ([subView isKindOfClass:[MTStickerMoveView class]]) {
            if (tapEnded) {
                __weak typeof(self) weakSelf = self;
                [subView setTapEnded:^(MTStickerMoveView *view) {
                    weakSelf.selectMovingView = view;
                    weakSelf.tapEnded(view.item, view.isActive);
                }];
            } else {
                [subView setTapEnded:nil];
            }
        }
    }
}

- (void)setMoveCenter:(BOOL (^)(CGRect))moveCenter
{
    _moveCenter = moveCenter;
    for (MTStickerMoveView *subView in self.subviews) {
        if ([subView isKindOfClass:[MTStickerMoveView class]]) {
            if (moveCenter) {
                __weak typeof(self) weakSelf = self;
                [subView setMoveCenter:^BOOL (CGRect rect) {
                    return weakSelf.moveCenter(rect);
                }];
            } else {
                [subView setMoveCenter:nil];
            }
        }
    }
}
/** 激活选中的贴图 */
- (void)activeSelectStickerView
{
    [MTStickerMoveView setActiveEmoticonView:self.selectMovingView];
}
/** 删除选中贴图 */
- (void)removeSelectStickerView
{
    [self.selectMovingView removeFromSuperview];
}
/** 获取选中贴图的内容 */
- (MTStickerItem *)getSelectStickerItem
{
    return self.selectMovingView.item;
}
/** 更改选中贴图内容 */
- (void)changeSelectStickerItem:(MTStickerItem *)item
{
    self.selectMovingView.item = item;
}


+ (void)LFStickerViewDeactivated
{
    [MTStickerMoveView setActiveEmoticonView:nil];
}
/** 贴图数量 */
- (NSUInteger)count
{
    return self.subviews.count;
}
- (void)setScreenScale:(CGFloat)screenScale
{
    if (screenScale > 0) {
        _screenScale = screenScale;
        for (MTStickerMoveView *subView in self.subviews) {
            if ([subView isKindOfClass:[MTStickerMoveView class]]) {
                subView.screenScale = screenScale;
            }
        }
    }
}
/** 创建贴图 */
- (void)createSticker:(MTStickerItem *)item{
      MTStickerMoveView *movingView = [self createBaseMovingView:item active:YES];
        CGFloat ratio = 0.5;
        CGFloat scale = MIN( (ratio * [UIScreen mainScreen].bounds.size.width) / movingView.view.frame.size.width, (ratio * [UIScreen mainScreen].bounds.size.height) / movingView.view.frame.size.height);
        [movingView setScale:1.0];
   //   [movingView setScale:scale/self.screenScale];
        NSLog(@"minScale:%f, maxScale:%f, scale:%f", movingView.minScale, movingView.maxScale, movingView.scale);
        
        self.selectMovingView = movingView;
}
/** 创建可移动视图 */
- (MTStickerMoveView *)createBaseMovingView:(MTStickerItem *)item active:(BOOL)active
{
    
    MTStickerMoveView *movingView = [[MTStickerMoveView alloc] initWithItem:item];
    /** 屏幕中心 */
    movingView.center = self.center;
    
    [self updateMovingView:movingView];
    
    [self addSubview:movingView];
    
    if (active) {
        [MTStickerMoveView setActiveEmoticonView:movingView];
    }
    
    
    __weak typeof(self) weakSelf = self;
    if (self.tapEnded) {
        [movingView setTapEnded:^(MTStickerMoveView * _Nonnull view) {
            weakSelf.selectMovingView = view;
            weakSelf.tapEnded(view.item, view.isActive);
        }];
    }
    
    if (self.moveCenter) {
        [movingView setMoveCenter:^BOOL (CGRect rect) {
            return weakSelf.moveCenter(rect);
        }];
    }
    
    return movingView;
}


- (void)updateMovingView:(MTStickerMoveView *)movingView
{
    /** 最小缩放率 */
    movingView.minScale = self.minScale;
    /** 最大缩放率 */
    movingView.maxScale = self.maxScale;
    /** 屏幕缩放率 */
    movingView.screenScale = self.screenScale;
}
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//   UIView *view = [super hitTest:point withEvent:event];
//    return self;
//}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"---");
//}
@end
