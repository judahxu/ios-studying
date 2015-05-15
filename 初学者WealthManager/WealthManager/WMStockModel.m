//
//  WMStockModel.m
//  WealthManager
//
//  Created by Maser on 15/5/10.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMStockModel.h"

@implementation WMStockModel

+(instancetype)initWithAllData:(NSDictionary *)stock {
    WMStockModel *model = [[WMStockModel alloc]init];
    NSDictionary *dapandata = stock[@"dapandata"];
    NSDictionary *data = stock[@"data"];
    NSDictionary *gopicture = stock[@"gopicture"];
    NSString *ID = stock[@"stockID"];
    if ([dapandata isKindOfClass:[NSData class]]) {
        dapandata = [NSKeyedUnarchiver unarchiveObjectWithData:(NSData *)dapandata];
    }
    if ([data isKindOfClass:[NSData class]]) {
        data = [NSKeyedUnarchiver unarchiveObjectWithData:(NSData *)data];
    }
    if ([gopicture isKindOfClass:[NSData class]]) {
        gopicture = [NSKeyedUnarchiver unarchiveObjectWithData:(NSData *)gopicture];
    }
    model.dapanData = dapandata;
    model.stockData = data;
    model.stockPic = gopicture;
    model.stockID = ID;
    return  model;
}
@end
