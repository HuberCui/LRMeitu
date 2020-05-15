//
//  LRTool.m
//  LRMeitu
//
//  Created by cuixuebin on 2020/2/27.
//  Copyright © 2020 cuixuebin. All rights reserved.
//

#import "LRTool.h"
#import <UIKit/UIKit.h>
@interface LRTool()

@end
@implementation LRTool
+ (instancetype)sharedLRTool {
    static LRTool *instance;
    static dispatch_once_t oncePToken;
    dispatch_once(&oncePToken, ^{
        instance = [[LRTool alloc] init];
        
    });
    return instance;
}

+(UIViewController *)getcurrentViewController{
    UIViewController *rootVC = [UIApplication sharedApplication].windows[0].rootViewController;
    return [self currentViewControllerFrom:rootVC];
}

+(UINavigationController *)getcurrentNavigationViewController{
    UIViewController *vc = [self getcurrentViewController];
    return vc.navigationController;
}

+(UIViewController *)currentViewControllerFrom:(UIViewController *)currentVC{
    if([currentVC isKindOfClass:[UINavigationController class]]){
        UINavigationController*nav = (UINavigationController *)currentVC;
        return [self currentViewControllerFrom:nav.viewControllers.lastObject];
    }else if ([currentVC isKindOfClass:[UITabBarController class]]){
        UITabBarController *tab = (UITabBarController *)currentVC;
        return [self currentViewControllerFrom:tab.selectedViewController];
    }else if (currentVC.presentedViewController != nil){
        return [self currentViewControllerFrom:currentVC.presentedViewController];
    }else{
        return currentVC;
    }
}
@end
