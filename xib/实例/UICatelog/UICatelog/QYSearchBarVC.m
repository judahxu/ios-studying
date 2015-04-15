//
//  QYSearchBarVC.m
//  UICatelog
//
//  Created by qingyun on 15-2-28.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYSearchBarVC.h"

@interface QYSearchBarVC () <UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation QYSearchBarVC

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

    self.title = @"SearchBar";
    
    // 创建UISearchBar对象
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
    
    _searchBar.showsBookmarkButton = YES;
    _searchBar.showsCancelButton = YES;
    
    _searchBar.delegate = self;
    
    // 添加为子视图
    [self.view addSubview:_searchBar];
    // 创建segmented
    NSArray *items = @[@"Normal", @"Tinted", @"Background"];
    UISegmentedControl *controlView = [[UISegmentedControl alloc] initWithItems:items];
    controlView.frame = CGRectMake(30, 130, 260, 30);
    controlView.tintColor = [UIColor grayColor];
    
    [controlView addTarget:self action:@selector(changeStyle:) forControlEvents:UIControlEventValueChanged];
    
    // 添加到self.view的子视图
    [self.view addSubview:controlView];
    
  
    
}

#pragma mark - UISearchBar Delegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [_searchBar resignFirstResponder];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [_searchBar resignFirstResponder];
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%s", __func__);
}

-(void)changeStyle:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
            
        case 0:
            _searchBar.barTintColor  = nil;
            _searchBar.backgroundImage = nil;
            [_searchBar setImage:nil forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
            
            break;
        case 1:
            _searchBar.barTintColor = [UIColor redColor];
            break;
        case 2:
            [_searchBar setBackgroundImage:[UIImage imageNamed:@"searchBarBackground"]];
            [_searchBar setImage:[UIImage imageNamed:@"bookmarkImage"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
            [_searchBar setImage:[UIImage imageNamed:@"bookmarkImageHighlighted"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateHighlighted];
            break;
            
        default:
            break;
    }
}


@end
