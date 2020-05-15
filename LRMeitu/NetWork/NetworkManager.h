

#import <Foundation/Foundation.h>

@class NetworkAPI;
@class NetworkAPIs;

@interface NetworkManager : NSObject

//  网络请求单例
@property (readonly, nonatomic, class) NetworkManager *sharedManager;

/**
 单个API的请求
 
 @param API 要请求的API
 */
- (void)requestWithAPI:(NetworkAPI *)API;

/**
 API队列的请求
 
 @param APIs 要请求的API队列
 */
- (void)requestWithAPIs:(NetworkAPIs *)APIs;

@end
