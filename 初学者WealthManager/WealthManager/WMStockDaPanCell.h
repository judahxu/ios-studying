//
//  WMStockDaPanCell.h
//  WealthManager
//
//  Created by Maser on 15/5/10.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMStockBodyData;
@interface WMStockDaPanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *stockNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *rateLable;

-(void)initCellWith:(WMStockBodyData *)model;
@end
