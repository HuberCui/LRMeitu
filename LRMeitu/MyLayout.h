//
//  MyLayout.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/28.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 自定义瀑布流布局
 */
@interface MyLayout : UICollectionViewFlowLayout

/**
 瀑布流布局方法
 
 @param itemWidth item 的宽度
 @param itemHeightArray item 的高度数组
 */
- (void)flowLayoutWithItemWidth:(CGFloat)itemWidth itemHeightArray:(NSArray<NSNumber *> *)itemHeightArray;

@end


