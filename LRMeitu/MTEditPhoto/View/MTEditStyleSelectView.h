//
//  MTEditStyleSelectView.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/3/1.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MTEditStyleSelectViewDelegate <NSObject>

-(void)selectAndAddText;

@end
@interface MTEditStyleSelectView : UIView
-(instancetype)initWithDelegate:(id)delegate frame:(CGRect)frame;
@property (nonatomic,weak) id<MTEditStyleSelectViewDelegate> delegate;

@property (nonatomic,assign) BOOL isClose;

@property (nonatomic,strong) NSMutableArray *productArray;
@property (nonatomic,strong) NSMutableArray *edgesArray;
-(void)reloadCollectionData;
@end

NS_ASSUME_NONNULL_END
