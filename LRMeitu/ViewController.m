//
//  ViewController.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/27.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "ViewController.h"
//#import "ZYQAssetPickerController.h"
#import "MeituEditViewController.h"
#import "MTSelectStyleViewController.h"
#import "MTProductListViewController.h"
#import "MTStartViewController.h"
#import "MTKeyBoardView.h"
#import "MTAPI.h"
@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *meituMenuButton;

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.title = @"拼图";
    
//    [[MTAPI GET_TipsMessage:@"173"] completion:^(NetworkAPI * _Nonnull API) {
//
//    }];
//    [[MTAPI GET_Colors:@"173"] completion:^(NetworkAPI * _Nonnull API) {
//
//       }];
    
    [[MTAPI GET_Products:@"173"] completion:^(NetworkAPI * _Nonnull API) {
              
          }];

           
    
    
    
    _meituMenuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 103, 105)];
    
    [_meituMenuButton setTitle:@"拼图" forState:UIControlStateNormal];
    _meituMenuButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:_meituMenuButton];
    _meituMenuButton.center = self.view.center;
    
    [_meituMenuButton addTarget:self action:@selector(meituAction:) forControlEvents:UIControlEventTouchUpInside];

  
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
//}
//
//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//}
-(void)meituAction:(UIButton *)btn{
   // MeituEditViewController *vc = [[MeituEditViewController alloc]init];
    //MTProductListViewController *vc = [[MTProductListViewController alloc]init];
    MTStartViewController *vc = [MTStartViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
    // [self.keyBoardView.textView becomeFirstResponder];
 //   [self.textView becomeFirstResponder];
}


@end
