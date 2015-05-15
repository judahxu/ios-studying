//
//  WMStockBodyData.h
//  WealthManager
//
//  Created by Maser on 15/5/10.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMStockBodyData : NSObject
@property (copy , nonatomic) NSString *stockName;//股票名字
@property (copy , nonatomic) NSString *stockGid;//股票编号
@property (copy , nonatomic) NSString *stockTodayStarPri;//今日开盘价
@property (copy , nonatomic) NSString *stockYestodEndPri;//昨日收盘价
@property (copy , nonatomic) NSString *stockNowPri;//当前价格
@property (copy , nonatomic) NSString *stockTodayMax;//今日最高价格
@property (copy , nonatomic) NSString *stockTodayMin;//今日最低价格
@property (copy , nonatomic) NSString *stockDate;//日期
@property (copy , nonatomic) NSString *stockTime;//时间
@property (copy , nonatomic) NSString *stockTarsNumber;//成交量


+(instancetype)initWitStockName:(NSString *)name stockGid:(NSString *)gid stockTodayStarPri:(NSString *)starPri stockYesTodEndPri:(NSString *)endPri stockNowPri:(NSString *)nowPri stockTodayMax:(NSString *)maxPri stockTodayMin:(NSString *)minPri stockDate:(NSString *)date stockTime:(NSString *)time stockTarsNumber:(NSString *)number;

@end
