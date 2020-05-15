//
//  MTKeyBoardView.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/3/5.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^MTTextViewBlock)(NSAttributedString *text);
@interface MTKeyBoardView : UIView
@property (nonatomic,strong) UITextView *textView;

/* 发送文本 */
@property (nonatomic,copy) MTTextViewBlock TextBlcok;
/* 设置占位符 */
-(void)setPlaceholderText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
