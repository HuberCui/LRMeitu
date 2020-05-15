//
//  MTKeyBoardView.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/3/5.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTKeyBoardView.h"

#define MaxTextViewHeight 80//限制输入文字的高度
@interface MTKeyBoardView()<UITextViewDelegate,UIScrollViewDelegate>
{
    BOOL statusTextView;//当文字大于限定高度之后的状态
    NSString *placeholderText;//z设置占位符的文字
}

@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic,strong) UILabel *placeholderLabel;
@property (nonatomic,strong) UIButton *sendButton;
@end
@implementation MTKeyBoardView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addConstraint];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    
//    点击空白区取消
    
    UITapGestureRecognizer *centerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerTapClick)];
    [self addGestureRecognizer:centerTap];
    return self;
}

-(void)addConstraint{
   
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backGroundView).offset(6);
        make.left.mas_equalTo(self.backGroundView).offset(5);
        make.bottom.mas_equalTo(self.backGroundView).offset(-6);
        make.width.mas_equalTo(kScreenWidth-65);
    }];
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backGroundView).offset(5);
        make.left.mas_equalTo(self.backGroundView).offset(10);
        make.height.mas_equalTo(39);
    }];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backGroundView).offset(8);
        make.right.mas_equalTo(self.backGroundView).offset(-5);
        make.width.mas_equalTo(50);
    }];
}

-(void)keyboardWillShow:(NSNotification *)notify{
    self.frame = [UIScreen mainScreen].bounds;
    NSDictionary *userInfo = [notify userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
   
    CGFloat height = keyboardRect.size.height;
    CGFloat keyboardY = keyboardRect.origin.y;
    self.backGroundView.frame = CGRectMake(0, keyboardY-49-TopBarHeight, kScreenWidth, 49);
    
}

-(void)keyboardWillHide:(NSNotification *)notify{
 
    self.backGroundView.frame = CGRectMake(0, 0, kScreenWidth, 49);
    self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 49);
    
}

-(void)centerTapClick{
    [self.textView resignFirstResponder];
}
-(void)layoutSubviews{
    [super layoutSubviews];

}
-(void)sendClick:(UIButton *)sender{
    [self.textView endEditing:YES];
    
    if (self.TextBlcok) {
        self.TextBlcok(self.textView.attributedText);
    }
    
    self.textView.text = nil;
    self.placeholderLabel.text = placeholderText;
     [self.sendButton setBackgroundColor:RGBColor(180, 180, 180)];
    self.sendButton.userInteractionEnabled = NO;
    
    self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 49);
    self.backGroundView.frame = CGRectMake(0, 0, kScreenWidth, 49);
}
#pragma mark UITextViewDelegate

-(void)textViewDidChange:(UITextView *)textView{
    if (textView.attributedText.length == 0) {
        self.placeholderLabel.text = placeholderText;
        [self.sendButton setBackgroundColor:RGBColor(180, 180, 180)];
        self.sendButton.userInteractionEnabled = NO;
    }else{
        self.placeholderLabel.text = nil;
        [self.sendButton setBackgroundColor:RGBColor(70, 163, 231)];
               self.sendButton.userInteractionEnabled = YES;
    }
    
    CGSize size = CGSizeMake(kScreenWidth-65, CGFLOAT_MAX);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16],NSFontAttributeName, nil];
    CGFloat curheight = [textView.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    CGFloat y = CGRectGetMaxY(self.backGroundView.frame);
    
    if (curheight < 19.094) {
        statusTextView = NO;
        self.backGroundView.frame = CGRectMake(0, y-49, kScreenWidth, 49);
    }else if (curheight < MaxTextViewHeight){
        statusTextView = NO;
        self.backGroundView.frame = CGRectMake(0, y-textView.contentSize.height-10, kScreenWidth, textView.contentSize.height+10);
    }else{
        statusTextView = YES;
        return;
    }
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (statusTextView == NO) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }else{
        
    }
}

- (void)setPlaceholderText:(NSString *)text{
    placeholderText = text;
    self.placeholderLabel.text = text;
}

- (UIView *)backGroundView{
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
        _backGroundView.backgroundColor = RGBColor(230, 230, 230);
      
        [self addSubview:_backGroundView];
    }
    return _backGroundView;
}

- (UITextView *)textView{
    if (_textView == nil) {
        _textView =[[UITextView alloc]init];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.delegate = self;
        _textView.layer.cornerRadius = 5;
        [self.backGroundView addSubview:_textView];
    }
    return _textView;
}

- (UILabel *)placeholderLabel{
    if (_placeholderLabel == nil) {
        _placeholderLabel = [UILabel new];
        _placeholderLabel.font = [UIFont systemFontOfSize:16];
        _placeholderLabel.textColor = [UIColor grayColor];
        [self.backGroundView addSubview:_placeholderLabel];
    }
    return _placeholderLabel;
}

- (UIButton *)sendButton{
    if (_sendButton == nil) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setBackgroundColor:RGBColor(180, 180, 180)];
        [_sendButton setTitle:@"更改" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendClick:) forControlEvents:UIControlEventTouchUpInside];
        _sendButton.layer.cornerRadius = 5;
        _sendButton.userInteractionEnabled = NO;
        [self.backGroundView addSubview:_sendButton];
    }
    return _sendButton;
}

@end
