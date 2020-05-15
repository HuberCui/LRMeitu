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

-(void)selectProductImage:(NSMutableArray *)selectProduct;

@end
@interface MTProductListViewController : UIViewController
@property (nonatomic,weak) id<MTProductListViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
