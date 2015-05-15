//
//  QYCustomCollectionViewController.m
//  CollectionView
//
//  Created by qingyun on 15-4-23.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

//1.初始化CollectionView
//2.设置fowlayout
//3.数据源和代理


#import "QYCustomCollectionViewController.h"
#import "QYHeaterView.h"
#import "QYCell.h"

@interface QYCustomCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) UICollectionView *collectionView;



@end

@implementation QYCustomCollectionViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1.
//    self.collectionView = [[UICollectionView alloc] init];
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flow];
    self.collectionView.frame = self.view.frame;
    self.collectionView.delegate= self;
    self.collectionView.dataSource = self;
    //2.
    
    flow.headerReferenceSize = CGSizeMake(320, 30);
//    flow.footerReferenceSize = CGSizeMake(320, 30);
    flow.itemSize = CGSizeMake(80, 80);
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flow.minimumInteritemSpacing = 20;
    flow.minimumLineSpacing = 20;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SectionHader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"Collection" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [self.collectionView reloadData];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    NSLog(@"%@", self.collectionView.delegate);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //section
    return 5;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        //返回footer
        return nil;
    }else{
        //返回header
        
        QYHeaterView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader" forIndexPath:indexPath];
        return header;
    }

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //返回每一个元素
    
    QYCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.nameLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    return cell;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
