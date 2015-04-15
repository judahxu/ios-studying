//
//  QYViewController.m
//  UITextfiledDemo
//
//  Created by qingyun on 15-2-5.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"

@interface QYViewController ()

@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITextField *myText =  [[UITextField alloc] initWithFrame:CGRectMake(50, 50, 220, 60)];
    UITextField *myText1 =  [[UITextField alloc] initWithFrame:CGRectMake(50, 250, 220, 60)];
    myText1.borderStyle = UITextBorderStyleBezel;
    //myText1.delegate = self;
    
    // 与文本相关的属性
    myText.borderStyle = UITextBorderStyleLine;
    myText.textColor = [UIColor whiteColor];
    myText.placeholder = @"请输入5个数"; //textColor并不影响placeholder的颜色
    myText.font = [UIFont boldSystemFontOfSize:30];
    myText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; // 垂直方向上内容布置方式
    myText.adjustsFontSizeToFitWidth = YES;
    myText.minimumFontSize = 20; // adjustsFontSizeToFitWidth开启时可以适应的最小字体
    //myText.secureTextEntry = YES;
    
    // 与编辑相关的属性
    myText.autocapitalizationType = UITextAutocapitalizationTypeSentences; // 设置首字母是否大写，其类型的自己测试
    //myText.autocorrectionType = UITextAutocorrectionTypeDefault; // 检查拼写是否错误
    myText.spellCheckingType = UITextSpellCheckingTypeDefault; // 拼写关联，自动补全单词，需要myText.autocorrectionType设置成UITextAutocorrectionTypeDefault
    
    myText.keyboardType = UIKeyboardTypeEmailAddress; // 键盘类型，例子里是一个电话的键盘
    
    myText.keyboardAppearance = UIKeyboardAppearanceDark; // 键盘的外观风格
    
    myText.returnKeyType = UIReturnKeyGo; // 回车键或者返回键的样式
    myText.enablesReturnKeyAutomatically = YES; // 当文本内容为空的时候禁用returnkey
    myText.clearsOnBeginEditing = YES; // 当文本获取第一响应者的时候自动清空原来的输入内容
    myText.clearButtonMode = UITextFieldViewModeAlways; // 清空文本内容
    
    
    // 与外观相关的属性
    myText.background = [UIImage imageNamed:@"back"];
    // 禁用时的背景
    // myText.disabledBackground
    
    // 左右装饰视图，类型是UIView，意味所有控件都可以使用
    // CGRECTZREO,可以认为在实例化这个图片控件的时候用的是这样一个去区域，最终我们也不需要指定它的frame
    UIImageView *leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar_enterprise_vip"]];
    
    myText1.leftView = leftImage;
    myText1.leftViewMode = UITextFieldViewModeAlways;
    
    myText.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar_vgirl"]];
    myText.rightViewMode = UITextFieldViewModeNever; // ****** 右侧装饰视图会盖掉 clearButton
    
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    inputView.backgroundColor = [UIColor magentaColor];
    // inputview是代替原来键盘弹出的位置，不用关心它的位置，但是大小要知道
    //myText.inputView = inputView;
    
    UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    accessoryView.backgroundColor = [UIColor brownColor];
    // inputAccessoryView是在键盘弹出位置的上方与键盘区共存，不用关心它的位置，但是大小要知道
    myText.inputAccessoryView = accessoryView;
    myText.tag = 1001;
    
    [myText addTarget:self action:@selector(testEdit:) forControlEvents:UIControlEventEditingDidBegin]; // 开始编辑，就是获取第一响应者的时候
    [myText addTarget:self action:@selector(testEditEnd:) forControlEvents:UIControlEventEditingDidEnd];// 结束编辑，就是失去第一响应者的时候
    [myText addTarget:self action:@selector(testEdit:) forControlEvents:UIControlEventEditingChanged]; // 改变输入内容
    
   // myText.delegate = self;
    
    [self.view addSubview:myText];
    [self.view addSubview:myText1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(120, 140, 80, 44);
    button2.backgroundColor = [UIColor grayColor];
    
    // 按钮的一些常用显示的内容都是通过下面的set方法来实现的，而不是直接操作属性
//    [button2 setTitle:@"点我" forState:UIControlStateNormal];
//    [button2 setTitle:@"点过了" forState:UIControlStateHighlighted];
    
    [button2 addTarget:self action:@selector(testFoucs) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:button2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField func
// 获取/失去第一响应者
- (void)testFoucs
{
    UITextField *textFiled = (UITextField *)[self.view viewWithTag:1001];
    if (textFiled.isFirstResponder) {
        [textFiled resignFirstResponder]; // 失去第一响应者
    } else {
        [textFiled becomeFirstResponder]; // 获取第一响应者
    }
}

- (void)testEdit:(UITextField *)sender
{
    NSLog(@"textfield %s", __func__);
}

- (BOOL)testEditEnd:(UITextField *)sender
{
    NSLog(@"textfield %s", __func__);
    return NO;
}

#pragma mark - UITExtfiled delegate
// 只要指定了代理，不管有多少个UITextField，都会执行这个代理里的逻辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES; //返回值的意思是是否获取第一响应者
}
// 这个代理可以捕获到每一次输入的内容，一般用于判断当前输入的内容是否合法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"gcd"]){
        return NO;
    }
    return YES;
}
// 点击clearButton清除文本内容的时候调用
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    NSLog(@">>>>>>> %s <<<<<<<<<",__func__);
    return NO;
}
// 点击returnkey的时候触发
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@">>>>>>> %s <<<<<<<<<",__func__);
    return NO;
}

@end
