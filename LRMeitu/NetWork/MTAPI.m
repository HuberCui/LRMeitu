//
//  FoodAPI.m
//  Network
//
//  Created by 宋链 on 2019/9/2.
//  Copyright © 2019 宋链. All rights reserved.
//

#import "MTAPI.h"
#import <MJExtension/MJExtension.h>
@implementation MTAPI
+ (instancetype)apiWithURLString:(NSString *)URLString
                      HTTPMethod:(NetworkHTTPMethod)HTTPMethod
                      parameters:(id)parameters
{
    MTAPI *API = [super apiWithURLString:URLString HTTPMethod:HTTPMethod parameters:parameters];
    API.joinURLStringBlock = ^(NetworkAPI *API) {
        API.fullURLString = [NSString stringWithFormat:@"%@%@", BaseUrl, API.URLString];
    };
    return API;
}

//http://60.250.137.141/member.php?partnerID=173&invoke=slogan&token=573eb312af42bdb59e64747023fade27&formData={"show":"1"}
+(instancetype)GET_TipsMessage:(NSString *)partnerID {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"573eb312af42bdb59e64747023fade27" forKey:@"token"];
    [dic setValue:@"slogan" forKey:@"invoke"];

    NSDictionary *formData = @{@"show":@"1"};
    
    NSString * tmp = [formData mj_JSONString];
    [dic setValue:tmp forKey:@"formData"];
    [dic setValue:partnerID forKey:@"partnerID"];
    return [self apiWithURLString:@"member.php"
                       HTTPMethod:NetworkHTTPMethodGET                       parameters:dic];

}

+(instancetype)GET_Colors:(NSString *)partnerID{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
       [dic setValue:@"573eb312af42bdb59e64747023fade27" forKey:@"token"];
       [dic setValue:@"color" forKey:@"invoke"];

       NSDictionary *formData = @{@"show":@"1"};
       
       NSString * tmp = [formData mj_JSONString];
       [dic setValue:tmp forKey:@"formData"];
       [dic setValue:partnerID forKey:@"partnerID"];
       return [self apiWithURLString:@"member.php"
                          HTTPMethod:NetworkHTTPMethodGET                       parameters:dic];

}
+(instancetype)GET_Products:(NSString *)partnerID{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
       [dic setValue:@"573eb312af42bdb59e64747023fade27" forKey:@"token"];
       [dic setValue:@"prodimg" forKey:@"invoke"];

       NSDictionary *formData = @{@"show":@"1"};
       
       NSString * tmp = [formData mj_JSONString];
       [dic setValue:tmp forKey:@"formData"];
       [dic setValue:partnerID forKey:@"partnerID"];
       return [self apiWithURLString:@"member.php"
                          HTTPMethod:NetworkHTTPMethodGET                       parameters:dic];

}
@end
