//
//  MeituEditViewController.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/27.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MeituEditViewController.h"
#import "MeutuEditCell.h"
#import "MeituShowViewController.h"
#import <CHTCollectionViewWaterfallLayout.h>
#import "MTFallWaterLayoutConfig.h"
#import "MyLayout.h"
#import "MTEditStyleSelectView.h"
#import "MTEditBaseHeaderView.h"
#import "MTEdgesView.h"
#import "MTStickerView.h"
#import "MTStickerItem.h"
#import <MJExtension/MJExtension.h>
#import "MTKeyBoardView.h"
#import "EmoticonsHelper.h"
#import "MTProductListViewController.h"
@interface MeituEditViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,CHTCollectionViewDelegateWaterfallLayout,MTEditEmotionViewDelegate,MTEditTextViewDelegate,MTEditEdgesViewDelegate,MTEditBorderViewDelegate,MTEditStyleSelectViewDelegate,MTEditBaseHeaderViewDelegate,MTProductListViewControllerDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;


@property (nonatomic,strong) MTFallWaterLayoutConfig *layoutconfig;

@property (nonatomic,strong) MTEdgesView *edgesView;
@property (nonatomic,strong) MTStickerView *stickerView;

@property (nonatomic,strong) MTKeyBoardView *keyBoardView;
@property (nonatomic,strong) UIView *boardView;//画板

@property (nonatomic,strong) NSString *borderColor;
@property (nonatomic,assign) float borderWidth;

@property (nonatomic,strong) UIImage *showImage;

@property (nonatomic,strong) MTEditStyleSelectView *styleSelectView;
@property (nonatomic,assign) BOOL isClose;

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *scrollBottomView;
@end

@implementation MeituEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"拼图";
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    _isClose = NO;
    _borderColor = @"FFFFFF";
    _borderWidth = 0;
  
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithTitle:@"保存"style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = btnItem;
    // Do any additional setup after loading the view.
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.scrollBottomView];
    
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-BottomHeight);
    }];
    
    [self.scrollBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.scrollView);
        make.bottom.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(self.scrollView);
    }];
    
    [self.scrollBottomView addSubview:self.boardView];
    [self.boardView addSubview:self.collectionView];
    
    
    
    MTEditStyleSelectView *styleView = [[MTEditStyleSelectView alloc]initWithDelegate:self frame:CGRectZero];
    _styleSelectView = styleView;
    styleView.delegate = self;
    [self.scrollBottomView addSubview:styleView];
    
    
    [styleView mas_makeConstraints:^(MASConstraintMaker *make) {
        // make.top.mas_equalTo(self.b.mas_bottom);
        make.left.right.mas_equalTo(self.scrollBottomView);
        make.bottom.mas_equalTo(self.scrollBottomView);
        make.height.mas_equalTo(225);
    }];
    
    
    [self.scrollBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(styleView.mas_bottom);
    }];
    
    
    [self.boardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.scrollBottomView);
        // make.top.mas_equalTo(self.view).priorityHigh();
        make.height.mas_equalTo(self.boardView.mas_width).multipliedBy(500.0/375.0);
        make.bottom.mas_equalTo(styleView.mas_top);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.boardView);
    }];
    
    [self.boardView addSubview:self.stickerView];
    [self.boardView addSubview:self.edgesView];
    [self.view addSubview:self.keyBoardView];
    
    
  //  self.collectionView.backgroundColor = [UIColor cyanColor];
    __weak typeof(self) weakSelf = self;
    self.stickerView.tapEnded = ^(MTStickerItem * _Nonnull item, BOOL isActive) {
        
        if (isActive) { /** 选中的情况下点击 */
            MTStickerItem *item = [weakSelf.stickerView getSelectStickerItem];
            if (item.text) {
                // weakSelf.keyBoardView.textView.text = [weakSelf textString:item.text];
                weakSelf.keyBoardView.textView.attributedText = item.text;
                [weakSelf.keyBoardView setPlaceholderText:@""];
                [weakSelf.keyBoardView.textView becomeFirstResponder];
              
            }
        }
    };
    [self.stickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.boardView);
    }];
    [self.edgesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.boardView);
    }];
    //
}
//把带有图片的属性字符串转成普通的字符串
- (NSString *)textString:(NSAttributedString *)attributedText
{
    NSMutableAttributedString * resutlAtt = [[NSMutableAttributedString alloc]initWithAttributedString:attributedText];
    EmoticonsHelper * helper = [EmoticonsHelper new];
    //枚举出所有的附件字符串
    [attributedText enumerateAttributesInRange:NSMakeRange(0, attributedText.length) options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        //从字典中取得那一个图片
        NSTextAttachment * textAtt = attrs[@"NSAttachment"];
        if (textAtt)
        {
            UIImage * image = textAtt.image;
            NSString * text = [helper stringFromImage:image];
            [resutlAtt replaceCharactersInRange:range withString:text];
        }
    }];
    return resutlAtt.string;
}

