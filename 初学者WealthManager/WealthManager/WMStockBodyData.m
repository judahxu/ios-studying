//
//  WMStockBodyData.m
//  WealthManager
//
//  Created by Maser on 15/5/10.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMStockBodyData.h"

@implementation WMStockBodyData

+(instancetype)initWitStockName:(NSString *)name stockGid:(NSString *)gid stockTodayStarPri:(NSString *)starPri stockYesTodEndPri:(NSString *)endPri stockNowPri:(NSString *)nowPri stockTodayMax:(NSString *)maxPri stockTodayMin:(NSString *)minPri stockDate:(NSString *)date stockTime:(NSString *)time stockTarsNumber:(NSString *)number
{
    WMStockBodyData *model = [[WMStockBodyData alloc]init];
    model.stockName = name;
    model.stockGid = gid;
    model.stockTodayStarPri = starPri;
    model.stockYestodEndPri = endPri;
    model.stockNowPri = nowPri;
    model.stockTodayMax = maxPri;
    model.stockTodayMin = minPri;
    model.stockDate = date;
    model.stockTime = time;
    return  model;
}
@end
