//
//  WMStockDapanModel.h
//  WealthManager
//
//  Created by Maser on 15/5/10.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMStockDapanModel : NSObject
@property (copy , nonatomic) NSString *stockName;//大盘指数名称
@property (copy , nonatomic) NSString *stockDot;//大盘当前点数
@property (copy , nonatomic) NSString *stockNowpic;//大盘当前价格
@property (copy , nonatomic) NSString *stockRate;//大盘涨跌率


+(instancetype)initWithStockName:(NSString *)stockName stockDot:(NSString *)stockDot stockNowPic:(NSString *)stockNowPic stockRate:(NSString *)stockRate;
@end
