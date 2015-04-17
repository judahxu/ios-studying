//
//  QYViewController1.m
//  正则表达式作业
//
//  Created by qingyun on 15/3/15.
//  Copyright (c) 2015年 QYApple. All rights reserved.
//

#import "QYViewController1.h"

@interface QYViewController1 ()
@property (weak, nonatomic) IBOutlet UITextField *inputNumber;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UILabel *numberResultShow;


@property (weak, nonatomic) IBOutlet UITextField *emailRegester;
@property (weak, nonatomic) IBOutlet UIButton *emailCommit;
@property (weak, nonatomic) IBOutlet UILabel *emailResultShow;

@property (strong,nonatomic)UIControl *controlButton;
@property (strong,nonatomic)NSString *inputPhoneNumber;
@end

@implementation QYViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)searchButtonEvent
{
    [_inputNumber resignFirstResponder];
    _inputPhoneNumber = _inputNumber.text;
    
    
    NSArray *inputNumArr =@[_inputPhoneNumber];
    NSString *numberRegex =@"^1(3[0-9]|4[5-7]|5[0-3]|5[5-9]|7[6-8]|8[0-9])[0-9]{8}";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:numberRegex];
    NSArray *newNumArr = [inputNumArr filteredArrayUsingPredicate:predicate];
    
    if (newNumArr.count ==1) {
        NSString *mobileArr = [newNumArr filteredArrayUsingPredicate:predicate]
    }




}










@end
