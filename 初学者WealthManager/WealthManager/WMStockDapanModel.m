//
//  WMStockDapanModel.m
//  WealthManager
//
//  Created by Maser on 15/5/10.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMStockDapanModel.h"

@implementation WMStockDapanModel


+(instancetype)initWithStockName:(NSString *)stockName stockDot:(NSString *)stockDot stockNowPic:(NSString *)stockNowPic stockRate:(NSString *)stockRate
{
    WMStockDapanModel *model = [[WMStockDapanModel alloc]init];
   
    model.stockName = stockName;
    model.stockDot = stockDot;
    model.stockNowpic = stockNowPic;
    model.stockRate = stockRate;
    return  model;
    
}
@end
