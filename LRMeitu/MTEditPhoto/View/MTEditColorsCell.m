//
//  MTEditColorsCell.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/3/2.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTEditColorsCell.h"

@implementation MTEditColorsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setColorModel:(MTEditColorModel *)colorModel{
    _colorModel = colorModel;
    self.smallView.backgroundColor = [UIColor mt_colorWithHexString:colorModel.color];
    if (self.selected) {
        self.bigView.mt_borderColor = [UIColor mt_colorWithHexString:colorModel.color];
    }else{
        self.bigView.mt_borderColor = [UIColor clearColor];;
    }
}
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (self.selected) {
        self.bigView.mt_borderColor = [UIColor mt_colorWithHexString:_colorModel.color];
    }else{
        self.bigView.mt_borderColor = [UIColor clearColor];;
    }
}
@end
