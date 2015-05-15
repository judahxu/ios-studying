//
//  WMVideoCell.m
//  WealthManager
//
//  Created by Maser on 15/5/12.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMVideoCell.h"
#import "WMVideoModel.h"
#import <UIImageView+WebCache.h>


@implementation WMVideoCell

-(void)setVideoModel:(WMVideoModel *)model{
    //绑定内容
    self.videoName.text =model.videoName;
    [self.videoImage sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:model.videoPic] andPlaceholderImage:[UIImage imageNamed:@"blackImage.png"] options:SDWebImageAllowInvalidSSLCertificates progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
