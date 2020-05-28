//
//  MTSelectPhotoCell.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTSelectPhotoCell.h"
@interface MTSelectPhotoCell()<UIScrollViewDelegate>
@property (strong, nonatomic)  UIImageView *imageView;


@end
@implementation MTSelectPhotoCell
- (void)deleteSelectImage:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteImageWithBbuttontag:)]) {
        [self.delegate deleteImageWithBbuttontag:sender.tag];
    }
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIImageView *selectImageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selectPhoto"]];
        self.selectImageView = selectImageview;
        [self.contentView addSubview:selectImageview];
        [selectImageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.contentView);
        }];
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _scrollView.userInteractionEnabled = NO;
        [self.contentView addSubview:_scrollView];
        
        UIView *bottomView = [UIView new];
        
        [_scrollView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_scrollView);
            make.width.height.mas_equalTo(_scrollView);
        }];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.userInteractionEnabled = YES;
        [bottomView addSubview:_imageView];
        
        _scrollView.delegate = self;
        _scrollView.maximumZoomScale = 2;
        _scrollView.minimumZoomScale = 0.5;
        _scrollView.contentSize = _showImage.size;
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.showsHorizontalScrollIndicator = YES;
        
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(bottomView);
        }];
        
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
        self.deleteBtn = deleteBtn;
        [deleteBtn setImage:[UIImage imageNamed:@"deletePhoto"] forState:UIControlStateNormal];
         deleteBtn.backgroundColor = [UIColor grayColor];
        [deleteBtn addTarget:self action:@selector(deleteSelectImage:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:deleteBtn];
        
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(12);
            make.right.mas_equalTo(self.contentView).offset(-12);
            make.width.height.mas_equalTo(20);
        }];
        
       // [self setupGesture];
        
    }
    return self;
}

-(void)setShowImage:(UIImage *)showImage{
    _showImage = showImage;
    _imageView.image = showImage;
   // _scrollView.contentSize = _showImage.size;
    [self setImageViewData:showImage];
}

- (void)setImageViewData:(UIImage *)imageData
{
    
    if (imageData == nil) {
        return;
    }
    
    CGRect rect  = CGRectZero;
    CGFloat scale = 1.0f;
    CGFloat w = 0.0f;
    CGFloat h = 0.0f;
    
    
    
    if(self.contentView.frame.size.width > self.contentView.frame.size.height)
    {
        
        w = self.contentView.frame.size.width;
        h = w*imageData.size.height/imageData.size.width;
        if(h < self.contentView.frame.size.height){
            h = self.contentView.frame.size.height;
            w = h*imageData.size.width/imageData.size.height;
        }
        
    }else{
        
        h = self.contentView.frame.size.height;
        w = h*imageData.size.width/imageData.size.height;
        if(w < self.contentView.frame.size.width){
            w = self.contentView.frame.size.width;
            h = w*imageData.size.height/imageData.size.width;
        }
    }
    rect.size = CGSizeMake(w, h);
    
    CGFloat scale_w = w / imageData.size.width;
    CGFloat scale_h = h / imageData.size.height;
    if (w > self.frame.size.width || h > self.frame.size.height) {
        scale_w = w / self.frame.size.width;
        scale_h = h / self.frame.size.height;
        if (scale_w > scale_h) {
            scale = 1/scale_w;
        }else{
            scale = 1/scale_h;
        }
    }
    
    if (w <= self.frame.size.width || h <= self.frame.size.height) {
        scale_w = w / self.frame.size.width;
        scale_h = h / self.frame.size.height;
        if (scale_w > scale_h) {
            scale = scale_h;
        }else{
            scale = scale_w;
        }
    }
    
    @synchronized(self){
        _imageView.frame = rect;
//        CAShapeLayer *maskLayer = [CAShapeLayer layer];
//        maskLayer.path = [self.realCellArea CGPath];
//        maskLayer.fillColor = [[UIColor redColor] CGColor];
//        maskLayer.frame = _imageView.frame;
//        self.layer.mask = maskLayer;
        
        [_scrollView setZoomScale:1 animated:YES];
        
        [self setNeedsLayout];
        
    }
    
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


