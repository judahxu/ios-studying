//
//  WMInsertInPutDataVCViewController.m
//  WealthManager
//
//  Created by Maser on 15/5/7.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMInsertInPutDataVC.h"
#import "WMModelCell.h"
#import "WMUsedCell.h"
#import "WMTimeCell.h"
#import "WMMoneyCell.h"
#import "WMCommentCell.h"
#import "WMDataBase.h"
#import "WMinPutModel.h"


@interface WMInsertInPutDataVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *insertInPutTableView;
@property (strong, nonatomic) IBOutlet UIToolbar *didToolBar;
@property (strong, nonatomic) IBOutlet UIDatePicker *timePickerView;

@property (copy, nonatomic) NSString *inModel;
@property (copy, nonatomic) NSString *inPutMoneyData;
@property (copy, nonatomic) NSString *commentData;
@property (copy, nonatomic) NSString *day;
@property (copy, nonatomic) NSString *usedModel;

@property (nonatomic,strong)WMInPutModel  *dataModel;

@end

@implementation WMInsertInPutDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self steupView];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"saveImage.jpg"]];
     _day = @"请选择";
    self.insertInPutTableView.backgroundColor = [UIColor clearColor];
    _didToolBar.backgroundColor = [UIColor clearColor];
}


- (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}

- (IBAction)saveAction:(id)sender
{
    BOOL isNumber = [self isPureNumandCharacters:_inPutMoneyData];
    
    if (_inPutMoneyData.length == 0||_day.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写完整" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if (isNumber == NO) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的金额" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    NSString *dataPath = [WMDataBase DatabasePathWithName:@"WMSqliteDB.db"];
    
    
    NSString *yearAndMouth = [_day substringWithRange:NSMakeRange(0, 7)];
    NSString *day = [_day substringWithRange:NSMakeRange(8, 2)];
    
    
    _dataModel =[[WMInPutModel alloc]initWithID:0 inPutModel:_inModel money:_inPutMoneyData date:yearAndMouth day:day comment:_commentData];
    
    NSString *sql = [WMDataBase creatInsertInPutTableSqlWith:@"inPutTable" model:_dataModel.inPutModel money:_dataModel.inPutMoney date:_dataModel.inPutDate day:_dataModel.inPutDay comment:_dataModel.inPutComment];
    
    [WMDataBase insertIntoDataBaseWith:sql dataBasePath:dataPath];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"saveInPutSuccess" object:nil];
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)steupView
{
    UIBarButtonItem *escBtn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(endAction:)];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doneAction:)];
    UIBarButtonItem *spaceBtn = [[UIBarButtonItem alloc]init];
    
    NSArray *btnArray = [[NSArray alloc]initWithObjects:escBtn,spaceBtn,spaceBtn,
                         spaceBtn,spaceBtn,spaceBtn,spaceBtn,spaceBtn,spaceBtn,spaceBtn,spaceBtn,doneBtn, nil];
    _didToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 44)];
    [_didToolBar setItems:btnArray];
    
    
    _timePickerView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 162)];
    _timePickerView.datePickerMode = UIDatePickerModeDate;
    _timePickerView.hidden = YES;
    [self.view addSubview:_didToolBar];
    [self.view addSubview: _timePickerView];
}


-(void)endAction:(id)sender
{
    if (_timePickerView.hidden == NO) {
        [self viewAnimation:_timePickerView willHidden:YES];
        [self toolBarAnimation:_didToolBar willHidden:YES];
    }
    
    [self.insertInPutTableView setUserInteractionEnabled:YES];
    

}
-(void)doneAction:(id)sender
{
    [self getDate];
    [self viewAnimation:_timePickerView willHidden:YES];
    [self toolBarAnimation:_didToolBar willHidden:YES];
    [self.insertInPutTableView setUserInteractionEnabled:YES];
    [self.insertInPutTableView reloadData];
}
- (void)getDate
{
    NSDate *date = self.timePickerView.date;
    NSDateFormatter *outFormatter = [[NSDateFormatter alloc] init];
    [outFormatter setDateFormat:@"yyyy-MM-dd"];
    _day = [outFormatter stringFromDate:date];
    
}
- (void)viewAnimation:(UIView *)view willHidden:(BOOL)hidden
{
    [UIView animateWithDuration:0.3 animations:^{
        if (hidden) {
            view.frame = CGRectMake(0, self.view.bounds.size.height+44, self.view.bounds.size.width, 162);
        }else
        {
            //[view setHidden:YES];
            view.frame = CGRectMake(0, self.view.bounds.size.height - 162, self.view.bounds.size.width, 162);
        }
        
    } completion:^(BOOL finished) {
        [view setHidden:hidden];
    }];
}


- (void)toolBarAnimation:(UIToolbar *)toolBar willHidden:(BOOL)hidden
{
    [UIView animateWithDuration:0.3 animations:^{
        if (hidden) {
            toolBar.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 44);
        }else
        {
            // [toolBar setHidden:YES];
            toolBar.frame = CGRectMake(0, self.view.bounds.size.height-206, self.view.bounds.size.width, 44);
        }
    }completion:^(BOOL finished) {
        [toolBar setHidden:hidden];
    }];
}

#pragma mark --textfield
-(void)moneyValuesChange:(id)sender
{
    UITextField *textField = (UITextField *)sender;
    _inPutMoneyData = textField.text;
}
-(void)commentValuesChanged:(id)sender
{
    UITextField *textField = (UITextField *)sender;
    _commentData = textField.text;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - tableView deledage
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == 1) {
        WMMoneyCell *cell = [self.insertInPutTableView dequeueReusableCellWithIdentifier:@"inMoneyCell" ];
         cell.backgroundColor = [UIColor clearColor];
        [cell.moneyTextField addTarget:self action:@selector(moneyValuesChange:) forControlEvents:UIControlEventEditingChanged];
        cell.moneyTextField.tag = 501;
        cell.moneyTextField.returnKeyType = UIReturnKeyDone;
        cell.moneyTextField.keyboardType = UIKeyboardTypeDefault;
        return cell;
    }
    if (indexPath.row == 2) {
        WMTimeCell *cell = [self.insertInPutTableView dequeueReusableCellWithIdentifier:@"inTimeCell" ];
         cell.backgroundColor = [UIColor clearColor];
        cell.timeLabel.text = _day;
        cell.tag = 1002;
        return cell;
    }
       if (indexPath.row == 3) {
        WMCommentCell *cell = [self.insertInPutTableView dequeueReusableCellWithIdentifier:@"inCommentCell"];
            cell.backgroundColor = [UIColor clearColor];
        cell.commentLabel.tag = 503;
           [cell.commentLabel addTarget:self action:@selector(commentValuesChanged:) forControlEvents:UIControlEventEditingChanged];
           cell.commentLabel.returnKeyType = UIReturnKeyDone;
           cell.commentLabel.keyboardType = UIKeyboardTypeDefault;
        NSLog( @"%@",_commentData);
        cell.tag = 1005;
        return cell;
    }
    WMModelCell *cell = [self.insertInPutTableView dequeueReusableCellWithIdentifier:@"inModelCell"];
     cell.backgroundColor = [UIColor clearColor];
    cell.tag = 1000;
    cell.modelLabel.text = _inModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2)
    {   //调用上面写的动画方法
        [self toolBarAnimation:_didToolBar willHidden:NO];
        [self viewAnimation:_timePickerView willHidden:NO];
        [self.insertInPutTableView setUserInteractionEnabled:NO];
        
        [self.tabBarController setHidesBottomBarWhenPushed:YES];
        
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
