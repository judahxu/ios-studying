//
//  QYViewController.m
//  TableViewCellHeightAL
//
//  Created by qingyun on 15-4-28.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"
#import "QYTableViewCell.h"

@interface QYViewController ()

@property (nonatomic, strong)NSArray *data;
@property (nonatomic, strong)QYTableViewCell *prototypeCell;

@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.data = @[@"1\n2\n4\n5\n6", @"sdflf sdflsdjf sdfjl sdfjlsdf sdf asdflsdf sdfsdf ", @"1234567", @"q\na\nz\nw\ns\nx\ne\nd\nc\nr\nf\nv"];
    //初始化一个cell，用来计算高度
    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table View delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QYTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //绑定内同
    cell.tLabel.text = self.data[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    QYTableViewCell *cell = self.prototypeCell;
    //帮定内容进行计算
    cell.tLabel.text = self.data[indexPath.row];
    //用autoLayout计算cell高度
    CGSize cellSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return cellSize.height + 1;
    
    
}



@end
