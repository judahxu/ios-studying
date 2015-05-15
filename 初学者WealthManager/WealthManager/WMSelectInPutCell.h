//
//  WMSelectInPutCell.h
//  WealthManager
//
//  Created by Maser on 15/5/8.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMSelectInPutCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *inPutModelLabel;
@property (weak, nonatomic) IBOutlet UILabel *inPutMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *inPutDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *inPutCommentLabel;

@end