#pragma mark 更换选中文字
-(void)changeSelectText:(NSAttributedString *)changeStr{
    MTStickerItem *newitem = [MTStickerItem new];
    newitem.text = changeStr;
    [self.stickerView changeSelectStickerItem:newitem];
    
    
}


#pragma mark MTEditStyleSelectViewDelegate
-(void)selectAndAddText{
    MTStickerItem *item = [MTStickerItem new];
    item.text = [[NSAttributedString alloc]initWithString:@"点击修改文字" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    // item.image = [UIImage imageNamed:@"emotion_selected"];
    [self.stickerView createSticker:item];
}

#pragma mark MTEditBaseHeaderViewDelegate
-(void)previewEditPhoto{
    UIGraphicsBeginImageContext(self.collectionView.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.boardView.layer renderInContext:ctx];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    MeituShowViewController *vc =[[MeituShowViewController alloc]init];
    vc.showImage = newImage;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)expandDownView:(BOOL)isClose{
    _isClose = isClose;
    self.styleSelectView.isClose = isClose;
    if (isClose) {
        [self.boardView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.scrollBottomView).offset(67);
            make.left.right.mas_equalTo(self.scrollBottomView);
            
            make.height.mas_equalTo(self.boardView.mas_width).multipliedBy(500.0/375.0);
            make.bottom.mas_equalTo(self.styleSelectView.mas_top);
        }];
        [self.styleSelectView mas_remakeConstraints:^(MASConstraintMaker *make) {
            // make.top.mas_equalTo(self.b.mas_bottom);
            make.left.right.mas_equalTo(self.scrollBottomView);
            make.bottom.mas_equalTo(self.scrollBottomView);
            make.height.mas_equalTo(158);
        }];
    }else{
        
        [self.boardView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self.scrollBottomView);
            // make.top.mas_equalTo(self.view).priorityHigh();
            make.height.mas_equalTo(self.boardView.mas_width).multipliedBy(500.0/375.0);
            make.bottom.mas_equalTo(self.styleSelectView.mas_top);
        }];
        
        [self.styleSelectView mas_remakeConstraints:^(MASConstraintMaker *make) {
            // make.top.mas_equalTo(self.b.mas_bottom);
            make.left.right.mas_equalTo(self.scrollBottomView);
            make.bottom.mas_equalTo(self.scrollBottomView);
            make.height.mas_equalTo(225);
        }];
    }
    
}
#pragma mark MTEditEmotionViewDelegate

-(void)addOneEmotionWithImage:(UIImage *)emotion{
    if (emotion) {
        MTStickerItem *item = [MTStickerItem new];
        item.image = emotion;
        // item.image = [UIImage imageNamed:@"emotion_selected"];
        [self.stickerView createSticker:item];
    }
}
-(void)addMoreProductPicture{
    MTProductListViewController *productvc = [[MTProductListViewController alloc]init];
    productvc.delegate = self;
    [self.navigationController pushViewController:productvc animated:YES];
}

#pragma mark MTProductListViewControllerDelegate
- (void)selectProductImage:(NSMutableArray *)selectProduct{
    [self.styleSelectView.productArray addObjectsFromArray:selectProduct];
    [self.styleSelectView reloadCollectionData];
}

#pragma mark MTEditTextViewDelegate
-(void)changeSelectTextcolorWithColor:(NSString *)color{
    MTStickerItem *item = [self.stickerView getSelectStickerItem];
    if (item.text) {
        MTStickerItem *newitem = [MTStickerItem new];
     
        newitem.text = [[NSAttributedString alloc]initWithString:[self textString:item.text] attributes:@{NSForegroundColorAttributeName:[UIColor mt_colorWithHexString:color]}];
        // item.image = [UIImage imageNamed:@"emotion_selected"];
        [self.stickerView changeSelectStickerItem:newitem];
        
        
    }
    
}
#pragma mark MTEditEdgesViewDelegate
- (void)addEdgeWithImage:(UIImage *)edgeImage{
    self.edgesView.edgeImage = edgeImage;
}
#pragma mark MTEditBorderViewDelegate

-(void)addBorderWithSelectColor:(NSString *)color{
    _borderColor = color;
    [self.collectionView reloadData];
}
-(void)changeBorderWidthWithValue:(float)value{
    _borderWidth = value;
    [self.collectionView reloadData];
}

