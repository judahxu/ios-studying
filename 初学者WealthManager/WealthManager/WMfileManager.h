//
//  WMfileManager.h
//  WealthManager
//
//  Created by Maser on 15/4/30.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMfileManager : NSObject

//声明类方法
+(NSString *)dataDocPath:(NSString *)dataName;
+(void)copyDataToDocuments:(NSString *)dataName;
@end
