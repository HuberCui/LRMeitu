

#import "NetworkUpload.h"

@implementation NetworkUpload

- (instancetype)initWithData:(NSData *)data
                        name:(NSString *)name
                    fileName:(NSString *)fileName
                    mimeType:(NSString *)mimeType
{
    if (self = [super init]) {
        self.data = data;
        self.name = name;
        self.fileName = fileName;
        self.mimeType = mimeType;
    }
    return self;
}

@end
