//
//  WMStockMoreVC.m
//  WealthManager
//
//  Created by Maser on 15/5/10.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMStockMoreVC.h"
#import "WMStockModel.h"
@interface WMStockMoreVC ()
@property (weak, nonatomic) IBOutlet UILabel *yesTodEndPri;
@property (weak, nonatomic) IBOutlet UILabel *todayStarPri;
@property (weak, nonatomic) IBOutlet UILabel *todayMaxPri;
@property (weak, nonatomic) IBOutlet UILabel *todayMinPri;
@property (weak, nonatomic) IBOutlet UILabel *todayNowPri;
@property (weak, nonatomic) IBOutlet UILabel *traNumber;
@property (weak, nonatomic) IBOutlet UIImageView *stockPic;
@property (weak, nonatomic) IBOutlet UILabel *gidLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *fenghuolun;


@property (nonatomic,strong)WMStockModel *stockModel;

@end

@implementation WMStockMoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", NSStringFromCGRect(_stockPic.frame));
       NSLog(@"%@", NSStringFromCGRect(_fenghuolun.frame));
        [self.view addSubview:_fenghuolun];
    [NSThread detachNewThreadSelector:@selector(getImageWithURL:) toTarget:self withObject:_stockModel.stockPic[@"minurl"]];
    
    NSLog(@"%@",_stockModel);
    self.title = _stockModel.stockData[@"name"];
    [self steupView];
   }
-(void)steupView
{
    self.title = _stockModel.stockData[@"name"];
    self.yesTodEndPri.text = _stockModel.stockData[@"yestodEndPri"];
    self.todayStarPri.text = _stockModel.stockData[@"todayStartPri"];
    self.todayMaxPri.text = _stockModel.stockData[@"todayMax"];
    self.todayMinPri.text = _stockModel.stockData[@"todayMin"];
    self.todayNowPri.text = _stockModel.stockData[@"nowPri"];
    self.traNumber.text = _stockModel.stockData[@"traNumber"];
    self.gidLabel.text = _stockModel.stockData[@"gid"];
    self.timeLabel.text = [NSString stringWithFormat:@"更新于%@  %@",_stockModel.stockData[@"date"],_stockModel.stockData[@"time"]];
    
    
    
}
-(void)setBlackImage
{
    _stockPic.image = [UIImage imageNamed:@"blackImage.png"];
}
-(void)getImageWithURL:(NSString *)url
{
    _fenghuolun.hidden = NO;
    [self.view bringSubviewToFront:_fenghuolun];
    [_fenghuolun startAnimating];
    
    [self setBlackImage];
    UIImage *image = [[UIImage alloc]init];
    NSURL *imageUrl = [NSURL URLWithString:url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    image = [UIImage imageWithData:imageData];
    [_fenghuolun stopAnimating];
    [_fenghuolun hidesWhenStopped];
    [self performSelectorOnMainThread:@selector(updataImage:) withObject:image waitUntilDone:YES];
}

-(void)updataImage:(UIImage *)image
{
    _stockPic.image = image;
}
- (IBAction)changeImage:(id)sender
{
    UISegmentedControl *segment = sender;
    switch (segment.selectedSegmentIndex) {
        case 0:
            _fenghuolun.hidden = NO;
            [self.view bringSubviewToFront:_fenghuolun];
            [_fenghuolun startAnimating];
            [NSThread detachNewThreadSelector:@selector(getImageWithURL:) toTarget:self withObject:_stockModel.stockPic[@"minurl"]];
            
            break;
        case 1:
            _fenghuolun.hidden = NO;
            [self.view bringSubviewToFront:_fenghuolun];
            [_fenghuolun startAnimating];
            [NSThread detachNewThreadSelector:@selector(getImageWithURL:) toTarget:self withObject:_stockModel.stockPic[@"dayurl"]];
            
            break;
        case 2:
            _fenghuolun.hidden = NO;
            [self.view bringSubviewToFront:_fenghuolun];
            [_fenghuolun startAnimating];
            [NSThread detachNewThreadSelector:@selector(getImageWithURL:) toTarget:self withObject:_stockModel.stockPic[@"weekurl"]];

           
            break;
        case 3:
            _fenghuolun.hidden = NO;
            [self.view bringSubviewToFront:_fenghuolun];
            [_fenghuolun startAnimating];
            [NSThread detachNewThreadSelector:@selector(getImageWithURL:) toTarget:self withObject:_stockModel.stockPic[@"monthurl"]];
           
            break;
            

        default:
            break;
    }
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

@end
