//
//  MTStartViewController.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/3/6.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTStartViewController.h"
#import "MTSelectStyleViewController.h"
#import <Masonry.h>
@interface MTStartViewController ()

@end

@implementation MTStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mt_addtip"]];
    [self.view addSubview:imageView];
    
    UILabel *labe = [UILabel new];
    labe.text = @"來新增一張組圖吧!";
    labe.font = [UIFont mt_lightFontOfSize:16];
    labe.textColor = [UIColor mt_colorWithHexString:@"6b6b6b"];
    [self.view addSubview:labe];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor mt_colorWithHexString:@"F29500"];
    [btn setTitle:@"新增" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont mt_fontOfSize:14]];
    [btn setTitleColor:[UIColor mt_colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addPicture:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 25.25;
    [self.view addSubview:btn];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(56);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [labe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(imageView.mas_bottom).offset(10);
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(labe.mas_bottom).offset(16);
        make.width.mas_equalTo(127);
        make.height.mas_equalTo(48);
    }];
}
-(void)addPicture:(id)sender{
    MTSelectStyleViewController *vc =[MTSelectStyleViewController new];
    [self.navigationController pushViewController:vc animated:YES];
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
