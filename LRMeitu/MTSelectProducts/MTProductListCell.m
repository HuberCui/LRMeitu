//
//  MTProductListCell.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTProductListCell.h"
#import <SDWebImage.h>
@implementation MTProductListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
}
-(void)setListModel:(MTProductListModel *)listModel{
    _listModel = listModel;
     self.productImageView.image = listModel.showImage;
//    if (self.fromborder_pro == FromBoder) {
//
//    }else{
//
//        NSURL *imgurl = [NSURL URLWithString:listModel.prodimg];//IMAGE_URL(listModel.prodimg);
//           [self.productImageView sd_setImageWithURL:imgurl];
//    }
    
//    if (listModel.isSelect) {
//            self.productSelectView.hidden = NO;
//        }else{
//            self.productSelectView.hidden = YES;
//        }
//
//    self.selected = listModel.isSelect;
}
-(void)setSelected:(BOOL)selected{
   [super setSelected:selected];

    if (selected) {
        self.productSelectView.hidden = NO;
    }else{
        self.productSelectView.hidden = YES;
    }

}

@end
