//
//  QYViewController.m
//  正则表达式作业
//
//  Created by 杨俊杰 on 15-3-10.
//  Copyright (c) 2015年 QYApple. All rights reserved.
//

#import "QYViewController.h"

@interface QYViewController ()

//@property (weak, nonatomic) IBOutlet UITextField *inputNumber;

@property (weak, nonatomic) IBOutlet UITextField *inputNumber;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UILabel *numberResultShow;


@property (weak, nonatomic) IBOutlet UITextField *emailRegester;
@property (weak, nonatomic) IBOutlet UIButton *emailCommit;
@property (weak, nonatomic) IBOutlet UILabel *emailResultShow;

@property (strong,nonatomic)UIControl *controlButton;
@property (strong,nonatomic)NSString *inputPhoneNumber;
@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _inputNumber.keyboardType = UIKeyboardTypeNumberPad;
   //创建一个全屏的UIControl，点击空白处任意地方让键盘收起
    _controlButton = [[UIControl alloc]init];
    _controlButton.frame = self.view.bounds;
    [_controlButton addTarget:self action:@selector(loseFirst)
    forControlEvents:UIControlEventTouchDown];
  //由于创建的UIControl会覆盖storybord上的视图，所以对层次结构重新排定
    [self.view addSubview:_controlButton];
    [_controlButton addSubview:_inputNumber];
    [_controlButton addSubview:_searchButton];
    [_controlButton addSubview:_numberResultShow];
    [_controlButton addSubview:_emailCommit];
    [_controlButton addSubview:_emailRegester];
    [_controlButton addSubview:_emailResultShow];
}


//
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//点击查询按钮开始查询  并在下面的label中显示查询结果
- (IBAction)searchButtonEvent
{
    [ _inputNumber resignFirstResponder];
    //对输入的号码就行判断
    _inputPhoneNumber = _inputNumber.text;
    
    
/********先对是否是有效的号码进行判断 // 使用数组的方法  **************/
    
    //把输入的内容放到数组中
    NSArray *inputNumArr = @[_inputPhoneNumber];
    NSString * numberRegex = @"^1(3[0-9]|4[5-7]|5[0-3]|5[5-9]|7[6-8]|8[0-9])[0-9]{8}";
    //创建逻辑需要的谓词，并在谓词中使用正则表达式
    NSPredicate *predicate = [NSPredicate predicateWithFormat:/*@"self MATCHES %@",*/numberRegex];
    //对数组中的输入 用谓词进行筛选。
    NSArray *newNumArr = [inputNumArr filteredArrayUsingPredicate:predicate];
    
    if (newNumArr.count == 1)
    {
        
        
/*******接着判断输入的号码属于哪个运营商 // 使用数组的方法*************/
        //判断是否是中国移动的号码
       NSString *mobileStr =
        @"^1((3[5-9]|5[0-2]|5[7-9]|8[2-4]|8[7-8]|47|78)[0-9]{8})|(34[0-8][0-9]{7})";
        NSPredicate *predicateMobile = [NSPredicate predicateWithFormat:@"self MATCHES %@",mobileStr];
      NSArray *mobileArr = [newNumArr filteredArrayUsingPredicate:predicateMobile];
        if(mobileArr.count == 1)
        {_numberResultShow.text = @"中国移动";}
        
        //判断是否是中国联通的号码
        NSString *unioncomStr = @"^1(3[0-2]|5[5-6]|8[5-6]|45|76)[0-9]{8}";
        NSPredicate *predicateUnion = [NSPredicate predicateWithFormat:
          @"self MATCHES %@",unioncomStr];
        NSArray *unionArr = [newNumArr filteredArrayUsingPredicate:predicateUnion];
        if(unionArr.count == 1)
        {_numberResultShow.text = @"中国联通";}
        
        //判断是否是中国电信的号码
        NSString *telecomStr = @"^1((33|53|80|81|89|77)[0-9]{8})|((349)[0-9]{7})";
        NSPredicate *predicateTelecom = [NSPredicate predicateWithFormat:@"self MATCHES %@",telecomStr];
        NSArray *telecomArr = [newNumArr filteredArrayUsingPredicate:predicateTelecom];
        if(telecomArr.count == 1)
        {_numberResultShow.text = @"中国电信";}
    }
    if (newNumArr.count == 0)
    {
        _numberResultShow.text = @"请输入合法手机号码";
    }
    
}


//提交，并进行合法性检查，且把结果显示在下面的label中
- (IBAction)commitButtonEvent
{
    [_emailRegester resignFirstResponder];
    NSString *email = _emailRegester.text;
    
    
/*****对邮箱的合法性判断   //  使用evaluateWithObject方法 *********/
    NSString *emailTest = @"!@.{1,7}@.{1,7}!@";
     NSPredicate *predicateEmail = [NSPredicate predicateWithFormat:
                                    @"self MATCHES %@",emailTest];
    BOOL wheather = [predicateEmail evaluateWithObject:email];
     if(wheather)
    {_emailResultShow.text = @"邮 箱 注 册 成 功";}
     else
    {_emailResultShow.text = @"请 输 入 合 法 用 户 名";}
}


//当注册文本框开始编辑的时候让该文本框整体上移
- (IBAction)regesterUpBounds
{
    [UIView  animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y-210, self.view.bounds.size.width, self.view.bounds.size.height);}];
}


//当文本框结束编辑的时候让该文本框回到自己原来的位置
- (IBAction)regesterFrameBack:(id)sender
{
    [UIView  animateWithDuration:0.5 animations:^{
        self.view.frame = self.view.bounds;}];
}


//点击空白处任意地方让键盘收起
- (void)loseFirst
{
    [ _inputNumber resignFirstResponder];
    [_emailRegester resignFirstResponder];
}

@end
