//
//  MTConfigFallWaterLayout.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/28.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTEnum.h"
#import <CHTCollectionViewWaterfallLayout.h>
NS_ASSUME_NONNULL_BEGIN

@interface MTFallWaterLayoutConfig : NSObject

//拼图页面的布局

-(instancetype)initWithMTGridStyle:(MTGridStyle)gridStyle CollectionViewSize:(CGSize)collectionViewSize;
@property (nonatomic,strong) CHTCollectionViewWaterfallLayout *waterflowlayout;
@property (nonatomic,strong) NSMutableArray<NSValue *> *sizeArray;

@end

NS_ASSUME_NONNULL_END
