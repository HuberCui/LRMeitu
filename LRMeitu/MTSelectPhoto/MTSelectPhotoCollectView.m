//
//  MTSelectPhotoCollectView.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTSelectPhotoCollectView.h"
#import "MTSelectPhotoCell.h"
#import <CHTCollectionViewWaterfallLayout.h>
#import "MTProductListViewController.h"
#import "LRTool.h"
#import "MeituEditViewController.h"
@interface MTSelectPhotoCollectView()<UICollectionViewDataSource,UICollectionViewDelegate,CHTCollectionViewDelegateWaterfallLayout,UICollectionViewCellDegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *selectImageArray;
@property (nonatomic,strong) UIButton *sureBtn;
@property (strong, nonatomic) UIImagePickerController *picker;

@end
@implementation MTSelectPhotoCollectView

-(instancetype)initWithFrame:(CGRect)frame styleModel:(MTStyleModel *)styleModel{
    if (self = [super initWithFrame:frame]) {
        self.styleModel = styleModel;
        CHTCollectionViewWaterfallLayout *flowlayout = [[CHTCollectionViewWaterfallLayout alloc]init];
        flowlayout.columnCount = 2;
        flowlayout.minimumColumnSpacing = 15;
        flowlayout.minimumInteritemSpacing = 15;
        flowlayout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, MTEditCollectionViewHeight) collectionViewLayout:flowlayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.allowsMultipleSelection = NO;//不允许多选
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"MTSelectPhotoCell" bundle:nil] forCellWithReuseIdentifier:@"MTSelectPhotoCell"];
        
        [self addSubview:_collectionView];
        
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_sureBtn setTitle:@"開始拼贴" forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(startCinch) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.enabled = [self checkSureBtnCanUse];
        [self addSubview:_sureBtn];
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self).offset(-10);
            make.left.mas_equalTo(self).offset(24);
            make.right.mas_equalTo(self).offset(-24);
            make.height.mas_equalTo(44);
        }];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self);
            make.bottom.mas_equalTo(_sureBtn.mas_top).offset(-10);
        }];
        
        
    }
    return self;
}

-(void)startCinch{
    MeituEditViewController *edit = [[MeituEditViewController alloc]init];
    edit.imageArray = self.selectImageArray;
    [[LRTool getcurrentNavigationViewController] pushViewController:edit animated:YES];
}

//检查是否可用
-(BOOL)checkSureBtnCanUse{
    if (self.selectImageArray.count == self.styleModel.style+1) {
        [self.sureBtn setBackgroundColor:[UIColor mt_colorWithHexString:@"#F29500"]];
        return YES;
    }else{
        [self.sureBtn setBackgroundColor:[UIColor mt_colorWithHexString:@"#D2D2D2"]];
        return NO;
    }
}

-(void)setStyleModel:(MTStyleModel *)styleModel{
    _styleModel = styleModel;
    if (_collectionView) {
        
        if (self.selectImageArray.count > styleModel.style+1) {
            [self.selectImageArray removeObjectsInRange:NSMakeRange(styleModel.style, self.selectImageArray.count-styleModel.style-1)];
        }
        [_collectionView reloadData];
    }
    
    if (_sureBtn) {
        _sureBtn.enabled = [self checkSureBtnCanUse];
    }
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.selectImageArray.count >= self.styleModel.style+1) {
        return self.selectImageArray.count;
    }
    return self.selectImageArray.count +1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MTSelectPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MTSelectPhotoCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.deleteBtn.tag = indexPath.item;
    if (indexPath.item == self.selectImageArray.count) {
        cell.bottomImageView.image = [UIImage imageNamed:@"selectPhoto"];
        cell.deleteBtn.hidden = YES;
        
    }else{
        cell.bottomImageView.image = self.selectImageArray[indexPath.item];
        cell.deleteBtn.hidden = NO;
    }
    
    return cell;
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == self.selectImageArray.count) {
        //        MTProductListViewController *list = [[MTProductListViewController alloc]init];
        //        list.delegate = self;
        //        [[LRTool getcurrentNavigationViewController] pushViewController:list animated:YES];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            self.picker.modalPresentationStyle = UIModalPresentationFullScreen;
            
            [[LRTool getcurrentViewController] presentViewController:self.picker animated:YES completion:nil];
            
        }
    }
    
}

#pragma mark CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //  return CGSizeMake((collectionView.frame.size.width-14-14-8)/2, (collectionView.frame.size.height-14-14-8)/2);
    return CGSizeMake(90, 90);
}

#pragma mark UICollectionViewCellDegate
-(void)deleteImageWithBbuttontag:(NSInteger)tag{
    [self.selectImageArray removeObjectAtIndex:tag];
    [self.collectionView reloadData];
    self.sureBtn.enabled = [self checkSureBtnCanUse];
}


#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    
    [self.selectImageArray addObject:image];
    [self.collectionView reloadData];
    self.sureBtn.enabled = [self checkSureBtnCanUse];
    //    获取图片后返回
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(NSMutableArray *)selectImageArray{
    if (_selectImageArray == nil) {
        _selectImageArray = [NSMutableArray array];
    }
    return _selectImageArray;
}


- (UIImagePickerController *)picker
{
    if (!_picker) {
        _picker = [[UIImagePickerController alloc]init];
        _picker.delegate = self;
        // _picker.allowsEditing = YES;
    }
    return _picker;
}
@end
