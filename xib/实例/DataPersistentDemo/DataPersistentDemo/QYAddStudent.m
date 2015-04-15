//
//  QYAddStudent.m
//  DataPersistentDemo
//
//  Created by qingyun on 15-3-24.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYAddStudent.h"
#import "QYSQLiteDBManager.h"
#import "QYStudentModel.h"

@interface QYAddStudent () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *ID;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *sex;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (nonatomic, strong) QYSQLiteDBManager *manager;

@end

@implementation QYAddStudent

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
}

- (QYSQLiteDBManager *)manager
{
    if (_manager == nil) {
        _manager = [QYSQLiteDBManager sharedDBManager];
    }
    return _manager;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    if (CGRectContainsPoint(_icon.frame, location)) {
        // 弹出图片选择控制器
        UIImagePickerController *imgPickerController = [[UIImagePickerController alloc] init];
        
        imgPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imgPickerController.delegate = self;
        
        [self presentViewController:imgPickerController animated:YES completion:^{

        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    _icon.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:^{

    }];
}

- (IBAction)save:(id)sender {
    QYStudentModel *student = [[QYStudentModel alloc] init];
    student.ID = [_ID.text intValue];
    student.name = _name.text;
    student.age = [_age.text intValue];
    student.sex = _sex.text;
    student.icon = _icon.image;
    
    [self.manager insertStudent:student];
    
    _ID.text = nil;
    _name.text = nil;
    _age.text = nil;
    _sex.text = nil;
    _icon.image = nil;
    
    NSLog(@"insert ...");
}

- (IBAction)textFieldDidEndOnExit:(id)sender {
    [sender resignFirstResponder];
}
@end
