//
//  WMVideoModel.m
//  WealthManager
//
//  Created by Maser on 15/5/12.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMVideoModel.h"

@implementation WMVideoModel

+(instancetype)getVideoWithDic:(NSDictionary *)dic
{
    WMVideoModel *model = [[WMVideoModel alloc]init];
    model.videoName = dic[@"title"];
    model.videoPic = dic[@"bigPicUrl"];
    model.videoPlayUrl = dic[@"outerGPlayerUrl"];
    return model;
}
@end
