//
//  MTSelectPhotoStyleCollectView.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTSelectPhotoStyleCollectView.h"
#import "MTStyleSelectCell.h"
#import <CHTCollectionViewWaterfallLayout.h>
@interface MTSelectPhotoStyleCollectView()<UICollectionViewDataSource,UICollectionViewDelegate,CHTCollectionViewDelegateWaterfallLayout>
@property (nonatomic,strong) UICollectionView *collectionView;

@end
@implementation MTSelectPhotoStyleCollectView

-(instancetype)initWithFrame:(CGRect)frame styleArray:(NSMutableArray *)styleArray styleModel:(MTStyleModel *)styleModel{
    if (self = [super initWithFrame:frame]) {
        self.styleArray = styleArray;
        self.styleModel = styleModel;
        CHTCollectionViewWaterfallLayout *flowlayout = [[CHTCollectionViewWaterfallLayout alloc]init];
        flowlayout.columnCount = 6;
        flowlayout.minimumColumnSpacing = 27;
        flowlayout.minimumInteritemSpacing = 0;
        flowlayout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 41) collectionViewLayout:flowlayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.allowsMultipleSelection = NO;//不允许多选
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        _collectionView.allowsSelection = NO;//是否允许选择
        [_collectionView registerNib:[UINib nibWithNibName:@"MTStyleSelectCell" bundle:nil] forCellWithReuseIdentifier:@"MTStyleSelectCellStepOne"];
        [self addSubview:_collectionView];
        
        
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            //  make.left.right.top.right.mas_equalTo(self);
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.styleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MTStyleSelectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MTStyleSelectCellStepOne" forIndexPath:indexPath];
    MTStyleModel *model = self.styleArray[indexPath.item];
    cell.styleModel = model;
    if (model.selectStyle == self.styleModel.selectStyle) {
        cell.selected = YES;
    }
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     MTStyleModel *model = self.styleArray[indexPath.item];
    self.styleModel = model;
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeSelectStyleModel:)]) {
        [self.delegate changeSelectStyleModel:model];
       
       }
    [self.collectionView reloadData];
}

#pragma mark CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //  return CGSizeMake((collectionView.frame.size.width-14-14-8)/2, (collectionView.frame.size.height-14-14-8)/2);
    return CGSizeMake(30, 30);
}

@end

