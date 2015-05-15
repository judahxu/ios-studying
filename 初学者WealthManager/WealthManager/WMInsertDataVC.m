//
//  WMInsertDataVC.m
//  WealthManager
//
//  Created by Maser on 15/5/4.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMInsertDataVC.h"
#import "WMModelCell.h"
#import "WMUsedCell.h"
#import "WMTimeCell.h"
#import "WMMoneyCell.h"
#import "WMCommentCell.h"
#import "WMDataBase.h"
#import "WMOutPutModel.h"

@interface WMInsertDataVC ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *InsertTableView;
@property (strong, nonatomic) IBOutlet UIPickerView *choicePicker;
@property (strong, nonatomic) IBOutlet UIToolbar *didToolBar;
@property (strong, nonatomic) IBOutlet UIDatePicker *timePickerView;

@property (copy, nonatomic) NSString *outModel;
@property (copy, nonatomic) NSString *outPutMoneyData;
@property (copy, nonatomic) NSString *commentData;
@property (copy, nonatomic) NSString *day;
@property (copy, nonatomic) NSString *usedModel;


@property (nonatomic,strong)WMOutPutModel  *dataModel;



@property (nonatomic,strong)NSMutableArray *timeArray;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation WMInsertDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self steupview];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"saveImage.jpg"]];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"outModel" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:filePath];
    
    
    self.InsertTableView.backgroundColor = [UIColor clearColor];
    
    
    _dataArray = [dic valueForKey:_outModel];
    //NSLog(@"%@",_dataArray);
    _usedModel = @"请选择";
    _day = @"请选择";
    
}
- (void)steupview
{
    UIBarButtonItem *escBtn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(endAction:)];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doneAction:)];
    UIBarButtonItem *spaceBtn = [[UIBarButtonItem alloc]init];
    
    NSArray *btnArray = [[NSArray alloc]initWithObjects:escBtn,spaceBtn,spaceBtn,
                         spaceBtn,spaceBtn,spaceBtn,spaceBtn,spaceBtn,spaceBtn,spaceBtn,spaceBtn,doneBtn, nil];
    _didToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 44)];
    [_didToolBar setItems:btnArray];
    _didToolBar.backgroundColor = [UIColor clearColor];
    
    _choicePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height+1, self.view.bounds.size.width, 162)];
    _choicePicker.tag = 10000;
    _choicePicker.hidden = YES;
    _choicePicker.delegate =self;
    _choicePicker.dataSource = self;
    
    
    _timePickerView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 162)];
    _timePickerView.datePickerMode = UIDatePickerModeDate;
    _timePickerView.tag = 10001;
    _timePickerView.hidden = YES;
    
    [self.view addSubview:_didToolBar];
    [self.view addSubview:_choicePicker];
    [self.view addSubview: _timePickerView];
}

//写PICKERVIEW弹出的动画
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
//写toolbar的弹出弹回动画
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

