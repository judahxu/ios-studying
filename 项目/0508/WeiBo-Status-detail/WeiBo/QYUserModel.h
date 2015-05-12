//
//  QYUserModel.h
//  WeiBo
//
//  Created by qingyun on 15-4-26.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYUserModel : NSObject

@property(nonatomic, strong)NSString *userId;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *profile_image_url;

-(instancetype)initWithDictionary:(NSDictionary *)userInfo;

@end
