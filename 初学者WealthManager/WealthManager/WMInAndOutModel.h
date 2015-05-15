//
//  WMInAndOutModel.h
//  WealthManager
//
//  Created by Maser on 15/5/9.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMInAndOutModel : NSObject


-(instancetype)initWithID:(NSString *)ID money:(NSString *)money date:(NSString *)date;
@property (copy, nonatomic) NSString *ID;
@property (copy , nonatomic)NSString *money;
@property (copy , nonatomic)NSString *date;
@end
