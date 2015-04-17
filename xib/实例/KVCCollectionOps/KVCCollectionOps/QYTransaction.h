//
//  QYTransaction.h
//  KVCCollectionOps
//
//  Created by qingyun on 15-3-10.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYTransaction : NSObject
@property (nonatomic, strong) NSString *payee;
@property (nonatomic) double amount;
@property (nonatomic, strong) NSDate *date;
@end
