//
//  QYStudent.h
//  DataPersistentDemo
//
//  Created by qingyun on 15-3-20.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kName   @"name"
#define kAge    @"age"
#define kID     @"ID"

@interface QYStudent : NSObject <NSCoding>
@property (nonatomic, strong) NSString *name;
@property (nonatomic) int age;
@property (nonatomic, strong) NSString *ID;
@end
