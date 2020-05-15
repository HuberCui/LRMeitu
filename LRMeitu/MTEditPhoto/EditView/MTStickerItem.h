//
//  LFStickerItem.h
//  LFMediaEditingController
//
//  Created by TsanFeng Lam on 2019/6/20.
//  Copyright © 2019 lincf0912. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface MTStickerItem : NSObject <NSSecureCoding>

@property (nonatomic, assign, readonly, getter=isMain) BOOL main;

/** image/gif */
@property (nonatomic, strong) UIImage *image;

/** text */
@property (nonatomic, strong) NSAttributedString *text;


/** display(image/text) */
- (UIImage * __nullable)displayImage;
- (UIImage * __nullable)displayImageAtTime:(NSTimeInterval)time;

/** main view */
+ (instancetype)mainWithImage:(UIImage *)image;

- (UIView * __nullable)displayView;
@end

NS_ASSUME_NONNULL_END
