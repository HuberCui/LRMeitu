//
//  MTEditStyleSelectCell.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/3/1.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTEditStyleSelectCell.h"
@interface MTEditStyleSelectCell()
@property (nonatomic,strong) UIImageView *imageView;
@end
@implementation MTEditStyleSelectCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView = imageView;
        [self addSubview:imageView];
        
        self.lab = [UILabel new];
        self.lab.font = [UIFont mt_lightFontOfSize:14];
        [self addSubview:self.lab];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(6);
            make.centerX.mas_equalTo(self);
        }];
        [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(self);
            make.top.mas_equalTo(imageView.mas_bottom).offset(6);
            make.centerX.mas_equalTo(self);
        }];
        
    }
    return self;
}


-(void)setStyleModel:(MTEditStyleSelectModel *)styleModel{
    _styleModel = styleModel;

        switch (styleModel.editStyle) {
            case MTEditEmotionStyle:
                self.imageView.image = self.selected ? [UIImage imageNamed:@"emotion_selected"] : [UIImage imageNamed:@"emotion_unselect"];
                self.lab.text = @"產品圖";
                break;
            case MTEditTextStyle:
                self.imageView.image = self.selected ? [UIImage imageNamed:@"text_selected"] :[UIImage imageNamed:@"text_unselect"];
                self.lab.text = @"文字";
                break;
            case MTEditEdgesStyle:
                self.imageView.image = self.selected ? [UIImage imageNamed:@"edges_selected"] :[UIImage imageNamed:@"edge_unselect"];
                self.lab.text = @"邊框";
                break;
            case MTEditBoderStyle:
                self.imageView.image = self.selected ? [UIImage imageNamed:@"border_selected"] :[UIImage imageNamed:@"border_unselect"];
                self.lab.text = @"輪廓";
                break;
            default:
                break;
        }
        
        self.lab.textColor = self.selected ? [UIColor mt_colorWithHexString:@"#F29500"] :[UIColor mt_colorWithHexString:@"#1F1F1F"];
    
    
}

//-(void)setSelected:(BOOL)selected{
//    [super setSelected:selected];
//    if (self.selected) {
//        self.lab.textColor = [UIColor redColor];
//    }else{
//        self.lab.textColor = [UIColor blackColor];
//    }
//}
@end
