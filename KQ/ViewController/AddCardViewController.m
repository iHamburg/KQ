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
#import "WebViewController.h"

@interface AddCardViewController (){
    
    
    UITextField *_tf;
    UIButton *_button;
    
    UIButton *_selectBtn,*_agreementB;
    UILabel *_readL;
    BOOL _selected;

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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithImageName:@"icon_white_back.png" target:self action:@selector(backPressed:)]];
    
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
    
    _selectBtn = [UIButton buttonWithFrame:CGRectMake(10, y, 30, 30) title:nil imageName:@"icon-agreement03.png" target:self action:@selector(selectAgreementClicked:)];
    
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
    
    UIImageView *unionImgV = [[UIImageView alloc] initWithFrame:CGRectMake(_w/2-32, CGRectGetMaxY(_button.frame)+10, 64, 64)];
    unionImgV.image = [UIImage imageNamed:@"bank_icon.png"];
    
    UILabel *unionL = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(unionImgV.frame)+10, _w, 30)];
    unionL.font = [UIFont fontWithName:kFontName size:10];
    unionL.textAlignment = NSTextAlignmentCenter;
    unionL.text = @"中国银联将保障您的账户信息安全";
    
    [self.view addSubview:label];
    [self.view addSubview:tfBgV];
    [self.view addSubview:_tf];
    [self.view addSubview:_selectBtn];
    [self.view addSubview:_readL];
    [self.view addSubview:_agreementB];
    [self.view addSubview:_button];
    [self.view addSubview:unionImgV];
    [self.view addSubview:unionL];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
//    [_libraryManager startHint:@"还需一步，即可下载成功！"];

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

    [self toAgreement];

}



- (IBAction)addPressed:(id)sender{

    
    [self validateWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self addCard:_tf.text];
        }
        else{
            [ErrorManager alertError:error];
        }
    }];
    
}



- (void)validateWithBlock:(BooleanResultBlock)block{

    int code = 0;
    
    NSString *number = _tf.text;
    int length = number.length;
    NSRange range = [number rangeOfString:@"62"];
//    NSLog(@"range # %@",NSStringFromRange(range));

    
    if (range.location!=0 || length<13 ||length>19) {
        
        code = ErrorAppInvalideCard;
       
    }
    else if(!_selected){
        
        code = ErrorAppUnselected;
    }
    
    if (code == 0) {
        block(YES,nil);
    }
    else{
        
        NSError *error = [NSError errorWithDomain:kKQErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey:[ErrorManager localizedDescriptionForCode: code]}];
        
        block(NO,error);
    }
    

}


- (void)addCard:(NSString*)number{

    
    [self willConnect:_button];
    
    NSString *uid = [[UserController sharedInstance] uid];
    NSString *sessionToken = [[UserController sharedInstance] sessionToken];
    
    [[NetworkClient sharedInstance] user:uid sessionToken:sessionToken addCard:number block:^(id object, NSError *error) {
       [self willDisconnect];
     
        if (!_networkFlag) {
            return ;
        }
        
        if (!error) {
            [_libraryManager startHint:@"银行卡绑定成功"];
            
            // 从present过来的有presentBlock
            if (self.presentBlock) {
                self.presentBlock(YES,nil);
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }
            else{
                 [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else{
            [ErrorManager alertError:error];
        }

    }];
}

- (void)toAgreement{
    
//    L();
    WebViewController *vc = [[WebViewController alloc] init];
    vc.fileName = @"bankcard_agreement.html";
    vc.title = @"银联钱包技术使用协议";
    [self.navigationController pushViewController:vc animated:YES];

}

@end
