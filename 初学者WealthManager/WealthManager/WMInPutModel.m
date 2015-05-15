//
//  WMInPutModel.m
//  WealthManager
//
//  Created by Maser on 15/5/7.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMInPutModel.h"

@implementation WMInPutModel

-(instancetype)initWithID:(int)inPutID inPutModel:(NSString *)inPutModel money:(NSString *)inPutMoney date:(NSString *)inPutDate day:(NSString *)inPutDay comment:(NSString *)inPutComment
{
    WMInPutModel *model = [[WMInPutModel alloc]init];
    model.inPutID = inPutID;
    model.inPutModel = inPutModel;
    model.inPutMoney = inPutMoney;
    model.inPutDate = inPutDate;
    model.inPutDay = inPutDay;
    model.inPutComment = inPutComment;
    return model;
}
@end
