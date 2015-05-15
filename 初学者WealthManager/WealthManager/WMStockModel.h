//
//  WMStockModel.h
//  WealthManager
//
//  Created by Maser on 15/5/10.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMStockModel : NSObject
@property (nonatomic,strong)NSDictionary *dapanData;
@property (nonatomic,strong)NSDictionary *stockData;
@property (nonatomic,strong)NSDictionary *stockPic;
@property (copy , nonatomic) NSString *stockID;

+(instancetype)initWithAllData:(NSDictionary *)stock;


@end
