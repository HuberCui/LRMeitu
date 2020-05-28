//
//  MTEditStyleSelectView.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/3/1.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTEditStyleSelectView.h"
#import "MTEditStyleSelectCell.h"
#import <CHTCollectionViewWaterfallLayout.h>
#import "MTEditEmotionView.h"
#import "MTEditTextView.h"
#import "MTEditBorderView.h"
#import "MTEditEdgesView.h"
#import "MTEditBaseHeaderView.h"
#import <MJExtension/MJExtension.h>
#import "MTEditColorModel.h"
#import "MTProductListModel.h"
@interface MTEditStyleSelectView ()<UICollectionViewDataSource,UICollectionViewDelegate,CHTCollectionViewDelegateWaterfallLayout>
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *styleArray;
@property (nonatomic,strong) NSMutableArray *colorArray;
@property (nonatomic,assign) NSInteger selectItemIndex;

@property (nonatomic,weak) id headerDelegate;

@end
@implementation MTEditStyleSelectView

-(instancetype)initWithDelegate:(id)delegate frame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _selectItemIndex = 0;
        _headerDelegate = delegate;
         [self jsonColor];
      
        [self configProduct];
        for (int i = 0; i<=9; i++) {
            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"border%d",i]];
            [self.edgesArray addObject:img];
        }

        for (int i = 0; i<4; i++) {
            MTEditStyleSelectModel *model = [MTEditStyleSelectModel new];
            model.editStyle = i;
            [self.styleArray addObject:model];
        }
        CHTCollectionViewWaterfallLayout *flowlayout = [[CHTCollectionViewWaterfallLayout alloc]init];
        flowlayout.columnCount = 4;
        flowlayout.minimumColumnSpacing = 10;
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
       
        [_collectionView registerClass:[MTEditStyleSelectCell class] forCellWithReuseIdentifier:@"MTEditStyleSelectCell"];
        [_collectionView registerClass:[MTEditTextView class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:@"MTEditTextView"];
        [_collectionView registerClass:[MTEditEmotionView class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:@"MTEditEmotionView"];
        [_collectionView registerClass:[MTEditBorderView class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:@"MTEditBorderView"];
        [_collectionView registerClass:[MTEditEdgesView class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:@"MTEditEdgesView"];
        [self addSubview:_collectionView];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            //  make.left.right.top.right.mas_equalTo(self);
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}
-(void)configProduct{
          for (int i = 0; i<10; i++) {
                UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"chanpin%d",i]];
                MTProductListModel *model = [MTProductListModel new];
                model.isSelect = NO;
                model.showImage = img;
                [self.productArray addObject:model];
            }
     [self.collectionView reloadData];
}


-(void)jsonColor{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bordercolors" ofType:@"json"]; // 解析json
      NSData *data = [NSData dataWithContentsOfFile:path];
      NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
      NSArray *jsonArray = dict[@"colors"];
    for (NSDictionary *dic in jsonArray) {
        MTEditColorModel *model = [MTEditColorModel mj_objectWithKeyValues:dic];
        [self.colorArray addObject:model];
    }
}

//控制展开关闭
-(void)setIsClose:(BOOL)isClose{
    _isClose = isClose;
    
    [self.collectionView reloadData];
}

-(void)reloadCollectionData{
     [self.collectionView reloadData];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 4;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(nonnull NSString *)kind atIndexPath:(nonnull NSIndexPath *)indexPath{
    
    MTEditBaseHeaderView *reuseablebiew=nil;
    
    
    NSLog(@"------%@",collectionView.indexPathsForSelectedItems);
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {//这是头视图
        switch (_selectItemIndex) {
            case 0:
                reuseablebiew=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MTEditEmotionView" forIndexPath:indexPath];
                reuseablebiew.emotionViewDelegate = _headerDelegate;
                reuseablebiew.productArray = self.productArray;
                break;
            case 1:
                reuseablebiew=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MTEditTextView" forIndexPath:indexPath];
                reuseablebiew.textViewDelegate = _headerDelegate;
                reuseablebiew.colorArray = self.colorArray;
                break;
            case 2:
                reuseablebiew=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MTEditEdgesView" forIndexPath:indexPath];
                reuseablebiew.edgesViewDelegate = _headerDelegate;
                reuseablebiew.edgesArray = self.edgesArray;
                break;
            case 3:
                reuseablebiew=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MTEditBorderView" forIndexPath:indexPath];
                reuseablebiew.borderViewDelegate = _headerDelegate;
                reuseablebiew.colorArray = self.colorArray;
                break;
            default:
                break;
        }
        reuseablebiew.baseViewDelegate = _headerDelegate;
        reuseablebiew.isClose = _isClose;
    }
       
    
    return reuseablebiew;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MTEditStyleSelectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MTEditStyleSelectCell" forIndexPath:indexPath];
    if (_selectItemIndex == indexPath.item) {
        cell.selected = YES;
    }
    MTEditStyleSelectModel *model = self.styleArray[indexPath.item];
    cell.styleModel = model;
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MTEditStyleSelectModel *model = self.styleArray[indexPath.item];
    
    if (_selectItemIndex != indexPath.item) {
        _selectItemIndex = indexPath.item;
        [self.collectionView reloadData];
    }
   
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectAndAddText)] && indexPath.item == 1) {
        [self.delegate selectAndAddText];
    }
}


#pragma mark CHTCollectionViewDelegateWaterfallLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section{
    
    if (self.isClose) {
        return 73;
    }
    return 140;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //  return CGSizeMake((collectionView.frame.size.width-14-14-8)/2, (collectionView.frame.size.height-14-14-8)/2);
    return CGSizeMake(30, 30);
}

-(NSMutableArray *)styleArray{
    if (_styleArray == nil) {
        _styleArray = [NSMutableArray array];
    }
    return _styleArray;
}

-(NSMutableArray *)colorArray{
    if (_colorArray == nil) {
        _colorArray = [NSMutableArray array];
    }
    return _colorArray;
}

- (NSMutableArray *)productArray{
    if (_productArray == nil) {
        _productArray = [NSMutableArray array];
    }
    return _productArray;
}
- (NSMutableArray *)edgesArray{
    if (_edgesArray == nil) {
        _edgesArray = [NSMutableArray array];
    }
    return _edgesArray;
}
@end
