//
//  FoodAPI.h
//  Network
//
//  Created by 宋链 on 2019/9/2.
//  Copyright © 2019 宋链. All rights reserved.
//

#import "NetworkAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTAPI : NetworkAPI

/**
 验证api

 */
+(instancetype)GET_TipsMessage:(NSString *)partnerID;

+(instancetype)GET_Colors:(NSString *)partnerID;
+(instancetype)GET_Products:(NSString *)partnerID;
@end

NS_ASSUME_NONNULL_END
