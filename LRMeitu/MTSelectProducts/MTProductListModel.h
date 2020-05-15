//
//  MTProductListModel.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/3/1.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//「 惊天霸戈: 这个图片的地址不是全的 」
//- - - - - - - - - - - - - - -
//前面要加上 API域名：測試用 http://60.250.137.141/CinchAPP/
//http://60.250.137.141/CinchAPP/prod_images/10680.png
//給的是相對路徑，不是絕對的
@interface MTProductListModel : NSObject
@property (nonatomic,assign) int no;

@property (nonatomic,strong) NSString *prodimg;
@property (nonatomic,assign) BOOL isSelect;
@end

NS_ASSUME_NONNULL_END
