//
//  MTProductListCell.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTProductListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MTProductListCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UIImageView *productSelectView;
@property (nonatomic,strong) MTProductListModel *listModel;
@end

NS_ASSUME_NONNULL_END
