//
//  MTEditColorsCell.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/3/2.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTEditColorModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MTEditColorsCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *bigView;
@property (weak, nonatomic) IBOutlet UIView *smallView;
@property (nonatomic,strong) MTEditColorModel *colorModel;
@end

NS_ASSUME_NONNULL_END
