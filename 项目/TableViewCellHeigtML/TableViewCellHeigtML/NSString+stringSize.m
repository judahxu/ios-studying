//
//  NSString+stringSize.m
//  TableViewCellHeigtML
//
//  Created by qingyun on 15-4-28.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "NSString+stringSize.h"

@implementation NSString (stringSize)

-(CGSize)calculateSize:(CGSize)size Font:(UIFont *)font{
    //根据系统版本提供不同API
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        //使用新方法
        
        //构造段落样式
        NSMutableParagraphStyle *pa = [[NSMutableParagraphStyle alloc] init];
        pa.lineBreakMode = NSLineBreakByWordWrapping;
        //构造属性字典
        NSDictionary *attibutes =@{NSFontAttributeName : font, NSParagraphStyleAttributeName :pa};
        
        return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attibutes context:nil].size;
        
    }else{
        //使用老版本方法
        return [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        
    }
}

@end
