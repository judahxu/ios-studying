//
//  QYSendweibo.m
//  WeiBo
//
//  Created by qingyun on 15/4/25.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYSendweibo.h"
#import "AFHTTPRequestOperationManager.h"
#import "WeiBo-Prefix.pch"
#define kUpdataUrl @"https://api.weibo.com/2/statuses/update.json"


@implementation QYSendweibo

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)send:(id)sender {
    NSString * message = self.textView.text;
    NSLog(@"%@", message);
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"access_token":self.accessToken, @"status":message};
    [manager POST:kUpdataUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        [self dismissViewControllerAnimated:YES completion:nil];
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
             }];
     }
@end
