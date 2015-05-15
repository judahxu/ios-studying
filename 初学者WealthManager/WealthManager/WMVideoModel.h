//
//  WMVideoModel.h
//  WealthManager
//
//  Created by Maser on 15/5/12.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMVideoModel : NSObject
@property (copy , nonatomic) NSString *videoName;
@property (copy , nonatomic) NSString *videoPic;
@property (copy , nonatomic) NSString *videoPlayUrl;

+(instancetype)getVideoWithDic:(NSDictionary *)dic;

@end
