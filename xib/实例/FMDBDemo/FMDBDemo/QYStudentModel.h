//
//  QYStudentModel.h
//  FMDBDemo
//
//  Created by qingyun on 15-3-25.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYStudentModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *stu_id;
@property (nonatomic) int age;

+ (instancetype)studentWithName:(NSString *)name ID:(NSString *)ID andAge:(int)age;

@end
