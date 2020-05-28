//
//  MTSelectPhotoViewController.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTSelectPhotoViewController.h"
#import "MTStyleSelectCell.h"
#import "MTSelectPhotoCollectView.h"
#import "MTSelectPhotoStyleCollectView.h"

@interface MTSelectPhotoViewController ()<MTSelectPhotoStyleCollectViewDelegate>
@property (nonatomic,strong) MTSelectPhotoCollectView *selectPhotoView;

@end

@implementation MTSelectPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"分享";
    UILabel *stepOne = [UILabel new];
    stepOne.textAlignment = NSTextAlignmentLeft;
    stepOne.text = @"STEP1 选择拼贴模式";
    stepOne.font = [UIFont mt_lightFontOfSize:14];
    [self.view addSubview:stepOne];
    [stepOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.top.mas_equalTo(self.view).offset(21+TopBarHeight);
    }];
    MTSelectPhotoStyleCollectView *styleView = [[MTSelectPhotoStyleCollectView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 41) styleArray:self.styleArray styleModel:self.styleModel];
    styleView.delegate = self;
    [self.view addSubview:styleView];
    [styleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(stepOne.mas_bottom).offset(16);
        make.height.mas_equalTo(41);
    }];
    UILabel *stepTwo = [UILabel new];
       stepTwo.textAlignment = NSTextAlignmentLeft;
       stepTwo.text = @"STEP2 选择照片";
       stepTwo.font = [UIFont mt_lightFontOfSize:14];
       [self.view addSubview:stepTwo];
    [stepTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.top.mas_equalTo(styleView.mas_bottom).offset(34);
    }];
    
    MTSelectPhotoCollectView *selectPhotoView = [[MTSelectPhotoCollectView alloc]initWithFrame:CGRectZero styleModel:self.styleModel];
    _selectPhotoView = selectPhotoView;
    [self.view addSubview:selectPhotoView];
    
    [selectPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(stepTwo.mas_bottom).offset(14);
        make.bottom.mas_equalTo(self.view);
    }];
    
  
}


#pragma mark MTSelectPhotoStyleCollectViewDelegate
-(void)changeSelectStyleModel:(MTStyleModel *)selectModel{
    self.styleModel = selectModel;
    _selectPhotoView.styleModel = selectModel;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
