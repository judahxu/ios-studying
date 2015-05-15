//
//  WMInAndOutModel.m
//  WealthManager
//
//  Created by Maser on 15/5/9.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMInAndOutModel.h"

@implementation WMInAndOutModel

-(instancetype)initWithID:(NSString *)ID money:(NSString *)money date:(NSString *)date
{
    WMInAndOutModel *model = [[WMInAndOutModel alloc]init];
    model.ID = ID;
    model.money = money;
    model.date = date;
    return model;
}
@end
