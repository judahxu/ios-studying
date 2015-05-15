//
//  WMOutPutModel.h
//  WealthManager
//
//  Created by Maser on 15/5/7.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMOutPutModel : NSObject

@property (nonatomic)int outPutID;
@property (copy , nonatomic) NSString *outPutModel;
@property (copy , nonatomic) NSString *outPutMoney;
@property (copy , nonatomic)NSString *outPutDate;
@property (copy , nonatomic) NSString *outPutUsed;
@property (copy , nonatomic)NSString *outPutComment;
@property (copy , nonatomic)NSString *outPutDay;
+(id)initWithID:(int)outPutID outPutModel:(NSString *)outPutModel outPutMoney:(NSString *)outPutMoney outPutDate:(NSString *)outPutDate outPutDay:(NSString *)outPutDay outPutUsed:(NSString *)outPutUsed  outPutComment:(NSString *)outPutComment;
@end
