//
//  LFStickerItem.m
//  LFMediaEditingController
//
//  Created by TsanFeng Lam on 2019/6/20.
//  Copyright © 2019 lincf0912. All rights reserved.
//

#import "MTStickerItem.h"
#import "NSAttributedString+MTCoreText.h"

@interface MTStickerItem ()

@property (nonatomic, assign) UIEdgeInsets textInsets; // 控制字体与控件边界的间隙
@property (nonatomic, strong) UIImage *textCacheDisplayImage;


@end

@implementation MTStickerItem

+ (instancetype)mainWithImage:(UIImage *)image
{
    MTStickerItem *item = [[self alloc] initMain];
    item.image = image;
    return item;
}


- (instancetype)initMain
{
    self = [self init];
    if (self) {
        _main = YES;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _textInsets = UIEdgeInsetsMake(5.f, 5.f, 5.f, 5.f);
    }
    return self;
}

- (void)setText:(NSAttributedString *)text
{
    _text = text;
    _textCacheDisplayImage = nil;
}



- (UIImage * __nullable)displayImage
{
    if (self.image) {
        return self.image;
    } else if (/*self.text.text.length || */self.text.length) {
        
        if (_textCacheDisplayImage == nil) {
            
            NSRange range = NSMakeRange(0, 1);
            CGSize textSize = [self.text LFME_sizeWithConstrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-(self.textInsets.left+self.textInsets.right), CGFLOAT_MAX)];
            NSDictionary *typingAttributes = [self.text attributesAtIndex:0 effectiveRange:&range];
            
            UIColor *textColor = [typingAttributes objectForKey:NSForegroundColorAttributeName];
            
            CGPoint point = CGPointMake(self.textInsets.left, self.textInsets.top);
            CGSize size = textSize;
            size.width += (self.textInsets.left+self.textInsets.right);
            size.height += (self.textInsets.top+self.textInsets.bottom);
            
            @autoreleasepool {
                /** 创建画布 */
                UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
                CGContextRef context = UIGraphicsGetCurrentContext();
                
//                UIColor *shadowColor = ([textColor isEqual:[UIColor blackColor]]) ? [UIColor whiteColor] : [UIColor blackColor];
//                CGColorRef shadow = [shadowColor colorWithAlphaComponent:0.8f].CGColor;
//                CGContextSetShadowWithColor(context, CGSizeMake(1, 1), 3.f, shadow);
                CGContextSetAllowsAntialiasing(context, YES);
                
                [self.text LFME_drawInContext:context withPosition:point andHeight:textSize.height andWidth:textSize.width];
                
                UIImage *temp = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                _textCacheDisplayImage = temp;
            }
            
        }
        
        return _textCacheDisplayImage;
    }
    return nil;
}

- (UIImage * __nullable)displayImageAtTime:(NSTimeInterval)time
{
    if (self.displayImage.images.count) {
        NSInteger frameCount = self.displayImage.images.count;
        NSTimeInterval duration = self.displayImage.duration / frameCount;
        NSInteger index = time / duration;
        index = index % frameCount;
        return [self.displayImage.images objectAtIndex:index];
    }
    return self.displayImage;
}

#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _main = [coder decodeBoolForKey:@"main"];
        _image = [coder decodeObjectForKey:@"image"];
        
        _textCacheDisplayImage = [coder decodeObjectForKey:@"textCacheDisplayImage"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeBool:self.isMain forKey:@"main"];
    [coder encodeObject:self.image forKey:@"image"];
   
    [coder encodeObject:_textCacheDisplayImage forKey:@"textCacheDisplayImage"];
}

+ (BOOL)supportsSecureCoding
{
    return YES;
}


- (UIView * __nullable)displayView
{
    if (self.image) {
        CGSize showSize = CGSizeMake(100, 100);
        if (self.image.size.width > 100) {
                   showSize = CGSizeMake(100.0, self.image.size.height *100.0/self.image.size.width);
               }
        
        
        UIView *view = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, showSize}];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:view.bounds];
         imageView.image = self.displayImage;
        [view addSubview:imageView];
       
        return view;
    }  else if (self.text) {
        UIView *view = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, self.displayImage.size}];
        view.layer.contents = (__bridge id _Nullable)(self.displayImage.CGImage);
//        view.layer.shadowOpacity = .8;
//        view.layer.shadowRadius = 3.0;
//        view.layer.shadowColor = ([self.textColor isEqual:[UIColor blackColor]]) ? [UIColor whiteColor].CGColor : [UIColor blackColor].CGColor;
//        view.layer.shadowOffset = CGSizeMake(1, 1);
//        UIBezierPath *path = [UIBezierPath bezierPathWithRect:view.bounds];
//        view.layer.shadowPath = path.CGPath;
        return view;
    }
    NSLog(@"%@ has no displayview available", self);
    return nil;
}
@end
