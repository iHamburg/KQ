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
#import "InsetsTextField.h"
#import "AfterDownloadBankViewController.h"

@interface AddCardViewController (){
    
    
    UITextField *_tf;
    UIButton *_button;
    
    UIButton *_selectBtn,*_agreementB;
    UILabel *_readL;
    BOOL _selected;

}

@end


/**
 
 
 */
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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithImageName:@"icon_back.png" target:self action:@selector(backPressed:)]];
    
    self.view.backgroundColor  = kColorBG;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 50)];
    label.text = @"只需输入卡号，即可成功至商户享受快券优惠服务";
    label.textColor = kColorGray;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:kFontBoldName size:12];
    
    UIImageView *tfBgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 320, 48)];
    tfBgV.image = [UIImage imageNamed:@"addCardTfBg.jpg"];
    
    UITextField *tf;
    UIButton *btn;
    tf = [[UITextField alloc] initWithFrame:CGRectMake(45, 60, 240, 48)];

    tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.backgroundColor = [UIColor clearColor];
    tf.placeholder = @"银行卡卡号";
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;

    _tf = tf;
    
    
    CGFloat y = CGRectGetMaxY(_tf.frame);
    //TODO: 可以用TogoleBtn refactor
    
    _selected = YES;
    
    _selectBtn = [UIButton buttonWithFrame:CGRectMake(10, y, 30, 30) title:nil bgImageName:@"icon-agreement03.png" target:self action:@selector(selectAgreementClicked:)];
    
    _readL = [[UILabel alloc] initWithFrame:CGRectMake(45, y, 100, 30)];
    _readL.text = @"我已阅读并同意";
    _readL.textColor = kColorDardGray;
    _readL.font = [UIFont fontWithName:kFontName size:14];
    _readL.userInteractionEnabled = YES;
    [_readL addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(selectAgreementClicked:)]];
    
    _agreementB = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(_readL.frame), y, 200, 30) title:@"《银联钱包注册协议》" bgImageName:nil target:self action:@selector(agreementClicked:)];
    [_agreementB setTitleColor:kColorBlue forState:UIControlStateNormal];
    _agreementB.titleLabel.font = [UIFont fontWithName:kFontName size:14];
    _agreementB.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    

    
    btn = [UIButton buttonWithFrame:CGRectMake(10, CGRectGetMaxY(_agreementB.frame)+10 , 300, 40) title:@"提交" bgImageName:nil target:self action:@selector(addPressed:)];
    btn.backgroundColor = kColorGreen;
    btn.titleLabel.font = [UIFont fontWithName:kFontBoldName size:20];
    _button = btn;
    
    [self.view addSubview:label];
    [self.view addSubview:tfBgV];
    [self.view addSubview:_tf];
    [self.view addSubview:_selectBtn];
    [self.view addSubview:_readL];
    [self.view addSubview:_agreementB];
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
    
//    [_tf becomeFirstResponder];
}

#pragma mark - IBAction

- (IBAction)backPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - IBAction
- (IBAction)selectAgreementClicked:(id)sender{
    L();
    
    if (_selected) {
        [_selectBtn setImage:[UIImage imageNamed:@"icon-agreement01.png"] forState:UIControlStateNormal];
    }
    else{
        [_selectBtn setImage:[UIImage imageNamed:@"icon-agreement03.png"] forState:UIControlStateNormal];
    }
    
    _selected = !_selected;
}

- (IBAction)agreementClicked:(id)sender{
    //    L();
    [self toAgreement];
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

            ///
            if (_parent) {
               ///如果是从usercardVC过来的
                
                [self.navigationController popViewControllerAnimated:YES];
                
                //!!!: 如果是从活动流程过来
                [_parent didAddCard];
            }
            else{
                
                //TODO: 更新userController.cardSet?
                
//                [[UserController sharedInstance] loadUser];
                
                
                [self toAfterDownloadBank];
            }
            
        }
        
    }];
}

- (void)toAgreement{
    
    L();
    
}

- (void)toAfterDownloadBank{
    
    AfterDownloadBankViewController *vc = [[AfterDownloadBankViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
@end
