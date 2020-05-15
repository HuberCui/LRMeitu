//
//  MTProductListViewController.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTProductListViewController.h"
#import "MTProductListCell.h"
#import <CHTCollectionViewWaterfallLayout.h>
#import "MTEditTextView.h"
#import "MTEditEmotionView.h"
#import "MTProductListModel.h"
#import "MTAPI.h"
#import <MJExtension/MJExtension.h>
@interface MTProductListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,CHTCollectionViewDelegateWaterfallLayout>
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *imageArray;

@property (nonatomic,strong) UIButton *sureBtn;

@property (nonatomic,strong) UIImage *selectImg;

@property (nonatomic,strong) NSMutableArray *selectImgArray;

@end

@implementation MTProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"產品列表";
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
//    for (int i = 0; i<10; i++) {
//        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"chanpin%d",i]];
//        MTProductListModel *model = [MTProductListModel new];
//        model.isSelect = NO;
//        model.img = img;
//        [self.imageArray addObject:model];
//    }
    [[MTAPI GET_Products:@"173"] completion:^(NetworkAPI * _Nonnull API) {
        if (API.isRequestSuccess) {
            for (NSDictionary *dic in API.response.data) {
                MTProductListModel *model = [MTProductListModel mj_objectWithKeyValues:dic];
                model.isSelect = NO;
                [self.imageArray addObject:model];
            }
            [self.collectionView reloadData];
        }
    }];
    
    // Do any additional setup after loading the view.
    [self.view addSubview:self.collectionView];
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_sureBtn setTitle:@"新增产品图" forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(saveSelectImage) forControlEvents:UIControlEventTouchUpInside];
    _sureBtn.enabled = [self checkSureBtnCanUse];
    [self.view addSubview:_sureBtn];
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.collectionView.mas_bottom);
        make.left.mas_equalTo(self.view).offset(24);
        make.right.mas_equalTo(self.view).offset(-24);
        make.height.mas_equalTo(44);
    }];
    
}

-(void)saveSelectImage{
   
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectProductImage:)]) {
        [self.delegate selectProductImage:self.selectImgArray];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == 0){
        return 0;
    }
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        MTProductListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MTProductListCell" forIndexPath:indexPath];
           
           MTProductListModel *model = self.imageArray[indexPath.item];
           
           cell.listModel = model;
           
           return cell;
    }
    return nil;
    
}



#pragma mark CHTCollectionViewDelegateWaterfallLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(158, 158);
}


//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     MTProductListModel *model = self.imageArray[indexPath.item];
     model.isSelect = YES;
    
    MTProductListCell *cell = [self collectionView:collectionView cellForItemAtIndexPath:indexPath];
       [self.selectImgArray addObject:cell.productImageView.image];
    NSLog(@"点击了 %ld %ld",indexPath.section,indexPath.item);
    self.sureBtn.enabled = [self checkSureBtnCanUse];
    
 
    
   
   // [collectionView reloadData];
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    MTProductListModel *model = self.imageArray[indexPath.item];
  
    model.isSelect = NO;
    NSLog(@"点击了 %ld %ld",indexPath.section,indexPath.item);
    
    MTProductListCell *cell = [self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    [self.selectImgArray removeObject:cell.productImageView.image];
    self.sureBtn.enabled = [self checkSureBtnCanUse];
 
   //  [collectionView reloadData];

}

//检查是否可用
-(BOOL)checkSureBtnCanUse{
    if (self.selectImgArray.count>0) {
        [self.sureBtn setBackgroundColor:[UIColor mt_colorWithHexString:@"#F29500"]];
        return YES;
    }else{
        [self.sureBtn setBackgroundColor:[UIColor mt_colorWithHexString:@"#D2D2D2"]];
        return NO;
    }
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc]init];
        layout.columnCount = 2;
        layout.minimumColumnSpacing = 19;
        layout.minimumInteritemSpacing = 16;
        layout.sectionInset = UIEdgeInsetsMake(16, 20, 16, 20);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.mt_height-BottomHeight-54-TopBarHeight) collectionViewLayout:layout];
        
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        //        _collectionView.pagingEnabled = YES;
        //        _collectionView.bounces = NO;
        _collectionView.allowsMultipleSelection = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
       
        [_collectionView registerNib:[UINib nibWithNibName:@"MTProductListCell" bundle:nil] forCellWithReuseIdentifier:@"MTProductListCell"];
        
        
    }
    return _collectionView;
}

-(NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
-(NSMutableArray *)selectImgArray{
    if (_selectImgArray == nil) {
        _selectImgArray = [NSMutableArray array];
    }
    return _selectImgArray;
}


@end
