

#import "NetworkManager.h"
#import "NetworkAPI.h"
#import "NetworkResponse.h"
#import "NetworkUpload.h"
#import <AFNetworking.h>


@interface NetworkManager ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation NetworkManager

+ (NetworkManager *)sharedManager
{
    static NetworkManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [NetworkManager new];
    });
    return manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        [AFNetworkReachabilityManager.sharedManager startMonitoring];
       // AFNetworkActivityIndicatorManager.sharedManager.enabled = YES;
    
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
       // _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
      //  _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        _sessionManager.requestSerializer.timeoutInterval = 15;
    }
    return self;
}

- (id)successWithAPI:(NetworkAPI *)API
{
    return ^(NSURLSessionDataTask *task, id responseObject) {
        API.endTime = NSDate.date.timeIntervalSince1970;
        
        API.rawResponse = responseObject;
        
        if (API.decodeResponseBlock) {
            API.decodeResponseBlock(API);
        }
        
        if (API.response) {
            if (API.response.isSuccessful) {
                API.requestResult = NetworkRequestResultSuccess;
            } else {
                API.requestResult = NetworkRequestResultFailure;
                if (API.failureBlock) {
                    API.failureBlock(API);
                }
            }
        }
        
        NSLog(@"%@", API);
        if (API.completionBlock) {
            API.completionBlock(API);
        }
    };
}

- (id)failureWithAPI:(NetworkAPI *)API
{
    return ^(NSURLSessionDataTask *task, NSError *error) {
        API.endTime = NSDate.date.timeIntervalSince1970;
        
        API.error = error;
        API.requestResult = NetworkRequestResultNotConnection;
        
        if (API.notConnectionBlock) {
            API.notConnectionBlock(API);
        }
        
        NSLog(@"%@", API);
        if (API.completionBlock) {
            API.completionBlock(API);
        }
    };
}

- (id)progressWithAPI:(NetworkAPI *)API
{
    return ^(NSProgress *progress) {
        API.endTime = NSDate.date.timeIntervalSince1970;
        API.progress = progress;
        
        if (API.progressBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                API.progressBlock(API);
            });
        }
    };
}

- (id)constructingBodyWithAPI:(NetworkAPI *)API
{
    return ^(id<AFMultipartFormData> formData) {
        for (NetworkUpload *upload in API.uploads) {
            [formData appendPartWithFileData:upload.data name:upload.name fileName:upload.fileName mimeType:upload.mimeType];
        }
    };
}

- (void)setupSessionWithAPI:(NetworkAPI *)API
{
    NSMutableSet *URI = [NSMutableSet setWithArray:@[@"GET", @"HEAD", @"DELETE"]];
    
    if (API.parametersType == NetworkParametersTypeBody) {
        NSString *HTTPMethod = @[@"GET", @"POST", @"PUT", @"DELETE", @"PATCH"][API.HTTPMethod];
        [URI removeObject:HTTPMethod];
    }
    
    if (API.parametersType == NetworkParametersTypeNormal) {
        NSString *HTTPMethod = @[@"GET", @"POST", @"PUT", @"DELETE", @"PATCH"][API.HTTPMethod];
        [URI addObject:HTTPMethod];
    }
    
    _sessionManager.requestSerializer.HTTPMethodsEncodingParametersInURI = URI;
    
    //    [_sessionManager.requestSerializer setAuthorizationHeaderFieldWithUsername:API.userName password:API.token];
    
//    if (API.expires > 0) {
//        if ([NetworkCache isValidWithKey:API.fullURLString]) {
//            NetworkCache *cache = [NetworkCache cacheWithKey:API.fullURLString];
//            [_sessionManager.requestSerializer setValue:cache.etag forHTTPHeaderField:@"If-None-Match"];
//        }
//    } else {
//        [_sessionManager.requestSerializer setValue:nil forHTTPHeaderField:@"If-None-Match"];
//    }
    
    _sessionManager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    [API.HTTPHeaderFields enumerateKeysAndObjectsUsingBlock:^(id HTTPHeaderField, id value, BOOL *stop) {
        [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:HTTPHeaderField];
    }];
}

- (void)requestWithAPI:(NetworkAPI *)API
{
    if (API.joinURLStringBlock) {
        API.joinURLStringBlock(API);
    }
    
    if (API.encodeParametersBlock) {
        API.encodeParametersBlock(API);
    }
    
    NSString *URLString = API.fullURLString;
    id parameters = API.encodeParameters;
    API.startTime = NSDate.date.timeIntervalSince1970;
    
    id success = [self successWithAPI:API];
    id failure = [self failureWithAPI:API];
    id progress = [self progressWithAPI:API];
    id constructingBody = [self constructingBodyWithAPI:API];
    
    [self setupSessionWithAPI:API];
    
    switch (API.HTTPMethod) {
        case NetworkHTTPMethodGET:
            API.task = [_sessionManager GET:URLString parameters:parameters progress:progress success:success failure:failure];
            break;
        case NetworkHTTPMethodPOST:
            if (API.uploads.count > 0) {
                API.task = [_sessionManager POST:URLString parameters:parameters constructingBodyWithBlock:constructingBody progress:progress success:success failure:failure];
            } else {
                API.task = [_sessionManager POST:URLString parameters:parameters progress:progress success:success failure:failure];
            }
            break;
        case NetworkHTTPMethodPUT:
            API.task = [_sessionManager PUT:URLString parameters:parameters success:success failure:failure];
            break;
        case NetworkHTTPMethodDELETE:
            API.task = [_sessionManager DELETE:URLString parameters:parameters success:success failure:failure];
            break;
        case NetworkHTTPMethodPATCH:
            API.task = [_sessionManager PATCH:URLString parameters:parameters success:success failure:failure];
            break;
    }
}

- (void)requestWithAPIs:(NetworkAPIs *)APIs
{
    if (APIs.queue.count == 0) {
        if (APIs.completionsBlock) {
            APIs.completionsBlock(APIs);
        }
        return;
    }
    
    switch (APIs.requestType) {
        case NetworkAPIsRequestTypeAsync:
            [self asyncRequestWithAPIs:APIs];
            break;
        case NetworkAPIsRequestTypeSync:
            [self syncRequestWithAPIs:APIs];
            break;
        default:
            break;
    }
}

- (void)asyncRequestWithAPIs:(NetworkAPIs *)APIs
{
    dispatch_group_t group = dispatch_group_create();
    for (NetworkAPI *api in APIs.queue) {
        dispatch_group_enter(group);
        NetworkBlock completion = [api.completionBlock copy];
        [api completion:^(NetworkAPI *API) {
            if (completion) {
                completion(API);
            }
            dispatch_group_leave(group);
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (APIs.completionsBlock) {
            APIs.completionsBlock(APIs);
        }
    });
}

- (void)syncRequestWithAPIs:(NetworkAPIs *)APIs
{
    NSEnumerator *enumerator = APIs.queue.objectEnumerator;
    [self requestWithAPIs:APIs enumerator:enumerator];
}

- (void)requestWithAPIs:(NetworkAPIs *)APIs
             enumerator:(NSEnumerator *)enumerator
{
    __weak NetworkAPIs *weakAPIs = APIs;
    NetworkAPI *api = enumerator.nextObject;
    
    if (api == nil) {
        APIs.completionsBlock(APIs);
        return;
    }
    
    NetworkBlock completion = [api.completionBlock copy];
    [api completion:^(NetworkAPI *API) {
        if (completion) {
            completion(API);
        }
        [self requestWithAPIs:weakAPIs enumerator:enumerator];
    }];
}

@end