//判断输入的值是不是全部为数字
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
    
    BOOL isNumber = [self isPureNumandCharacters:_outPutMoneyData];
    if (_day.length == 0||_outPutMoneyData.length == 0||_usedModel.length == 0) {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写完整" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if (isNumber == NO) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的金额" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    NSString *datapath= [WMDataBase DatabasePathWithName:@"WMSqliteDB.db"];
    
    NSString *yearAndMouth = [_day substringWithRange:NSMakeRange(0, 7)];
    NSString *day = [_day substringWithRange:NSMakeRange(8, 2)];
    
    _dataModel =[WMOutPutModel initWithID:0 outPutModel:_outModel outPutMoney:_outPutMoneyData outPutDate:yearAndMouth outPutDay:day outPutUsed:_usedModel outPutComment:_commentData];
    
    
    NSString *sql = [WMDataBase creatInsertOutTableSqlWith:@"outPutTable" model:_dataModel.outPutModel money:_dataModel.outPutMoney date:_dataModel.outPutDate day:_dataModel.outPutDay used:_dataModel.outPutUsed comment:_dataModel.outPutComment];
    
    
    [WMDataBase insertIntoDataBaseWith:sql dataBasePath:datapath];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"saveOutPutSuccess" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getTextFieldValues
{
    UITextField *textField = [[UITextField alloc]init];
    
    switch (textField.tag) {
        case 501:
            textField.text = _outPutMoneyData;
            break;
         case 502:
            if (textField.hidden == YES) {
                return;
            }
            textField.text = _usedModel;
            break;
            case 503:
            textField.text = _commentData;
        default:
            break;
    }
}
- (void)endAction:(id)sender
{
    if (_choicePicker.hidden == NO) {
        [self viewAnimation:_choicePicker willHidden:YES];
        [self toolBarAnimation:_didToolBar willHidden:YES];
    }
    if (_timePickerView.hidden == NO) {
        [self viewAnimation:_timePickerView willHidden:YES];
        [self toolBarAnimation:_didToolBar willHidden:YES];
    }
    
        [self.InsertTableView setUserInteractionEnabled:YES];

    
    
    
}
- (void)doneAction:(id)sender
{
    
    if (_choicePicker.hidden ==NO) {
        //获取支出类型的值
        NSInteger row = [self.choicePicker selectedRowInComponent:0];
    _usedModel = [_dataArray objectAtIndex:row];
        [self viewAnimation:_choicePicker willHidden:YES];
        [self toolBarAnimation:_didToolBar willHidden:YES];
        [self.InsertTableView setUserInteractionEnabled:YES];

    }else
    {
    //获取选择的时间
        [self getDate];
        [self viewAnimation:_timePickerView willHidden:YES];
        [self toolBarAnimation:_didToolBar willHidden:YES];
        [self.InsertTableView setUserInteractionEnabled:YES];
    }
    
    [self.InsertTableView reloadData];
}

- (void)getDate
{
    NSDate *date = self.timePickerView.date;
    NSDateFormatter *outFormatter = [[NSDateFormatter alloc] init];
    [outFormatter setDateFormat:@"yyyy-MM-dd"];
    _day = [outFormatter stringFromDate:date];
   
}

#pragma mark -- textField.text
-(void)moneyValueChange:(id)sender
{
    //回调textfield的编辑函数
    UITextField *textField = (UITextField *)sender;
    _outPutMoneyData = textField.text;
    NSLog(@"%@",_outPutMoneyData);

   
}
-(void)usedValueChange:(id)sender
{
    UITextField *textField = (UITextField *)sender;
    _usedModel = textField.text;
}

-(void)commentValuesChange:(id)sender
{
    UITextField *textField = (UITextField *)sender;
    _commentData = textField.text;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
        return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
  
    return _dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
   
    NSString *titleStr ;
    titleStr = _dataArray[row];
    return titleStr;
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == 1) {
        WMMoneyCell *cell = [self.InsertTableView dequeueReusableCellWithIdentifier:@"moneyCell" ];
        cell.backgroundColor = [UIColor clearColor];
        cell.moneyTextField.tag = 501;
        cell.moneyTextField.delegate = self;
        cell.moneyTextField.returnKeyType = UIReturnKeyDone;
        cell.moneyTextField.keyboardType = UIKeyboardTypeDefault;
        [cell.moneyTextField addTarget:self action:@selector(moneyValueChange:) forControlEvents:UIControlEventEditingChanged];
        return cell;
    }
    if (indexPath.row == 2) {
        WMTimeCell *cell = [self.InsertTableView dequeueReusableCellWithIdentifier:@"timeCell" ];
         cell.backgroundColor = [UIColor clearColor];
        cell.timeLabel.text = _day;
        cell.tag = 1002;
        return cell;
    }
    if (indexPath.row == 3) {
        if (_dataArray == nil ) {
            WMUsedCell *cell = [self.InsertTableView dequeueReusableCellWithIdentifier:@"usedCell"];
             cell.backgroundColor = [UIColor clearColor];
            cell.usedTextField.hidden = NO;
            cell.usedLabel.hidden = YES;
            cell.usedTextField.tag = 502;
            cell.usedTextField.delegate = self;
            cell.usedTextField.returnKeyType = UIReturnKeyDone;
            cell.usedTextField.keyboardType = UIKeyboardTypeDefault;
              [cell.usedTextField addTarget:self action:@selector(usedValueChange:) forControlEvents:UIControlEventEditingChanged];
            
            cell.tag = 1003;
            return cell;
        }else
        {
        WMUsedCell *cell = [self.InsertTableView dequeueReusableCellWithIdentifier:@"usedCell"];
             cell.backgroundColor = [UIColor clearColor];
            cell.usedLabel.text = _usedModel;
            cell.tag = 1004;
        return cell;
        }
    }
    if (indexPath.row == 4) {
        WMCommentCell *cell = [self.InsertTableView dequeueReusableCellWithIdentifier:@"commentCell"];
        cell.commentLabel.tag = 503;
         cell.backgroundColor = [UIColor clearColor];
        cell.commentLabel.delegate = self;
        cell.commentLabel.returnKeyType = UIReturnKeyDone;
        cell.commentLabel.keyboardType = UIKeyboardTypeDefault;
        [cell.commentLabel addTarget:self action:@selector(commentValuesChange:) forControlEvents:UIControlEventEditingChanged];
        NSLog( @"%@",_commentData);
        cell.tag = 1005;
        return cell;
    }
    WMModelCell *cell = [self.InsertTableView dequeueReusableCellWithIdentifier:@"modelCell"];
     cell.backgroundColor = [UIColor clearColor];
    cell.tag = 1000;
    cell.modelLabel.text = _outModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2)
    {   //调用上面写的动画方法
        [self toolBarAnimation:_didToolBar willHidden:NO];
        [self viewAnimation:_timePickerView willHidden:NO];
        [self.InsertTableView setUserInteractionEnabled:NO];
        
        [self.tabBarController setHidesBottomBarWhenPushed:YES];
       
        }
    if (indexPath.row == 3)
    {
        if (_dataArray == nil) {
            return;
        }
        [self toolBarAnimation:_didToolBar willHidden:NO];
        [self viewAnimation:_choicePicker willHidden:NO];
        [self.InsertTableView setUserInteractionEnabled:NO];
        
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
