//
//  MTSelectPhotoCell.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "MTSelectPhotoCell.h"

@implementation MTSelectPhotoCell
- (IBAction)deleteSelectImage:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteImageWithBbuttontag:)]) {
        [self.delegate deleteImageWithBbuttontag:sender.tag];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.deleteBtn.backgroundColor = [UIColor grayColor];
}

@end
