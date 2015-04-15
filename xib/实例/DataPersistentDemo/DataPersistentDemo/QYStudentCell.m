//
//  QYStudentCell.m
//  DataPersistentDemo
//
//  Created by qingyun on 15-3-25.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYStudentCell.h"

@implementation QYStudentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
