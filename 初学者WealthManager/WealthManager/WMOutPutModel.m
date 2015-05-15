//
//  WMOutPutModel.m
//  WealthManager
//
//  Created by Maser on 15/5/7.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMOutPutModel.h"

@implementation WMOutPutModel

+ (id)initWithID:(int)outPutID outPutModel:(NSString *)outPutModel outPutMoney:(NSString *)outPutMoney outPutDate:(NSString *)outPutDate outPutDay:(NSString *)outPutDay outPutUsed:(NSString *)outPutUsed outPutComment:(NSString *)outPutComment
{
    
    WMOutPutModel *outPut = [[WMOutPutModel alloc]init];
    outPut.outPutID = outPutID;
    outPut.outPutModel = outPutModel;
    outPut.outPutMoney = outPutMoney;
    outPut.outPutDate = outPutDate;
    outPut.outPutDay = outPutDay;
    outPut.outPutUsed = outPutUsed;
    outPut.outPutComment = outPutComment;
    return outPut;
}
@end
