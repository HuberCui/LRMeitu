//
//  MTStyleModel.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/29.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTStyleModel : NSObject
@property (nonatomic,strong) NSString *unselectStyle;
@property (nonatomic,strong) NSString *selectStyle;
@property (nonatomic,assign) MTGridStyle style;
@end

NS_ASSUME_NONNULL_END
