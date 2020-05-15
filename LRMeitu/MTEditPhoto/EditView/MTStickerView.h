//
//  MTStickerView.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/3/3.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTStickerItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface MTStickerView : UIView
/** 取消当前激活的贴图 */
+ (void)LFStickerViewDeactivated;

/** 激活选中的贴图 */
- (void)activeSelectStickerView;
/** 删除选中贴图 */
- (void)removeSelectStickerView;

/** 获取选中贴图的内容 */
- (MTStickerItem *)getSelectStickerItem;

/** 更改选中贴图内容 */
- (void)changeSelectStickerItem:(MTStickerItem *)item;

/** 创建贴图 */
- (void)createSticker:(MTStickerItem *)item;

/** 最小缩放率 默认0.2 */
@property (nonatomic, assign) CGFloat minScale;
/** 最大缩放率 默认3.0 */
@property (nonatomic, assign) CGFloat maxScale;
/** 贴图数量 */
@property (nonatomic, readonly) NSUInteger count;
/** 显示界面的缩放率，例如在UIScrollView上显示，scrollView放大了5倍，movingView的视图控件会显得较大，这个属性是适配当前屏幕的比例调整控件大小 */
@property (nonatomic, assign) CGFloat screenScale;

/** 是否启用（移动或点击） */
@property (nonatomic, readonly, getter=isEnable) BOOL enable;
/** 点击回调视图 */
@property (nonatomic, copy) void(^tapEnded)(MTStickerItem *item, BOOL isActive);
@property (nonatomic, copy) BOOL(^moveCenter)(CGRect rect);

@end

NS_ASSUME_NONNULL_END
