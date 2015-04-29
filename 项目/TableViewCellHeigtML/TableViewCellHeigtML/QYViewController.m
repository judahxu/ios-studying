//
//  QYViewController.m
//  TableViewCellHeigtML
//
//  Created by qingyun on 15-4-28.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"
#import "QYTableViewCell.h"
#import "NSString+stringSize.h"

@interface QYViewController ()

@property (nonatomic, strong)NSArray *data;

@property (nonatomic, strong)QYTableViewCell *protypeCell;

@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.data = @[@"1\n2\n4\n5\n6", @"sdflf sdflsdjf sdfjl sdfjlsdf sdf asdflsdf sdfsdf ", @"1234567", @"q\na\nz\nw\ns\nx\ne\nd\nc\nr\nf\nv"];
    
	// Do any additional setup after loading the view, typically from a nib.
    //label
    self.protypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    //textView
   // self.protypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"textCell"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //label
    QYTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //绑定内同
    cell.tLabel.text = self.data[indexPath.row];
    //end label
    
    //textView
    
//    QYTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"textCell" forIndexPath:indexPath];
//    cell.textView.text = self.data[indexPath.row];
//    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //label
    //cell 将要显示的时候
    //根据文字内同修改labelframe
    
    QYTableViewCell *qCell = (QYTableViewCell *)cell;
    
    CGSize size = [qCell.tLabel sizeThatFits:CGSizeMake(qCell.tLabel.bounds.size.width, MAXFLOAT)];
    CGRect frame = qCell.tLabel.frame;
    frame.size = size;
    qCell.tLabel.frame = frame;
    //end label
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /**
     *  label
     */
    QYTableViewCell *cell = self.protypeCell;
    NSString *string = self.data[indexPath.row];
//    计算文字的高度
    CGSize size = [string calculateSize:CGSizeMake(cell.tLabel.bounds.size.width, MAXFLOAT) Font:[UIFont systemFontOfSize:17]];
    
    //返回整个cell高度
    return size.height + cell.contentView.frame.size.height - cell.tLabel.frame.size.height + 1;
    
    //end label
    
//    QYTableViewCell *cell = self.protypeCell;
//    
//    cell.textView.text = self.data[indexPath.row];
//    
//    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    
//    CGSize textSize = [cell.textView sizeThatFits:CGSizeMake(cell.textView.frame.size.width, MAXFLOAT)];
//    
//    
//    return size.height + 1 + textSize.height;
    
    
}

@end
