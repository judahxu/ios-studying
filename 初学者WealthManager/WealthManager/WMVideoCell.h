//
//  WMVideoCell.h
//  WealthManager
//
//  Created by Maser on 15/5/12.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WMVideoModel;
@interface WMVideoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (weak, nonatomic) IBOutlet UILabel *videoName;


-(void)setVideoModel:(WMVideoModel *)model;
@end
