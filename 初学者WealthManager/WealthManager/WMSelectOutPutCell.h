//
//  WMSelectOutPutCell.h
//  WealthManager
//
//  Created by Maser on 15/5/7.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMSelectOutPutCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *modelLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLable;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *usedLabel;

@end
