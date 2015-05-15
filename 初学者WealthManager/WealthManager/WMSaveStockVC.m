//
//  WMSaveStockVC.m
//  WealthManager
//
//  Created by Maser on 15/5/11.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMSaveStockVC.h"
#import "WMfileManager.h"



@interface WMSaveStockVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *stockGid;
@property (nonatomic,strong)NSMutableArray *gidArray;
@property (copy ,nonatomic)NSString *filePath;
@end

@implementation WMSaveStockVC

- (void)viewDidLoad {
    [super viewDidLoad];
  _filePath = [WMfileManager dataDocPath:@"stockGid.plist"];
    _gidArray = [[NSMutableArray alloc]initWithContentsOfFile:_filePath];
    [self steupTextField];
}
-(void)steupTextField
{
    _stockGid.returnKeyType = UIReturnKeyDone;
    _stockGid.keyboardType = UIKeyboardTypeDefault;
    _stockGid.delegate = self;
}
- (BOOL)isValidStockSz
{
    
    NSString *stockSzRelx =@"^sz(0[0](0[0-9]{3}|1([6][9][6]|[8][9][6])|2[0-7][0-9][0-9]))" ;
    NSPredicate *SZpredicate = [NSPredicate predicateWithFormat:@"self MATCHES %@",stockSzRelx];
    
    if ([SZpredicate evaluateWithObject:_stockGid.text]) {
        
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isValidStockSh
{
    
    NSString *stockShRelx =@"^sh[6][0](0[0-9]{3}|1[0][0][0-7])";
    NSPredicate *SHpredicate = [NSPredicate predicateWithFormat:@"self MATCHES %@",stockShRelx];
    
    if ([SHpredicate evaluateWithObject:_stockGid.text]) {
        
        return YES;
    } else {
        return NO;
    }
}
- (IBAction)escAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)saveStockAction:(id)sender
{
    
    BOOL sh = [self isValidStockSh];
    BOOL sz = [self isValidStockSz];
    if ([_gidArray containsObject:_stockGid.text]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该股票已存在" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if (sh == NO&&sz == NO) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"输入的股票编码不对" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    [_gidArray addObject:_stockGid.text];
    [_gidArray writeToFile:_filePath atomically:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"saveGidAccess" object:nil];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)endAction:(id)sender
{
    [_stockGid resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
