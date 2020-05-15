//
//  MTSelectPhotoCollectView.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTStyleModel.h"
NS_ASSUME_NONNULL_BEGIN


@interface MTSelectPhotoCollectView : UIView

@property (nonatomic,strong) MTStyleModel *styleModel;

-(instancetype)initWithFrame:(CGRect)frame styleModel:(MTStyleModel *)styleModel;
@end

NS_ASSUME_NONNULL_END
