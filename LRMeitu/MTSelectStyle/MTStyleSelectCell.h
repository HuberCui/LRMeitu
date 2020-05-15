//
//  MTStyleSelectCell.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTStyleModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MTStyleSelectCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *styleImageView;
@property (nonatomic,strong) MTStyleModel *styleModel;
@end

NS_ASSUME_NONNULL_END
