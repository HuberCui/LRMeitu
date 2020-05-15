//
//  MTSelectPhotoStyleCollectView.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTStyleModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol MTSelectPhotoStyleCollectViewDelegate <NSObject>
-(void)changeSelectStyleModel:(MTStyleModel *)selectModel;
@end
@interface MTSelectPhotoStyleCollectView : UIView
@property (nonatomic,weak) id<MTSelectPhotoStyleCollectViewDelegate> delegate;

@property (nonatomic,strong) NSMutableArray *styleArray;
@property (nonatomic,strong) MTStyleModel *styleModel;
-(instancetype)initWithFrame:(CGRect)frame styleArray:(NSMutableArray *)styleArray styleModel:(MTStyleModel *)styleModel;
@end

NS_ASSUME_NONNULL_END
