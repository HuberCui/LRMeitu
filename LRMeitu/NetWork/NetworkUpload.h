

#import <Foundation/Foundation.h>

@interface NetworkUpload : NSObject

@property (copy, nonatomic) NSData *data;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *fileName;
@property (copy, nonatomic) NSString *mimeType;

/**
 生成上传模型

 @param data The data to be encoded and appended to the form data.
 @param name The name to be associated with the specified data. This parameter must not be `nil`.
 @param fileName fileName The filename to be associated with the specified data. This parameter must not be `nil`.
 @param mimeType mimeType The MIME type of the specified data. (For example, the MIME type for a JPEG image is image/jpeg.) For a list of valid MIME types, see http://www.iana.org/assignments/media-types/. This parameter must not be `nil`.
 @return upload
 */
- (instancetype)initWithData:(NSData *)data
                        name:(NSString *)name
                    fileName:(NSString *)fileName
                    mimeType:(NSString *)mimeType;

@end
