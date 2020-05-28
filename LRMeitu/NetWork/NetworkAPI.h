

#import <Foundation/Foundation.h>
#import "NetworkResponse.h"
#import "NetworkUpload.h"

NS_ASSUME_NONNULL_BEGIN

#define BaseUrl @"http://"
typedef NS_ENUM(NSUInteger, NetworkParametersType) {
    NetworkParametersTypeDefault,
    NetworkParametersTypeNormal,
    NetworkParametersTypeBody,
};

typedef NS_ENUM(NSUInteger, NetworkHTTPMethod) {
    NetworkHTTPMethodGET,
    NetworkHTTPMethodPOST,
    NetworkHTTPMethodPUT,
    NetworkHTTPMethodDELETE,
    NetworkHTTPMethodPATCH,
};

typedef NS_ENUM(NSUInteger, NetworkRequestResult) {
    NetworkRequestResultSuccess,        //  请求结果为成功
    NetworkRequestResultFailure,        //  请求结果为失败
    NetworkRequestResultNotConnection   //  没有连接上服务器
};

@class NetworkAPI;

typedef void(^NetworkBlock)(NetworkAPI *API);


@interface NetworkAPI : NSObject

//  基本服务器地址
@property (copy, nonatomic) NSString *baseURLString;

//  请求地址
@property (copy, nonatomic) NSString *URLString;
//  请求参数
@property (strong, nonatomic) id parameters;
//  请求方式
@property (assign, nonatomic) NetworkHTTPMethod HTTPMethod;
//  上传数组，上传文件的话需要实现这个数组
@property (strong, nonatomic) NSMutableArray<NetworkUpload *> *uploads;

//  请求结果
@property (assign, nonatomic) NetworkRequestResult requestResult;
//  服务器返回的数据
@property (strong, nonatomic) NetworkResponse *response;

//  没有连接上的回调
@property (copy, nonatomic) NetworkBlock notConnectionBlock;
//  连接上但请求结果为失败的回调
@property (copy, nonatomic) NetworkBlock failureBlock;
//  请求完成的回调
@property (copy, nonatomic) NetworkBlock completionBlock;
//  请求进度的回调
@property (copy, nonatomic) NetworkBlock progressBlock;

//  请求进度
@property (strong, nonatomic) NSProgress *progress;
//  请求所花费的时间
@property (readonly) NSTimeInterval costTime;
//  请求错误
@property (strong, nonatomic) NSError *error;

//  简便方法，是否请求成功
@property (readonly) BOOL isRequestSuccess;

//  token
@property (copy, nonatomic) NSString *token;
//  userName
@property (copy, nonatomic) NSString *userName;

//  参数类型
@property (assign, nonatomic) NetworkParametersType parametersType;

//  原始数据
@property (strong, nonatomic) id rawResponse;

//  完整URL
@property (copy, nonatomic) NSString *fullURLString;
//  加密参数
@property (strong, nonatomic) id encodeParameters;

//  解密数据block
@property (copy, nonatomic) NetworkBlock decodeResponseBlock;
//  加密参数Block
@property (copy, nonatomic) NetworkBlock encodeParametersBlock;
//  拼接 URL Block
@property (copy, nonatomic) NetworkBlock joinURLStringBlock;

@property (nonatomic, strong) NSURLSessionDataTask *task;

//  开始请求时间
@property (nonatomic, assign) NSTimeInterval startTime;
//  结束时间
@property (nonatomic, assign) NSTimeInterval endTime;

//  请求头
@property (nonatomic, copy) NSDictionary *HTTPHeaderFields;

@property (nonatomic, readonly) NSInteger *statusCode;


/**
 API便利构造器

 @param URLString 请求地址
 @param HTTPMethod 请求方法
 @param parameters 请求参数
 @return API
 */
+ (instancetype)apiWithURLString:(NSString *)URLString
                      HTTPMethod:(NetworkHTTPMethod)HTTPMethod
                      parameters:(nullable id)parameters;


/**
 API开始请求

 @return API
 */
- (instancetype)request;

/**
 简便方法，设置请求完成的回调，同时开始进行请求

 @param completion 请求完成的回调
 @return API
 */
- (instancetype)completion:(NetworkBlock)completion;

@end


typedef NS_ENUM(NSUInteger, NetworkAPIsRequestType) {
    NetworkAPIsRequestTypeAsync,    //  异步队列请求
    NetworkAPIsRequestTypeSync,     //  同步队列请求
};

@class NetworkAPIs;

typedef void(^NetworksBlock)(NetworkAPIs *APIs);

@interface NetworkAPIs : NSObject

@property (strong, nonatomic) NSMutableArray<NetworkAPI *> *queue;
@property (assign, nonatomic) NetworkAPIsRequestType requestType;

@property (copy, nonatomic) NetworksBlock completionsBlock;

//  简便方法，是否请求成功
@property (readonly) BOOL isRequestSuccess;

/**
 APIs便利构造器

 @param queue 要请求的API数组
 @return APIs
 */
+ (instancetype)apisWithQueue:(NSArray<NetworkAPI *> *)queue;

/**
 APIs开始请求

 @return APIs
 */
- (instancetype)request;

/**
 简便方法，设置请求完成的回调，同时开始进行请求

 @param completions 请求完成的回调
 @return APIs
 */
- (instancetype)completions:(NetworksBlock)completions;


@end

NS_ASSUME_NONNULL_END