-(void)save{
    
    /**
     将 UIView 转换成 UIImage
     
     @param view 将要转换的View
     @return 新生成的 UIImage 对象
     */
    
    
    UIGraphicsBeginImageContext(self.collectionView.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.boardView.layer renderInContext:ctx];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    MeituShowViewController *vc =[[MeituShowViewController alloc]init];
    vc.showImage = newImage;
    [self.navigationController pushViewController:vc animated:YES];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.layoutconfig.sizeArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MeutuEditCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MeutuEditCell" forIndexPath:indexPath];
    UIImage *img = self.imageArray[indexPath.item];
    cell.showImage = img;
    cell.mt_borderColor = [UIColor mt_colorWithHexString:_borderColor];
    cell.mt_borderWidth = _borderWidth;
    
    //    cell.lab.textColor = [UIColor redColor];
    //    cell.lab.text = [NSString stringWithFormat:@"%ld",indexPath.item];
    return cell;
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

//当移动结束的时候会调用这个方法。
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    /**
     *sourceIndexPath 原始数据 indexpath
     * destinationIndexPath 移动到目标数据的 indexPath
     */
    UIImage *img = self.imageArray[sourceIndexPath.row];
    [self.imageArray removeObjectAtIndex:sourceIndexPath.row];
    
    
    
    [self.imageArray insertObject:img atIndex:destinationIndexPath.row];
    
}
#pragma mark - 手势事件
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    
    CGPoint point = [longPress locationInView:_collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            
            if (!indexPath) {
                break;
            }
            
            BOOL canMove = [_collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            if (!canMove) {
                break;
            }
            break;
            
        case UIGestureRecognizerStateChanged:
            [_collectionView updateInteractiveMovementTargetPosition:point];
            break;
            
        case UIGestureRecognizerStateEnded:
            [_collectionView endInteractiveMovement];
            break;
            
        default:
            [_collectionView cancelInteractiveMovement];
            break;
    }
    
}
//单独设置每个item的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//  return CGSizeMake(kScreenWidth / 2-2, 175);
//}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"======");
//}
#pragma mark CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //  return CGSizeMake((collectionView.frame.size.width-14-14-8)/2, (collectionView.frame.size.height-14-14-8)/2);
    return [self.layoutconfig.sizeArray[indexPath.item] CGSizeValue];
}


//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了 %ld %ld",indexPath.section,indexPath.item);
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        self.layoutconfig = [[MTFallWaterLayoutConfig alloc]initWithMTGridStyle:self.imageArray.count-1 CollectionViewSize:CGSizeMake(kScreenWidth, MTEditCollectionViewHeight)];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, MTEditCollectionViewHeight) collectionViewLayout:self.layoutconfig.waterflowlayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        //        _collectionView.pagingEnabled = YES;
        //        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //   _collectionView.allowsSelection = YES;
        [_collectionView registerClass:[MeutuEditCell class] forCellWithReuseIdentifier:@"MeutuEditCell"];
        //  [_collectionView registerNib:[UINib nibWithNibName:@"MeutuEditCell" bundle:nil] forCellWithReuseIdentifier:@"MeutuEditCell"];
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        [_collectionView addGestureRecognizer:longPressGesture];
    }
    return _collectionView;
}


-(MTStickerView *)stickerView{
    if (_stickerView == nil) {
        _stickerView = [MTStickerView new];
    }
    return _stickerView;
}

- (MTEdgesView *)edgesView{
    if (_edgesView == nil) {
        _edgesView = [MTEdgesView new];
    }
    return _edgesView;
}
-(NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (UIView *)boardView{
    if (_boardView == nil) {
        _boardView = [UIView new];
    }
    return _boardView;
}
- (MTKeyBoardView *)keyBoardView{
    if (_keyBoardView == nil) {
        _keyBoardView = [[MTKeyBoardView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 49)];
        _boardView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
//        _keyBoardView.backgroundColor = [UIColor yellowColor];
        [_keyBoardView setPlaceholderText:@"请输入文字"];
        __weak typeof(self) weakSelf = self;
        _keyBoardView.TextBlcok = ^(NSAttributedString * _Nonnull text) {
            NSLog(@"---%@",text);
            [weakSelf changeSelectText:text];
        };
        
        
    }
    return _keyBoardView;
}

-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIView *)scrollBottomView{
    if (_scrollBottomView == nil) {
        _scrollBottomView = [UIView new];
    }
    return _scrollBottomView;
}
@end
