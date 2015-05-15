//
//  QYAppDelegate.h
//  WeiBo
//
//  Created by qingyun on 15-4-16.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"

@interface QYAppDelegate : UIResponder <UIApplicationDelegate, WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, copy)NSString *accessToken;

@end
