//
//  QYTableViewCell.m
//  TableViewDemo
//
//  Created by qingyun on 15-3-13.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYTableViewCell.h"

@implementation QYTableViewCell

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
