//
//  MTStyleSelectCell.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTStyleSelectCell.h"

@implementation MTStyleSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setStyleModel:(MTStyleModel *)styleModel{
    _styleModel = styleModel;
    if (self.selected) {
         self.styleImageView.image = [UIImage imageNamed:styleModel.selectStyle];
    }else{
         self.styleImageView.image = [UIImage imageNamed:styleModel.unselectStyle];
    }
   
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (self.selected) {
            self.styleImageView.image = [UIImage imageNamed:self.styleModel.selectStyle];
       }else{
            self.styleImageView.image = [UIImage imageNamed:self.styleModel.unselectStyle];
       }
}
@end
