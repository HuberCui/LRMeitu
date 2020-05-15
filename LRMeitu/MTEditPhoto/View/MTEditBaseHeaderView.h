//
//  MTEditBaseHeaderView.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/3/3.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MTEditEmotionViewDelegate <NSObject>
-(void)addOneEmotionWithImage:(UIImage *)emotion;
-(void)addMoreProductPicture;

@end
@protocol MTEditTextViewDelegate <NSObject>
-(void)changeSelectTextcolorWithColor:(NSString *)color;
@end

@protocol MTEditEdgesViewDelegate <NSObject>
-(void)addEdgeWithImage:(UIImage *)edgeImage;
@end
@protocol MTEditBorderViewDelegate <NSObject>
-(void)addBorderWithSelectColor:(NSString *)color;

-(void)changeBorderWidthWithValue:(float)value;
@end
@protocol MTEditBaseHeaderViewDelegate <NSObject>
-(void)previewEditPhoto;

-(void)expandDownView:(BOOL)isClose;
@end


@interface MTEditBaseHeaderView : UICollectionReusableView
@property (nonatomic,weak) id<MTEditEmotionViewDelegate> emotionViewDelegate;
@property (nonatomic,weak) id<MTEditTextViewDelegate> textViewDelegate;
@property (nonatomic,weak) id<MTEditEdgesViewDelegate> edgesViewDelegate;
@property (nonatomic,weak) id<MTEditBorderViewDelegate> borderViewDelegate;
@property (nonatomic,weak) id<MTEditBaseHeaderViewDelegate> baseViewDelegate;

@property (nonatomic,strong) NSMutableArray *colorArray;

@property (nonatomic,strong) NSMutableArray *productArray;

@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UIView *downView;

@property (nonatomic,assign) BOOL isClose;
@end

NS_ASSUME_NONNULL_END
