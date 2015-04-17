//
//  QYTextFieldViewController.m
//  UICatalogDemo
//
//  Created by qingyun on 14-6-26.
//  Copyright (c) 2014年 hnqingyun. All rights reserved.
//

#import "QYTextFieldViewController.h"

#define kViewTag     101

static NSString *kSectionTitleKey = @"sectionTitle";
static NSString *kViewKey = @"viewKey";
static NSString *kSourceKey = @"sourceKey";

static NSString *kViewCellID = @"viewCellID";
static NSString *kSourceCellID = @"sourceCellID";

@interface QYTextFieldViewController ()
@property (nonatomic, retain) NSArray *dataArray;

@property (nonatomic, retain) UITextField *textFieldNormal;
@property (nonatomic, retain) UITextField *textFieldRounded;
@property (nonatomic, retain) UITextField *textFieldSecure;
@property (nonatomic, retain) UITextField *textFieldLeftView;
@end

@implementation QYTextFieldViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // title
    self.title = @"TextFields";
    
    // 初始化数据
    self.dataArray = @[
                       @{ kSectionTitleKey:@"UITextField",
                          kViewKey:self.textFieldNormal,
                          kSourceKey:@"QYTextFieldController.m: textFieldNormal"
                           },
                       @{ kSectionTitleKey:@"UITextField Rounded",
                          kViewKey:self.textFieldRounded,
                          kSourceKey:@"QYTextFieldController.m: textFieldRounded"
                          },
                       @{ kSectionTitleKey:@"UITextField Secure",
                          kViewKey:self.textFieldSecure,
                          kSourceKey:@"QYTextFieldController.m: textFieldSecure"
                          },
                       @{ kSectionTitleKey:@"UITextField (With LeftView)",
                          kViewKey:self.textFieldLeftView,
                          kSourceKey:@"QYTextFieldController.m: textFieldLeftView"
                          },
                       ];
    
    // 注册cell标示符
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kViewCellID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSourceCellID];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_dataArray[section] objectForKey:kSectionTitleKey];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSDictionary *dict = self.dataArray[indexPath.section];
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:kViewCellID forIndexPath:indexPath];
        // Configure the cell...
        // 移除之前cell里面嵌入的view
        UIView *view2remove = [cell.contentView viewWithTag:kViewTag];
        if (view2remove) {
            [view2remove removeFromSuperview];
        }
        
        // 添加textfield到cell上
        UITextField *textField = [dict objectForKey:kViewKey];
        [cell.contentView addSubview:textField];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:kSourceCellID forIndexPath:indexPath];
        // Configure the cell...
        cell.textLabel.text = [dict objectForKey:kSourceKey];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - TableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == 0 ? 50 : 22;
}

#pragma mark - lasy creation of textfields
- (UITextField *)textFieldNormal
{
    if (_textFieldNormal == nil) {
        _textFieldNormal = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 280, 30)];
        
        _textFieldNormal.borderStyle = UITextBorderStyleBezel;
        _textFieldNormal.placeholder = @"<enter text>";
        _textFieldNormal.returnKeyType = UIReturnKeyDone;
        _textFieldNormal.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _textFieldNormal.delegate = self;
        
        _textFieldNormal.tag = kViewTag;
    }
    return _textFieldNormal;
}

- (UITextField *)textFieldRounded
{
    if (_textFieldRounded == nil) {
        _textFieldRounded = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 280, 30)];
        
        _textFieldRounded.borderStyle = UITextBorderStyleRoundedRect;
        _textFieldRounded.placeholder = @"<enter text>";
        _textFieldRounded.returnKeyType = UIReturnKeyDone;
        _textFieldRounded.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _textFieldRounded.delegate = self;
        
        _textFieldRounded.tag = kViewTag;
    }
    return _textFieldRounded;
}

- (UITextField *)textFieldSecure
{
    if (_textFieldSecure == nil) {
        _textFieldSecure = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 280, 30)];
        
        _textFieldSecure.borderStyle = UITextBorderStyleBezel;
        _textFieldSecure.placeholder = @"<enter password>";
        _textFieldSecure.returnKeyType = UIReturnKeyDone;
        _textFieldSecure.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _textFieldSecure.delegate = self;
        
        _textFieldSecure.tag = kViewTag;
        
        // 安全输入
        _textFieldSecure.secureTextEntry = YES;
    }
    return _textFieldSecure;
}

- (UITextField *)textFieldLeftView
{
    if (_textFieldLeftView == nil) {
        _textFieldLeftView = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 280, 30)];
        
        _textFieldLeftView.borderStyle = UITextBorderStyleBezel;
        _textFieldLeftView.placeholder = @"<enter text>";
        _textFieldLeftView.returnKeyType = UIReturnKeyDone;
        _textFieldLeftView.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _textFieldLeftView.delegate = self;
        
        _textFieldLeftView.tag = kViewTag;
        
        // 左视图
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"segment_check"]];
        _textFieldLeftView.leftView = leftView;
        _textFieldLeftView.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return _textFieldLeftView;
}


#pragma mark - textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
