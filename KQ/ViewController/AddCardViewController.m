//
//  AddCardViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-10.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "AddCardViewController.h"
#import "NetworkClient.h"
#import "UserController.h"
#import "KQRootViewController.h"
#import "LibraryManager.h"

@interface AddCardViewController (){
    UITextField *_tf;
    UIButton *_button;
}

@end

@implementation AddCardViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    L();
    if (isIOS7) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.title = @"添加银行卡";
    
    self.view.backgroundColor  = kColorBG;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 50)];
    label.text = @"输入卡号即可成功添加银行卡";
    label.textColor = kColorGray;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:kFontBoldName size:14];
    
    UITextField *tf;
    UIButton *btn;
    tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, 300, 40)];
    tf.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_mycards.png"]];
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.backgroundColor = [[UIColor alloc] initWithWhite:1 alpha:.5];
    tf.placeholder = @"银行卡卡号";
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _tf = tf;
    
    
    btn = [UIButton buttonWithFrame:CGRectMake(10, CGRectGetMaxY(_tf.frame)+20 , 300, 40) title:@"提交" bgImageName:nil target:self action:@selector(addPressed:)];
    btn.backgroundColor = kColorYellow;
    btn.titleLabel.font = [UIFont fontWithName:kFontBoldName size:20];
    _button = btn;
    
    [self.view addSubview:label];
    [self.view addSubview:_tf];
    [self.view addSubview:_button];
    
//    NSLog(@"label # %@",label);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [_tf becomeFirstResponder];
}

- (IBAction)addPressed:(id)sender{

    
    [self validateWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self addCard:_tf.text];
        }
    }];
    
}

- (void)validateWithBlock:(BooleanResultBlock)block{

    NSString *number = _tf.text;
    int length = number.length;
    NSRange range = [number rangeOfString:@"62"];
//    NSLog(@"range # %@",NSStringFromRange(range));

    NSString *msg = @"请输入以62开头的13到19位银行卡号";
    
    if (range.location!=0 || length<13 ||length>19) {
        
        [UIAlertView showAlert:msg msg:nil cancel:@"OK"];
    
        block(NO,nil);
       
    }
    else{
        block(YES,nil);
    }
}


- (void)addCard:(NSString*)number{

    [[LibraryManager sharedInstance] startProgress:nil];
    
    [[NetworkClient sharedInstance] user:[[UserController sharedInstance] uid] addCard:number block:^(id object, NSError *error) {
    
        [[LibraryManager sharedInstance] dismissProgress:nil];
     
        if (!ISEMPTY(object)) {

            [self.navigationController popViewControllerAnimated:YES];
            
            //!!!: 如果是从活动流程过来
            [_parent didAddCard];
            
        }
        
    }];
}

@end
