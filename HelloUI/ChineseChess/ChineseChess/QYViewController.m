//
//  QYViewController.m
//  ChineseChess
//
//  Created by qingyun on 15/2/4.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "QYViewController.h"

@interface QYViewController ()

@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    UIView *chess = [[UIView alloc]initWithFrame:CGRectMake(20, 20, 250, 250)];
    chess.backgroundColor = [UIColor blackColor];
    //chess.layoutSubviews = {0};
  
    int i,j;
    //int a= 0;
    for (j=0; j<8; j++) {
        for (i=0; i<8; i++) {
             //UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20+31.25*i, 20+31.25*i, 31.25, 31.25)];
            if ((i-j) % 2 == 0) {
                UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(20+31.25*i, 20+31.25*j, 31.25, 31.25)];
                button1.backgroundColor = [UIColor grayColor];
                [chess addSubview:button1];
                button1.tag = 100 ;
            }else {
            UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(20+31.25*i, 20+31.25*j, 31.25, 31.25)];
            button2.backgroundColor = [UIColor redColor];
            [chess addSubview:button2];
                button2.tag = 101;
            }
        
                    }
       
    }
     [self.view addSubview:chess];
    [UIView beginAnimations:@"viewTransfrom" context:nil];
    
    chess.transform = CGAffineTransformScale(chess.transform, 0.2, 0.2);
    chess.transform = CGAffineTransformRotate(chess.transform, 100);
    chess.transform = CGAffineTransformTranslate(chess.transform, -120, -120);
    [UIView commitAnimations];
    
    UIButton *butt1 = [self.view viewWithTag:100];
    UIButton *butt2 = [self.view viewWithTag:101];
//    NSInteger but1 = [self.view.subviews indexOfObject:butt1];
//    NSInteger but2 = [self.view.subviews indexOfObject:butt2];
    [butt1 addTarget:self action:@selector(doAction) forControlEvents:UIControlEventTouchDown];
    
}

- (void)doAction
{
   //self.backgroundColor = [UIColor blueColor];
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"这是一个警告！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的",@"我才不管",@"以后再说", nil];
    [alert show];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
