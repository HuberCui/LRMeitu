//
//  MTEditBaseHeaderView.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/3/3.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTEditBaseHeaderView.h"
@interface MTEditBaseHeaderView()
@property (nonatomic,strong) UIButton *upBtn;
@end
@implementation MTEditBaseHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.headView.backgroundColor = [UIColor redColor];
        [self addSubview:self.headView];
        UIButton *preBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [preBtn setTitle:@"預覽" forState:UIControlStateNormal];
        [preBtn.titleLabel setFont:[UIFont mt_lightFontOfSize:14]];
        [preBtn setTitleColor:[UIColor mt_colorWithHexString:@"#6B6B6B"] forState:UIControlStateNormal];
        [preBtn addTarget:self action:@selector(preImage) forControlEvents:UIControlEventTouchUpInside];
        
        [self.headView addSubview:preBtn];
        
    
        UIButton *upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _upBtn = upBtn;
        [upBtn setImage:[UIImage imageNamed:@"mt_expand"] forState:UIControlStateNormal];
               [upBtn.titleLabel setFont:[UIFont mt_lightFontOfSize:14]];
               [upBtn setTitleColor:[UIColor mt_colorWithHexString:@"#6B6B6B"] forState:UIControlStateNormal];
        [upBtn addTarget:self action:@selector(expand_downView:) forControlEvents:UIControlEventTouchUpInside];
        [self.headView addSubview:upBtn];
        
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self);
            make.height.mas_equalTo(40);
        }];
        
        [preBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.headView);
            make.width.mas_equalTo(80);
           
        }];
        
        [upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.headView);
            make.right.mas_equalTo(self.headView).offset(-15);
        }];
        
        
        [self addSubview:self.downView];
        
        [self.downView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headView.mas_bottom);
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(100);
        }];
    }
    return self;
}
-(void)setIsClose:(BOOL)isClose{
  
  _isClose = isClose;
        
   self.downView.hidden = isClose;
    
    _upBtn.selected = isClose;
   
    if (isClose) {
        [self.headView mas_remakeConstraints:^(MASConstraintMaker *make) {
                   make.left.top.right.mas_equalTo(self);
                   make.height.mas_equalTo(73);
               }];
    }else{
        [self.headView mas_remakeConstraints:^(MASConstraintMaker *make) {
                   make.left.top.right.mas_equalTo(self);
                   make.height.mas_equalTo(40);
               }];
    }
}
-(void)preImage{
    if (self.baseViewDelegate && [self.baseViewDelegate respondsToSelector:@selector(previewEditPhoto)]) {
        [self.baseViewDelegate previewEditPhoto];
    }
}

-(void)expand_downView:(UIButton *)btn{
    btn.selected = !btn.selected;
  
    
    if (btn.selected) {
       
//        [self.downView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.headView.mas_bottom);
//            make.left.right.mas_equalTo(self);
//            make.height.mas_equalTo(0);
//        }];
         self.downView.hidden = YES;
    }else{
        
//        [self.downView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.headView.mas_bottom);
//            make.left.right.mas_equalTo(self);
//            make.height.mas_equalTo(100);
//        }];
        self.downView.hidden = NO;
    }
    
    if (self.baseViewDelegate && [self.baseViewDelegate respondsToSelector:@selector(expandDownView:)]) {
          [self.baseViewDelegate expandDownView:btn.selected];
        }
}
- (UIView *)headView{
    if (_headView == nil) {
        _headView = [UIView new];
    }
    return _headView;
}

- (UIView *)downView{
    if (_downView == nil) {
        _downView = [UIView new];
    }
    return _downView;
}
@end
