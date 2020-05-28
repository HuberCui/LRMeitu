//
//  MTSelectStyleViewController.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTSelectStyleViewController.h"
#import "LRTool.h"
#import <Masonry.h>
#import <CHTCollectionViewWaterfallLayout.h>
#import "MeutuEditCell.h"
#import "MTStyleModel.h"
#import <MJExtension.h>
#import "MTStyleSelectCell.h"
#import "MTSelectPhotoViewController.h"
@interface MTSelectStyleViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,CHTCollectionViewDelegateWaterfallLayout>
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation MTSelectStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"分享";
    
    
    [self jsonStyle];
    
    UILabel *titleLab = [UILabel new];
    titleLab.text = @"STEP1";
    titleLab.font = [UIFont mt_boldFontOfSize:24];
    [self.view addSubview:titleLab];
    
    UILabel *tipLab = [UILabel new];
    tipLab.text = @"选择拼贴模式";
    tipLab.font = [UIFont mt_fontOfSize:14];
    [self.view addSubview:tipLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(32);
    }];
    
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(5);
    }];
    
    
    CHTCollectionViewWaterfallLayout *flowlayout = [[CHTCollectionViewWaterfallLayout alloc]init];
    flowlayout.columnCount = 3;
    flowlayout.minimumColumnSpacing = 37;
    flowlayout.minimumInteritemSpacing = 36;
    flowlayout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, MTEditCollectionViewHeight) collectionViewLayout:flowlayout];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.scrollEnabled = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.allowsMultipleSelection = NO;//不允许多选
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"MTStyleSelectCell" bundle:nil] forCellWithReuseIdentifier:@"MTStyleSelectCell"];
    
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(tipLab.mas_bottom).offset(24);
        make.height.mas_equalTo(400);
    }];
    
}

-(void)jsonStyle{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"photostyle" ofType:@"json"]; // 解析json
      NSData *data = [NSData dataWithContentsOfFile:path];
      NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
      NSArray *jsonArray = dict[@"style"];
    for (NSDictionary *dic in jsonArray) {
        MTStyleModel *model = [MTStyleModel mj_objectWithKeyValues:dic];
        [self.dataArray addObject:model];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MTStyleSelectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MTStyleSelectCell" forIndexPath:indexPath];
    MTStyleModel *model = self.dataArray[indexPath.item];
    cell.styleModel = model;
  
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MTStyleModel *model = self.dataArray[indexPath.item];
    MTSelectPhotoViewController *photoVC = [[MTSelectPhotoViewController alloc]init];
    photoVC.styleArray = self.dataArray;
    photoVC.styleModel = model;
    [self.navigationController pushViewController:photoVC animated:YES];
    
    
}

#pragma mark CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //  return CGSizeMake((collectionView.frame.size.width-14-14-8)/2, (collectionView.frame.size.height-14-14-8)/2);
    return CGSizeMake(90, 90);
}


-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
