//
//  MTProductListViewController.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MTProductListViewControllerDelegate <NSObject>

- (void)selectProductImage:(NSMutableArray *)selectModelProduct SelectImage:(NSMutableArray *)selectImage;
- (void)selectEdge:(NSMutableArray *)selectEdge;
@end
@interface MTProductListViewController : UIViewController
@property (nonatomic,weak) id<MTProductListViewControllerDelegate> delegate;

@property (nonatomic,assign) FromBoderOrPro fromboder_pro;

@end

NS_ASSUME_NONNULL_END
