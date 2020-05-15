//
//  MeutuEditCell.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/27.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MeutuEditCell.h"
#import <Masonry.h>

@interface MeutuEditCell ()<UIScrollViewDelegate>
@property (strong, nonatomic)  UIImageView *imageView;
@property (nonatomic,strong) UIScrollView *scrollView;
@end
@implementation MeutuEditCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_scrollView];
        
        UIView *bottomView = [UIView new];
        
        [_scrollView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_scrollView);
            make.width.height.mas_equalTo(_scrollView);
        }];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = YES;
        [bottomView addSubview:_imageView];
        
        _scrollView.delegate = self;
        _scrollView.maximumZoomScale = 2;
        _scrollView.minimumZoomScale = 1;
    
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.showsHorizontalScrollIndicator = YES;
        
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(bottomView);
        }];
        
       // [self setupGesture];
        
    }
    return self;
}

-(void)setShowImage:(UIImage *)showImage{
    _showImage = showImage;
    _imageView.image = showImage;
    _scrollView.contentSize = _showImage.size;
}
-(void)setupGesture{
    //单击
   // UITapGestureRecognizer *tapSingleClick = [];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeViewByDirectionTopOrDown:)];
    swipe.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
    [_scrollView addGestureRecognizer:swipe];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeViewByDirectionLeft:)];
     swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
     [_scrollView addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeViewByDirectionRight:)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        [_scrollView addGestureRecognizer:swipeRight];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchView:)];
    pinch.scale = 1;
    [_scrollView addGestureRecognizer:pinch];
}

//代理方法，高速scrollView药所放的是哪个视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
     CGFloat scrollW = CGRectGetWidth(scrollView.frame);
      CGFloat scrollH = CGRectGetHeight(scrollView.frame);

      CGSize contentSize = scrollView.contentSize;
      CGFloat offsetX = scrollW > contentSize.width ? (scrollW - contentSize.width) * 0.5 : 0;
      CGFloat offsetY = scrollH > contentSize.height ? (scrollH - contentSize.height) * 0.5 : 0;

      CGFloat centerX = contentSize.width * 0.5 + offsetX;
      CGFloat centerY = contentSize.height * 0.5 + offsetY;

      self.imageView.center = CGPointMake(centerX, centerY);
   
}
@end
