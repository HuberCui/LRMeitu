

#import "NetworkResponse.h"

@implementation NetworkResponse

- (NSString *)description
{
    NSString *data = _data;
    if ([data isKindOfClass:NSArray.class] || [data isKindOfClass:NSDictionary.class]) {
        data = [NSString.alloc initWithData:[NSJSONSerialization dataWithJSONObject:_data options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    }
    return [NSString stringWithFormat:@"Errno = %@ \nerrmsg = %@ \ndata = %@", _Errno, _errmsg, data];
}

- (BOOL)isSuccessful
{
    return _Errno.integerValue == 0;
}

@end
