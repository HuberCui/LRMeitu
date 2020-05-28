//
//  MTEditEmotionView.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/3/1.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTEditEmotionView.h"
#import <CHTCollectionViewWaterfallLayout.h>
#import "MTEditEmotionViewCell.h"
#import "MTDirectionButton.h"
#import "MTProductListModel.h"
@interface MTEditEmotionView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@end
@implementation MTEditEmotionView
@synthesize productArray = _productArray;

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor mt_colorWithHexString:@"#FFFFFF"];
          MTDirectionButton *moreBtn = [MTDirectionButton buttonWithType:UIButtonTypeCustom Style:MTButtonEdgeInsetsStyleTop Space:1];
            
           //  moreBtn.backgroundColor = [UIColor yellowColor];
             [moreBtn setImage:[UIImage imageNamed:@"more_emotion"] forState:UIControlStateNormal];
             [moreBtn.titleLabel setFont:[UIFont mt_lightFontOfSize:10]];
             [moreBtn setTitle:@"更多产品图" forState:UIControlStateNormal];
        
        [moreBtn addTarget:self action:@selector(addProduct) forControlEvents:UIControlEventTouchUpInside];
        [moreBtn setTitleColor:[UIColor mt_colorWithHexString:@"#1F1F1F"] forState:UIControlStateNormal];
             [self.downView addSubview:moreBtn];
             [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.centerY.mas_equalTo(self.downView);
                 make.left.mas_equalTo(self.downView).offset(15);
                 make.width.mas_equalTo(51);
             }];
//      for (int i = 0; i<10; i++) {
//            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"chanpin%d",i]];
//            MTProductListModel *model = [MTProductListModel new];
//            model.isSelect = NO;
//            model.img = img;
//            [self.imageArray addObject:model];
//        }
        
         UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
        flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowlayout.itemSize = CGSizeMake(80, 80);
       
        flowlayout.minimumLineSpacing = 16;
       // flowlayout.minimumInteritemSpacing = 10;
        // flowlayout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 10);
         _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100) collectionViewLayout:flowlayout];
         _collectionView.showsVerticalScrollIndicator = NO;
         _collectionView.showsHorizontalScrollIndicator = NO;
        
         _collectionView.backgroundColor = [UIColor mt_colorWithHexString:@"#FAFAFA"];
         _collectionView.allowsMultipleSelection = NO;//不允许多选
         _collectionView.delegate = self;
         _collectionView.dataSource = self;
         //        _collectionView.allowsSelection = NO;//是否允许选择

        [_collectionView registerNib:[UINib nibWithNibName:@"MTEditEmotionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MTEditEmotionViewCell"];
         [self.downView addSubview:_collectionView];
         
         [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_equalTo(self.downView);
            make.left.mas_equalTo(moreBtn.mas_right).offset(15);
         }];
        
    }
    return self;
}

-(void)setProductArray:(NSMutableArray *)productArray{
    _productArray = productArray;
    
    [self.collectionView reloadData];
}

- (NSMutableArray *)productArray{
    return _productArray;
}
-(void)addProduct{
    if (self.emotionViewDelegate && [self.emotionViewDelegate respondsToSelector:@selector(addMoreProductPicture)]) {
        [self.emotionViewDelegate addMoreProductPicture];
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.productArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MTEditEmotionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MTEditEmotionViewCell" forIndexPath:indexPath];
    MTProductListModel *model = self.productArray[indexPath.item];
  
//    NSURL *imgurl = IMAGE_URL(model.prodimg);
//    [cell.productImageView sd_setImageWithURL:imgurl];
    cell.productImageView.image = model.showImage;
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MTEditEmotionViewCell *cell = (MTEditEmotionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (self.emotionViewDelegate && [self.emotionViewDelegate respondsToSelector:@selector(addOneEmotionWithImage:)]) {
        [self.emotionViewDelegate addOneEmotionWithImage:cell.productImageView.image];
    }
}

//#pragma mark CHTCollectionViewDelegateWaterfallLayout
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
// 
//    return CGSizeMake(80, 80);
//}



@end
