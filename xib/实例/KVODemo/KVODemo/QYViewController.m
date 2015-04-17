//
//  QYViewController.m
//  KVODemo
//
//  Created by qingyun on 15-3-10.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"
#import "QYPersonalInfo.h"

@interface QYViewController ()
@property (weak, nonatomic) IBOutlet UIView *indicator;
@property (nonatomic, strong) QYPersonalInfo *pInfo;

@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 模拟数据模型获取
    [self setupModels];
    
    [self setupViews];
    
    // 对pInfo对象，添加了一个观察者(控制器)，观察其 blood 属性，当该属性值变化时，会通知其新的值
    
    NSString *string = @"xxx";

    [self.pInfo addObserver:self forKeyPath:@"blood" options:NSKeyValueObservingOptionNew context:(__bridge void *)(string)];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.pInfo) {
        if ([keyPath isEqualToString:@"blood"]) {
            // ...
        double newBlood = [change[@"new"] doubleValue];
            
            NSString *string = (__bridge NSString *)(context);
            
            NSLog(@"%@", string);
            
            if (newBlood <= 100) {
                _indicator.backgroundColor = [UIColor redColor];
                [UIView animateWithDuration:0.3 animations:^{
                    _indicator.backgroundColor = [UIColor redColor];
                }];

                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"血量过低!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [alert show];
            }
            
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = self.indicator.frame;
                frame = CGRectMake(frame.origin.x, frame.origin.y+100, frame.size.width, newBlood);
                self.indicator.frame = frame;
            }];
        }
    }
}

- (void)setupViews
{
    _indicator.layer.cornerRadius = 10;
    CGRect frame = _indicator.frame;
    frame.size.height = _pInfo.blood;
    _indicator.frame = frame;
}

- (void)setupModels
{
    _pInfo = [[QYPersonalInfo alloc] init];
    _pInfo.blood = 400;
}
- (IBAction)decreaseBlood:(UISwipeGestureRecognizer *)sender {
    
    if (self.pInfo.blood <= 100) {
        return;
    }
    
    self.pInfo.blood -= 100;
    NSLog(@"%f", self.pInfo.blood);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    // 移除观察者
    [self.pInfo removeObserver:self forKeyPath:@"blood"];
}

@end
