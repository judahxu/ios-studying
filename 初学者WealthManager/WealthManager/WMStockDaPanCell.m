//
//  WMStockDaPanCell.m
//  WealthManager
//
//  Created by Maser on 15/5/10.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMStockDaPanCell.h"
#import "WMStockBodyData.h"
@implementation WMStockDaPanCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)initCellWith:(WMStockBodyData *)model
{
    
    _stockNameLabel.text =model.stockName;
    double starNumber = [model.stockTodayStarPri doubleValue];
    double endNumber = [model.stockYestodEndPri doubleValue];
    double rate = (starNumber-endNumber)/endNumber;
       _priceLabel.text = model.stockNowPri;
   
    if (rate >=0) {
        _rateLable.backgroundColor = [UIColor redColor];
         _rateLable.layer.cornerRadius = 10.0f;
        _rateLable.text = [NSString stringWithFormat:@"+%.3f%@",rate,@"%"];

    }else
    {
        _rateLable.backgroundColor = [UIColor greenColor];
         _rateLable.layer.cornerRadius = 10.0f;
        _rateLable.text = [NSString stringWithFormat:@"%.3f%@",rate,@"%"];

    }
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
