//
//  QYTableViewCell.h
//  TableViewDemo
//
//  Created by qingyun on 15-3-13.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cuteView;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;

@end
