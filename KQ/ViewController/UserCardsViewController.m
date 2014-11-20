//
//  UserCardsViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-10.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "UserCardsViewController.h"
#import "ConfigCell.h"
#import "Card.h"
#import "AddCardViewController.h"
#import "ImageButtonCell.h"
#import "UIImageView+WebCache.h"

@interface CardCell : ConfigCell{

}

@end

@implementation CardCell


- (void)setValue:(Card*)card{
    
    _value = card;
    
//    NSLog(@"card.title # %@",card.title);
    
    
    self.textLabel.text = card.bankTitle;
    self.firstLabel.text = [self cardTitleWithSecurity:card.title];

//    self.detailTextLabel.text = @"bbbb";
    
    NSString *logoUrl = card.logoUrl;
    [self.imageView setImageWithURL:[NSURL URLWithString:logoUrl]];


// NSLog(@"details # %@",self.detailTextLabel);
}


//100

- (void)load{
    
    self.textLabel.textColor = kColorBlack;
    self.textLabel.font = [UIFont fontWithName:kFontBoldName size:16];
    
    
//    self.detailTextLabel.textColor = kColorGray;
//    self.detailTextLabel.font = [UIFont fontWithName:kFontName size:15];

    _firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(89, 24, _w-89, 60)];
    _firstLabel.textColor = kColorGray;
    _firstLabel.font = [UIFont fontWithName:kFontName size:15];
    
    [self addSubview:_firstLabel];
    
    
    self.imageView.frame = CGRectMake(10, 10, 64, 64);
    float x =CGRectGetMaxX(self.imageView.frame)+15;
    self.textLabel.frame = CGRectMake(x, 0 , 250, 60);

}


- (void)layoutSubviews{
    
//    [super layoutSubviews];
    
// 
//    self.imageView.frame = CGRectMake(10, 10, 64, 64);
//    float x =CGRectGetMaxX(self.imageView.frame)+15;
//    self.textLabel.frame = CGRectMake(x, 0 , 250, 60);
//    self.detailTextLabel.frame = CGRectMake(x, 24, 250, 60);
    
}

/// 621111111111 => 6211 xxxx 1111
- (NSString*)cardTitleWithSecurity:(NSString*)title{
    
    NSString *newTitle;
    
    NSString *first = [title substringWithRange:NSRangeFromString(@"(0,4")];
    
    NSRange lastRange = NSMakeRange(title.length-4, 4);
    NSString *last = [title substringWithRange:lastRange];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<title.length-8; i++) {
//        NSLog(@"i # %d, title.length # %d",i,title.length);
        [array addObject:@"*"];
    }
    
    NSString *middle = [array componentsJoinedByString:@""];
    
    newTitle = [NSString stringWithFormat:@"%@ %@ %@",first,middle,last];
    
    
    return newTitle;
}
@end

@interface UserCardsViewController ()

@end


#define headerHeight 46
#define footerHeight 200
@implementation UserCardsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    L();
    self.title = @"我的银行卡";
    
    _config = [[TableConfiguration alloc] initWithResource:@"UserCardsConfig"];

 
    self.isLoadMore = NO;
    self.view.backgroundColor = kColorBG;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
  
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return footerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _w, headerHeight)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, _w, headerHeight)];
        label.text = @"凭以下银行卡可享受快券优惠";
        label.textColor = kColorGray;
        label.font = [UIFont fontWithName:kFontBoldName size:15];
        [v addSubview:label];
        
        return v;
    }
    
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _w, footerHeight)];
  
    UIButton *btn = [UIButton buttonWithFrame:CGRectMake(10, 33, _w-20, 34) title:@"+ 添加银行卡" bgImageName:nil target:self action:@selector(addCard)];
    btn.backgroundColor = kColorGreen;
    btn.layer.cornerRadius = 3;
    btn.titleLabel.font = [UIFont fontWithName:kFontBoldName size:15];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(btn.frame)+10, _w, 30)];
    label.text = @"中国银联将保障您的账户信息安全";
    label.textColor = kColorGray;
    label.font = [UIFont fontWithName:kFontBoldName size:12];
    label.textAlignment = NSTextAlignmentCenter;
    [v addSubview:btn];
    [v addSubview:label];
//    v.backgroundColor = kColorLightYellow;
    return v;

}

- (void)configCell:(ConfigCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
//    NSLog(@"cell # %@",cell);
    if ([cell isKindOfClass:[CardCell class]]) {
        cell.value = _models[indexPath.row];
    }
    else if([cell isKindOfClass:[ImageButtonCell class]]){
    
        UIImageView *bgV = [(ImageButtonCell*)cell bgV];

        bgV.image = [UIImage imageNamed:@"card_add.png"];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)_tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
//        [korb deleteProductAtIndex:indexPath.row];
  
        
        [self deleteCardAtIndexPath:indexPath];
        
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"解绑";
}

#pragma mark - Fcns


- (void)loadModels{

    L();
  
//    [_libraryManager startProgress:nil];

    [self.models removeAllObjects];
    [self willConnect:self.view];

    
     [_networkClient queryCards:_userController.uid block:^(NSDictionary *dict, NSError *error) {
     
         
         [self willDisconnect];
         [self.refreshControl endRefreshing];
         
         if (!_networkFlag) {
             return ;
         }

         if (!error) {
             NSArray *array = dict[@"cards"];
             
                   NSLog(@"cards # %@",array);
             
             if (ISEMPTY(array)) {
                 [_libraryManager startHint:@"还没有绑定银行卡" duration:1];
             }
             
//             NSLog(@"cards # %@",array);
             
             for (NSDictionary *dict in array) {
                 
                 Card *card = [[Card alloc] initWithDict:dict];
                 [self.models addObject:card];
             }
             
             [self.tableView reloadData];
         }
         else {
             [ErrorManager alertError:error];
         }
         
         
    }];
}

//- (void)refreshModels{
//    [_models removeAllObjects];
//    
//    [self loadModels];
//}

- (IBAction)addCard{
    L();
    
    AddCardViewController *vc = [[AddCardViewController alloc] init];
    vc.view.alpha = 1;
    vc.parent = self;
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)deleteCardAtIndexPath:(NSIndexPath*)indexPath{
    
    Card *card = [_models objectAtIndex:indexPath.row];
    
    
    [self willConnect:self.view];
    
    [_networkClient user:_userController.uid sessionToken:_userController.sessionToken deleteCard:card.title block:^(id object, NSError *error) {
        
        [self willDisconnect];
        if (!_networkFlag) {
            return ;
        }
        
        if (!error) {
            
            [_libraryManager startHint:@"银行卡解绑成功!"];
            
            [self.models removeObjectAtIndex:indexPath.row];
            
            // Delete the row from the data source.
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
           
        }
        else{
            [ErrorManager alertError:error];
        }
    }];
    
    
}

//- (void)didAddCard{
//    L();
//    
//    /// 在viewwillappear中会重新load
//    
//    [_models removeAllObjects];
//    
//}



@end
