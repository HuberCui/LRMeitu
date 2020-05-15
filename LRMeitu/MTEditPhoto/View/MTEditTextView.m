//
//  MTEditBorderView.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/3/1.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTEditTextView.h"
#import "MTEditColorsCell.h"
#import "MTEditColorModel.h"
#import <MJExtension/MJExtension.h>
@interface MTEditTextView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation MTEditTextView
@synthesize colorArray = _colorArray;

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _selectedItem = 0;
        self.backgroundColor = [UIColor mt_colorWithHexString:@"#FAFAFA"];
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
        flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowlayout.itemSize = CGSizeMake(35, 35);
        
        flowlayout.minimumLineSpacing = 10;
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
        
       [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
      
        [_collectionView registerNib:[UINib nibWithNibName:@"MTEditColorsCell" bundle:nil] forCellWithReuseIdentifier:@"MTEditColorsCell"];
        [self.downView addSubview:_collectionView];
        
       
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
         //   make.bottom.mas_equalTo(self).offset(-15);
            make.left.mas_equalTo(self.downView).offset(22);
            make.right.mas_equalTo(self.downView).offset(-22);
            make.centerY.mas_equalTo(self.downView);
            make.height.mas_equalTo(35);
        }];
        
    }
    return self;
}
-(void)setColorArray:(NSMutableArray *)colorArray{
   // [super setColorArray:colorArray];
    _colorArray = colorArray;
    [self.collectionView reloadData];
}

-(NSMutableArray *)colorArray{
    return _colorArray;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.colorArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MTEditColorsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MTEditColorsCell" forIndexPath:indexPath];
    MTEditColorModel *model = self.colorArray[indexPath.item];
    cell.colorModel = model;
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _selectedItem = indexPath.item;
     MTEditColorModel *model = self.colorArray[indexPath.item];

    if (self.textViewDelegate && [self.textViewDelegate respondsToSelector:@selector(changeSelectTextcolorWithColor:)]) {
           [self.textViewDelegate changeSelectTextcolorWithColor:model.color];
       }
}

//#pragma mark CHTCollectionViewDelegateWaterfallLayout
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    return CGSizeMake(80, 80);
//}



//-(NSMutableArray *)colorArray{
//    if (_colorArray == nil) {
//        _colorArray = [NSMutableArray array];
//    }
//    return _colorArray;
//}
@end
