//
//  MTEditEdgesViewCell.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/3/1.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTProductListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MTEditEdgesViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *edgeImageView;
@property (nonatomic,strong) MTProductListModel *productModel;
@end

NS_ASSUME_NONNULL_END
