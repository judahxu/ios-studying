//
//  QYStudentModel.h
//  DataPersistentDemo
//
//  Created by qingyun on 15-3-24.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYStudentModel : NSObject
@property (nonatomic) int ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic) int age;
@property (nonatomic, strong) UIImage *icon;

@end
