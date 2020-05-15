//
//  MTEditBorderView.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/3/1.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTEditBorderView.h"
#import "MTEditColorsCell.h"
#import "MTEditColorModel.h"
#import <MJExtension/MJExtension.h>

@interface MTEditBorderView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UISlider *slider;
@property (nonatomic,assign) BOOL isFirstLoad;
@end


@implementation MTEditBorderView
@synthesize colorArray = _colorArray;
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
      //  [self jsonColor];
        _isFirstLoad = YES;
        UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        _slider = slider;
        slider.minimumValue = 0;
        slider.maximumValue = 40;
        slider.minimumValueImage = [UIImage imageNamed:@"sliderMin"];
        slider.maximumValueImage = [UIImage imageNamed:@"sliderMax"];
        slider.minimumTrackTintColor = [UIColor greenColor];
        [slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
        [self.downView addSubview:slider];
        
        
        self.backgroundColor = [UIColor mt_colorWithHexString:@"#FFFFFF"];
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
        
     //  [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        //设置slider的默认颜色
      
        [_collectionView registerNib:[UINib nibWithNibName:@"MTEditColorsCell" bundle:nil] forCellWithReuseIdentifier:@"MTEditColorsCell"];
        [self.downView addSubview:_collectionView];
        
        [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.downView).offset(24);
            make.right.mas_equalTo(self.downView).offset(-24);
            make.top.mas_equalTo(self.downView).offset(17);
        }];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
         //   make.bottom.mas_equalTo(self).offset(-15);
            make.left.mas_equalTo(self.downView).offset(22);
            make.right.mas_equalTo(self.downView).offset(-22);
            make.top.mas_equalTo(slider.mas_bottom).offset(7);
            make.height.mas_equalTo(35);
        }];
        
    }
    return self;
}
-(void)setColorArray:(NSMutableArray *)colorArray{
   // [super setColorArray:colorArray];
    _colorArray = colorArray;
     [self.collectionView reloadData];
    
    if (_isFirstLoad) {
        _isFirstLoad = NO;
        MTEditColorModel *model = colorArray.firstObject;
                 _slider.minimumTrackTintColor = [UIColor mt_colorWithHexString:model.color];
           
          
            [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
           if (self.borderViewDelegate && [self.borderViewDelegate respondsToSelector:@selector(addBorderWithSelectColor:)]) {
                [self.borderViewDelegate addBorderWithSelectColor:model.color];
            }
    }
   
}

-(NSMutableArray *)colorArray{
    return _colorArray;
}
-(void)sliderValueChange:(UISlider *)slider{
    NSLog(@"------%f",slider.value);
    if (self.borderViewDelegate && [self.borderViewDelegate respondsToSelector:@selector(changeBorderWidthWithValue:)]) {
        [self.borderViewDelegate changeBorderWidthWithValue:slider.value];
    }
}
-(void)jsonColor{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bordercolors" ofType:@"json"]; // 解析json
      NSData *data = [NSData dataWithContentsOfFile:path];
      NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
      NSArray *jsonArray = dict[@"colors"];
    for (NSDictionary *dic in jsonArray) {
        MTEditColorModel *model = [MTEditColorModel mj_objectWithKeyValues:dic];
        //[self.borderColorArray addObject:model];
    }
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
     MTEditColorModel *model = self.colorArray[indexPath.item];
    _slider.minimumTrackTintColor = [UIColor mt_colorWithHexString:model.color];
    
    if (self.borderViewDelegate && [self.borderViewDelegate respondsToSelector:@selector(addBorderWithSelectColor:)]) {
        [self.borderViewDelegate addBorderWithSelectColor:model.color];
    }
}

//#pragma mark CHTCollectionViewDelegateWaterfallLayout
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    return CGSizeMake(80, 80);
//}



//- (NSMutableArray *)colorArray{
//    if (<#condition#>) {
//        <#statements#>
//    }
//}
@end
