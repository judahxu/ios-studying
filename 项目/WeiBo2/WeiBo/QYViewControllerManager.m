//
//  QYViewControllerManager.m
//  WeiBo
//
//  Created by qingyun on 15-4-20.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewControllerManager.h"

#import "QYGuideVC.h"
#import "QYMainViewController.h"
#import "QYAppDelegate.h"

@implementation QYViewControllerManager

+(id)getRootViewVC{
    //根据标识返回相应的控制器
    
    BOOL notFirstLaunch = [[NSUserDefaults standardUserDefaults] boolForKey:@"notFirstLaunch"];
    
    if (YES) {
        return [[QYMainViewController alloc] init];
    }else{
        return [[QYGuideVC alloc] init];
    }
}


+(void)guideEnd{
    //引导结束，更改标识位，切换根控制器
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:YES forKey:@"notFirstLaunch"];
    [userDefault synchronize];
    
    QYAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    delegate.window.rootViewController = [[QYMainViewController alloc] init];
    
}


@end
