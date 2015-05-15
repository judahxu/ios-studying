//
//  WMInPutModel.h
//  WealthManager
//
//  Created by Maser on 15/5/7.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMInPutModel : NSObject
-(instancetype)initWithID:(int)inPutID inPutModel:(NSString *)inPutModel money:(NSString *)inPutMoney date:(NSString *)inPutDate day:(NSString *)inPutDay comment:(NSString *)inPutComment;

@property (nonatomic) int inPutID;
@property (copy , nonatomic) NSString *inPutModel;
@property (copy , nonatomic) NSString *inPutMoney;
@property (copy , nonatomic)NSString *inPutDate;
@property (copy ,nonatomic) NSString *inPutDay;
@property (copy , nonatomic)NSString *inPutComment;
@end
