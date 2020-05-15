//
//  LRTool.h
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/27.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface LRTool : NSObject
+ (instancetype)sharedLRTool;
+(UIViewController *)getcurrentViewController;
+(UINavigationController *)getcurrentNavigationViewController;
@end

NS_ASSUME_NONNULL_END
