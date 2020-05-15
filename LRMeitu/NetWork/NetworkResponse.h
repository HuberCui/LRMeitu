

#import <Foundation/Foundation.h>

@interface NetworkResponse : NSObject

@property (copy, nonatomic) NSString *Errno;
@property (copy, nonatomic) NSString *errmsg;
@property (strong, nonatomic) id data;

@property (readonly) BOOL isSuccessful;

@end
