//
//  QYTableViewCell.h
//  DynimicTableViewDemo
//
//  Created by qingyun on 15-3-13.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@end
