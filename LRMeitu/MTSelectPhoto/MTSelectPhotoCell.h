//
//  MTSelectPhotoCell.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UICollectionViewCellDegate <NSObject>

-(void)deleteImageWithBbuttontag:(NSInteger)tag;

@end
@interface MTSelectPhotoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) id<UICollectionViewCellDegate>delegate;
@end

NS_ASSUME_NONNULL_END
