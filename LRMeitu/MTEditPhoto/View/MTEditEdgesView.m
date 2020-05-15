//
//  MTEditEdgesView.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/3/1.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTEditEdgesView.h"
#import "MTProductListModel.h"
#import "MTEditEdgesViewCell.h"
#import "MTDirectionButton.h"
@interface MTEditEdgesView()
<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *imageArray;
@end
@implementation MTEditEdgesView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor mt_colorWithHexString:@"#FFFFFF"];
        MTDirectionButton *moreBtn = [MTDirectionButton buttonWithType:UIButtonTypeCustom Style:MTButtonEdgeInsetsStyleTop Space:1];
       
      //  moreBtn.backgroundColor = [UIColor yellowColor];
        [moreBtn setImage:[UIImage imageNamed:@"more_emotion"] forState:UIControlStateNormal];
        [moreBtn.titleLabel setFont:[UIFont mt_lightFontOfSize:10]];
        [moreBtn setTitle:@"更多邊框" forState:UIControlStateNormal];
         [moreBtn setTitleColor:[UIColor mt_colorWithHexString:@"#1F1F1F"] forState:UIControlStateNormal];
        [self.downView addSubview:moreBtn];
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.downView);
            make.left.mas_equalTo(self.downView).offset(15);
            make.width.mas_equalTo(51);
        }];
        for (int i = 1; i<=6; i++) {
            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"border%d",i]];
          
//            model.isSelect = NO;
//            model.img = img;
            [self.imageArray addObject:img];
        }
        
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
        
        //  [_collectionView registerClass:[MTEditEmotionViewCell class] forCellWithReuseIdentifier:@"MTEditEmotionViewCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"MTEditEdgesViewCell" bundle:nil] forCellWithReuseIdentifier:@"MTEditEdgesViewCell"];
        [self.downView addSubview:_collectionView];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_equalTo(self.downView);
            make.left.mas_equalTo(moreBtn.mas_right).offset(15);
        }];
        
    }
    return self;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MTEditEdgesViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MTEditEdgesViewCell" forIndexPath:indexPath];
    UIImage *image = self.imageArray[indexPath.item];
    cell.edgeImageView.image = image;
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     UIImage *image = self.imageArray[indexPath.item];
    if (self.edgesViewDelegate && [self.edgesViewDelegate respondsToSelector:@selector(addEdgeWithImage:)]) {
        [self.edgesViewDelegate addEdgeWithImage:image];
    }
}

//#pragma mark CHTCollectionViewDelegateWaterfallLayout
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    return CGSizeMake(80, 80);
//}


-(NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
@end
