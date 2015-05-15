//
//  QYStatusTableViewCell.m
//  WeiBo
//
//  Created by qingyun on 15-4-26.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYStatusTableViewCell.h"
#import "QYStatusModel.h"
#import "QYUserModel.h"

@implementation QYStatusTableViewCell

-(void)setStatusModel:(QYStatusModel *)status{
    //绑定内容
    self.nameLabel.text = status.user.name;
    self.timeAgo.text = status.timeAgo;
    self.sourceLabel.text = status.source;
    self.contentText.text = status.text;
    self.reStatusContext.text = status.reStatus.reStatusText;
    self.iconImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:status.user.profile_image_url]]];
}

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
