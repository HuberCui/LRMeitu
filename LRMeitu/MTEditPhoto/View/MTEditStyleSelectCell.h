//
//  MTEditStyleSelectCell.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/3/1.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTEditStyleSelectModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MTEditStyleSelectCell : UICollectionViewCell
@property (nonatomic,strong) UILabel *lab;

@property (nonatomic,strong) MTEditStyleSelectModel *styleModel;
@end

NS_ASSUME_NONNULL_END
