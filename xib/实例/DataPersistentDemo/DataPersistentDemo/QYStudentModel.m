//
//  QYStudentModel.m
//  DataPersistentDemo
//
//  Created by qingyun on 15-3-24.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYStudentModel.h"

@implementation QYStudentModel

- (NSString *)description
{
    NSString *desc = [NSString stringWithFormat:@"ID:<%d>, name:<%@>, age:<%d>, sex:<%@>, icon:<%@>", _ID, _name, _age, _sex, _icon];
    
    return desc;
}

@end
