//
//  MTConfigFallWaterLayout.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/28.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTFallWaterLayoutConfig.h"
@interface MTFallWaterLayoutConfig ()
@property (nonatomic,assign) MTGridStyle gridStyle;

@end
@implementation MTFallWaterLayoutConfig

-(instancetype)initWithMTGridStyle:(MTGridStyle)gridStyle CollectionViewSize:(CGSize)collectionViewSize{
    if (self = [super init]) {
        self.gridStyle = gridStyle;
        
        //配置瀑布流
        self.waterflowlayout =  [self configEditLayoutWithMTGridStyle:gridStyle];
        self.sizeArray = [self configEditCollectionViewNumberOfItemsWithMTGridStyle:gridStyle CollectionViewSize:collectionViewSize FlowLayout:self.waterflowlayout];
        
    }
    return self;
}
-(NSMutableArray<NSValue *> *)configEditCollectionViewNumberOfItemsWithMTGridStyle:(MTGridStyle)gridStyle CollectionViewSize:(CGSize)viewSize FlowLayout:(CHTCollectionViewWaterfallLayout *)flowLayout{
    NSMutableArray *muarr = [NSMutableArray array];
    
   CGFloat oneItemHeight = viewSize.height-flowLayout.sectionInset.top-flowLayout.sectionInset.bottom;
      
    CGFloat twoItemWith = (viewSize.width-flowLayout.sectionInset.left-flowLayout.sectionInset.right-flowLayout.minimumColumnSpacing)/2;
    CGFloat twoItemHeight = (viewSize.height-flowLayout.sectionInset.top-flowLayout.sectionInset.bottom-flowLayout.minimumInteritemSpacing)/2;
    
    CGFloat threeItemHeight = (viewSize.height-flowLayout.sectionInset.top-flowLayout.sectionInset.bottom-2*flowLayout.minimumInteritemSpacing)/3;
    
    switch (gridStyle) {
         case MTGridOne:
            [muarr addObject:[NSValue valueWithCGSize:CGSizeMake(viewSize.width-flowLayout.sectionInset.left-flowLayout.sectionInset.right, oneItemHeight)]];
             break;
         case MTGridLOneROne:
         
            [muarr addObject:[NSValue valueWithCGSize:CGSizeMake(twoItemWith, oneItemHeight)]];
            [muarr addObject:[NSValue valueWithCGSize:CGSizeMake(twoItemWith, oneItemHeight)]];
             break;
         case MTGridLOneRTwo:
            [muarr addObject:[NSValue valueWithCGSize:CGSizeMake(twoItemWith, oneItemHeight)]];
            [muarr addObject:[NSValue valueWithCGSize:CGSizeMake(twoItemWith, twoItemHeight)]];
            [muarr addObject:[NSValue valueWithCGSize:CGSizeMake(twoItemWith, twoItemHeight)]];
             break;
         case MTGridLTwoRTwo:
            [muarr addObject:[NSValue valueWithCGSize:CGSizeMake(twoItemWith, twoItemHeight)]];
             [muarr addObject:[NSValue valueWithCGSize:CGSizeMake(twoItemWith, twoItemHeight)]];
             [muarr addObject:[NSValue valueWithCGSize:CGSizeMake(twoItemWith, twoItemHeight)]];
             [muarr addObject:[NSValue valueWithCGSize:CGSizeMake(twoItemWith, twoItemHeight)]];
             break;
         case MTGridLTwoRThree:
             [muarr addObject:[NSValue valueWithCGSize:CGSizeMake(twoItemWith, twoItemHeight)]];
             [muarr addObject:[NSValue valueWithCGSize:CGSizeMake(twoItemWith, threeItemHeight)]];
             [muarr addObject:[NSValue valueWithCGSize:CGSizeMake(twoItemWith, threeItemHeight)]];
             [muarr addObject:[NSValue valueWithCGSize:CGSizeMake(twoItemWith, twoItemHeight)]];
             [muarr addObject:[NSValue valueWithCGSize:CGSizeMake(twoItemWith, threeItemHeight)]];
             break;
         case MTGridLThreeRThree:
               [muarr addObject:[NSValue valueWithCGSize:CGSizeMake(twoItemWith, threeItemHeight)]];
              [muarr addObject:[NSValue valueWithCGSize:CGSizeMake(twoItemWith, threeItemHeight)]];
              [muarr addObject:[NSValue valueWithCGSize:CGSizeMake(twoItemWith, threeItemHeight)]];
              [muarr addObject:[NSValue valueWithCGSize:CGSizeMake(twoItemWith, threeItemHeight)]];
              [muarr addObject:[NSValue valueWithCGSize:CGSizeMake(twoItemWith, threeItemHeight)]];
              [muarr addObject:[NSValue valueWithCGSize:CGSizeMake(twoItemWith, threeItemHeight)]];
             break;
         default:
             break;
     }
    return muarr;
}
-(CHTCollectionViewWaterfallLayout *)configEditLayoutWithMTGridStyle:(MTGridStyle)gridStyle{
    
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    
    if (gridStyle == MTGridOne) {
         layout.columnCount = 1;
    }else{
         layout.columnCount = 2;
    }
   
    layout.minimumInteritemSpacing = 8;
    layout.minimumColumnSpacing = 8;
    layout.sectionInset = UIEdgeInsetsMake(14, 14, 14, 14);
    switch (gridStyle) {
        case MTGridOne:
            
            break;
        case MTGridLOneROne:
            
            break;
        case MTGridLOneRTwo:
            
            break;
        case MTGridLTwoRTwo:
            
            break;
        case MTGridLTwoRThree:
            
            break;
        case MTGridLThreeRThree:
            
            break;
        default:
            break;
    }
    
    return layout;
}

@end
