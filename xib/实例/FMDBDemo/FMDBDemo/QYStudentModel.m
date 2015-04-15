//
//  QYStudentModel.m
//  FMDBDemo
//
//  Created by qingyun on 15-3-25.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYStudentModel.h"

@implementation QYStudentModel

+ (instancetype)studentWithName:(NSString *)name ID:(NSString *)ID andAge:(int)age
{
    QYStudentModel *student = [[QYStudentModel alloc] init];
    student.name = name;
    student.stu_id = ID;
    student.age = age;
    
    return student;
}

@end
