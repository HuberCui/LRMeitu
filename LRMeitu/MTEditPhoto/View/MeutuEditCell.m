//
//  MeutuEditCell.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/27.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MeutuEditCell.h"
#import <Masonry.h>

@interface MeutuEditCell ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>
@property (strong, nonatomic)  UIImageView *imageView;
@property (nonatomic,strong) UIView *bottomView;

@end
@implementation MeutuEditCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _bottomView = bottomView;
        _bottomView.clipsToBounds = YES;
        [self.contentView addSubview:bottomView];

        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.userInteractionEnabled = YES;
        _imageView.clipsToBounds = YES;
        [bottomView addSubview:_imageView];
        
     
        UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
           [self.bottomView addGestureRecognizer:panGR];
           
           UIPinchGestureRecognizer *pinchGR = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
           pinchGR.delegate = self;
           [self.bottomView addGestureRecognizer:pinchGR];
           
           UIRotationGestureRecognizer *rotationGR = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
           rotationGR.delegate = self;
        //   [self.bottomView addGestureRecognizer:rotationGR];
           
           UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
           tapGR.numberOfTapsRequired = 2;
           [self.bottomView addGestureRecognizer:tapGR];
        
        
        _borderlayer = [[CALayer alloc]init];
        _borderlayer.frame = self.layer.bounds;
        [self.contentView.layer addSublayer:_borderlayer];

        
    }
    return self;
}

- (void)pan:(UIPanGestureRecognizer *)gr
{
    CGPoint translation = [gr translationInView:self.bottomView];
    CGPoint center = self.imageView.center;
    center.x += translation.x;
    center.y += translation.y;
    self.imageView.center = center;
    [gr setTranslation:CGPointZero inView:self.bottomView];
}

- (void)pinch:(UIPinchGestureRecognizer *)gr
{
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, gr.scale, gr.scale);
    gr.scale = 1;
}

- (void)rotation:(UIRotationGestureRecognizer *)gr
{
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, gr.rotation);
    gr.rotation = 0;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)tap:(UITapGestureRecognizer *)gr
{
    self.imageView.transform = CGAffineTransformIdentity;
}


-(void)setShowImage:(UIImage *)showImage{
    _showImage = showImage;
    _imageView.image = showImage;
//    _scrollView.contentSize = _showImage.size;
  //  NSLog(@"-----初始化的contentsize------%f--%f",_scrollView.contentSize.width,_scrollView.contentSize.height);
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
    
    
    //宽大于高
    if(self.contentView.frame.size.width > self.contentView.frame.size.height)
    {
        
        w = self.contentView.frame.size.width;
        h = w*imageData.size.height/imageData.size.width;
        if(h < self.contentView.frame.size.height){
            h = self.contentView.frame.size.height;
            w = h*imageData.size.width/imageData.size.height;
        }
        
    }else{
//        宽小于高
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
    
//    if (w <= self.frame.size.width || h <= self.frame.size.height) {
//        scale_w = w / self.frame.size.width;
//        scale_h = h / self.frame.size.height;
//        if (scale_w > scale_h) {
//            scale = scale_h;
//        }else{
//            scale = scale_w;
//        }
//    }
    
    @synchronized(self){
        _imageView.frame = rect;
        
       
        NSLog(@"------------%@",_imageView);
//        CAShapeLayer *maskLayer = [CAShapeLayer layer];
//        maskLayer.path = [self.realCellArea CGPath];
//        maskLayer.fillColor = [[UIColor redColor] CGColor];
//        maskLayer.frame = _imageView.frame;
//        self.layer.mask = maskLayer;
        
        _imageView.center = self.bottomView.center;
//        _warpScrollView.contentSize = CGSizeMake(10000, 10000);
//              _scrollView.center = CGPointMake(_warpScrollView.contentSize.width/2, _warpScrollView.contentSize.height/2);
//        if (rect.size.width > self.contentView.frame.size.width) {
//            _scrollView.contentOffset = CGPointMake((rect.size.width-self.contentView.frame.size.width)/2, 0);
//        }
//
//        _warpScrollView.contentOffset = CGPointMake((_warpScrollView.contentSize.width-rect.size.width)/2, (_warpScrollView.contentSize.height-rect.size.height)/2);
//        _minValue = scale/1.55;
//        _scrollView.minimumZoomScale = scale/1.55;
        
    //    [self setNeedsLayout];
        
    }
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
}



@end
