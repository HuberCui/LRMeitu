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
@property (strong, nonatomic)  UIImage *showImage;
@property (weak, nonatomic) id<UICollectionViewCellDegate>delegate;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *selectImageView;
@property (nonatomic,strong) UIButton *deleteBtn;
@end

NS_ASSUME_NONNULL_END
