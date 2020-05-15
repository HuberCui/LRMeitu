

#import "NetworkAPI.h"
#import "NetworkManager.h"

//@import AppContext_Category;
//@import User_Category;

@implementation NetworkAPI

- (instancetype)initWithURLString:(NSString *)URLString
                       HTTPMethod:(NetworkHTTPMethod)HTTPMethod
                       parameters:(id)parameters
{
    if (self = [super init]) {
        
        self.URLString = URLString;
        self.HTTPMethod = HTTPMethod;
        self.parameters = parameters;
        
        self.baseURLString = BaseUrl;
        
        self.joinURLStringBlock = ^(NetworkAPI *API) {
            if ([API.baseURLString hasSuffix:@"/"]) {
                API.fullURLString = [NSString stringWithFormat:@"%@%@", API.baseURLString, API.URLString];
            } else {
                API.fullURLString = [NSString stringWithFormat:@"%@/%@", API.baseURLString, API.URLString];
            }
        };
        
        self.decodeResponseBlock = ^(NetworkAPI *API) {
            API.response = [NetworkResponse new];
            API.response.data = API.rawResponse[@"data"];
            API.response.Errno = API.rawResponse[@"code"];
            API.response.errmsg = API.rawResponse[@"msg"];
        };
        
        self.encodeParametersBlock = ^(NetworkAPI *API) {
            API.encodeParameters = API.parameters;
        };
        
//#ifdef PATIENT_API
//        NSString *token = [CTMediator.sharedInstance User_token];
//        NSString *version = [CTMediator.sharedInstance AppContext_version];
//        NSString *appType = [CTMediator.sharedInstance AppContext_appType];
//        self.HTTPHeaderFields = @{@"x-access-token" : token,
//                                  @"x-access-version" : version,
//                                  @"x-access-app-type" : appType};
//        self.token = token;
//#else ifdef DOCTOR_API
//        NSString *token = [CTMediator.sharedInstance User_token];
//        NSString *version = [CTMediator.sharedInstance AppContext_version];
//        NSString *appType = [CTMediator.sharedInstance AppContext_appType];
//        self.HTTPHeaderFields = @{@"x-access-token" : token,
//                                 @"x-access-version" : version,
//                                 @"x-access-app-type" : appType};
//        self.token = token;
//#endif
        
    }
    return self;
}

- (NSTimeInterval)costTime
{
    return _endTime - _startTime;
}

- (NSInteger *)statusCode
{
    return ((NSHTTPURLResponse *)_task.response).statusCode;
}

+ (instancetype)apiWithURLString:(NSString *)URLString
                      HTTPMethod:(NetworkHTTPMethod)HTTPMethod
                      parameters:(id)parameters
{
    return [self.alloc initWithURLString:URLString HTTPMethod:HTTPMethod parameters:parameters];
}

- (instancetype)request
{
    [NetworkManager.sharedManager requestWithAPI:self];
    return self;
}

- (instancetype)completion:(NetworkBlock)completion
{
    self.completionBlock = completion;
    [self request];
    return self;
}

- (BOOL)isRequestSuccess
{
    return _requestResult == NetworkRequestResultSuccess;
}

#pragma mark - API的输出板式
- (NSString *)description
{
    switch (self.requestResult) {
        case NetworkRequestResultSuccess:
            return [self printResponseModelString];
        case NetworkRequestResultFailure:
            return [self printResponseModelString];
        case NetworkRequestResultNotConnection:
            return [self printErrorString];
    }
}

- (NSString *)printErrorString
{
    NSString *line = @"\n------------------------------------------------------------------------------";
    
    NSDictionary *errorDictionary = @{@"code" : @(self.error.code),
                                      @"domain" : self.error.domain,
                                      @"userInfo" : self.error.userInfo};
    NSString *error = [NSString stringWithFormat:@"\nError = %@", errorDictionary];
    NSString *informationOfAPIString = [self informationOfAPIString];
    
    return [NSString stringWithFormat:@"%@%@%@%@%@%@", line, line, informationOfAPIString, error, line, line];
}

- (NSString *)printResponseModelString
{
    NSString *line = @"\n------------------------------------------------------------------------------";
    
    NSString *informationOfAPIString = [self informationOfAPIString];
    NSString *responseModel = [NSString stringWithFormat:@"\n%@", self.response];
    
    return [NSString stringWithFormat:@"%@%@%@%@%@%@", line, line, informationOfAPIString, responseModel, line, line];
}

- (NSString *)informationOfAPIString
{
    NSString *parametersString;
    if (self.parameters) {
        parametersString = [NSString.alloc initWithData:[NSJSONSerialization dataWithJSONObject:self.parameters options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    } else {
        parametersString = [NSString stringWithFormat:@"%@", self.parameters];
    }

    
    NSString *HTTPMethodString = @[@"GET", @"POST", @"PUT", @"DELETE", @"PATCH"][self.HTTPMethod];
    NSString *fullURLString = [NSString stringWithFormat:@"\nURLString = %@", self.fullURLString];
    NSString *HTTPMethod = [NSString stringWithFormat:@"\nHTTPMethod = %@", HTTPMethodString];
    NSString *parameters = [NSString stringWithFormat:@"\nPrameters = %@", parametersString];
    NSString *token = [NSString stringWithFormat:@"\nToken = %@", self.token];

    NSString *costTime = [NSString stringWithFormat:@"\nCostTime = %.2f s", self.costTime];
    
    NSInteger statusCode = ((NSHTTPURLResponse *)self.task.response).statusCode;
    NSString *statusCodeString = [NSString stringWithFormat:@"\nStatusCode = %ld", statusCode];
    
    return [NSString stringWithFormat:@"%@%@%@%@%@%@", fullURLString, HTTPMethod, parameters, token, costTime, statusCodeString];
}

@end

@implementation NetworkAPIs

- (instancetype)initWithQueue:(NSArray<NetworkAPI *> *)queue
{
    if (self = [super init]) {
        self.queue = queue.mutableCopy;
    }
    return self;
}

+ (instancetype)apisWithQueue:(NSArray<NetworkAPI *> *)queue
{
    return [self.alloc initWithQueue:queue];
}

- (instancetype)request
{
    [NetworkManager.sharedManager requestWithAPIs:self];
    return self;
}

- (instancetype)completions:(NetworksBlock)completions
{
    self.completionsBlock = completions;
    [self request];
    return self;
}

- (BOOL)isRequestSuccess
{
    for (NetworkAPI *api in _queue) {
        if (api.isRequestSuccess == NO) {
            return NO;
        }
    }
    return YES;
}

- (NSMutableArray<NetworkAPI *> *)queue
{
    if (_queue == nil) {
        _queue = NSMutableArray.array;
    }
    return _queue;
}

@end
