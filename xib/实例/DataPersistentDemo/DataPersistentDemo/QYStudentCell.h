//
//  QYStudentCell.h
//  DataPersistentDemo
//
//  Created by qingyun on 15-3-25.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYStudentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ID;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end
