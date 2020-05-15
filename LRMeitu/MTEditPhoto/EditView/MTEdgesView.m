//
//  MTEdgesView.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/3/3.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTEdgesView.h"
@interface MTEdgesView()
@property (nonatomic,strong) UIImageView *imageView;
@end
@implementation MTEdgesView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    //上一层View
    return nil;
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"======");
//}
-(void)setEdgeImage:(UIImage *)edgeImage{
    _edgeImage = edgeImage;
    self.imageView.image = edgeImage;
}

-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}
@end
