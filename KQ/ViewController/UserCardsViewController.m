//
//  UserCardsViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-10.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "UserCardsViewController.h"


#import "AddCardViewController.h"

#import "UIImageView+WebCache.h"
#import "CardCell.h"

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
//    self.view.backgroundColor = kColorBG;
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return footerHeight;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _w, footerHeight)];
    
    UIButton *btn = [UIButton buttonWithFrame:CGRectMake(10, 43, _w-20, 34) title:@"+ 添加银行卡" bgImageName:nil target:self action:@selector(addCard)];
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
    
    return v;
    
}




- (void)configCell:(ConfigCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
//    NSLog(@"cell # %@",cell);
    if ([cell isKindOfClass:[CardCell class]]) {
        cell.value = _models[indexPath.row];
    }

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)_tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self deleteCardAtIndexPath:indexPath];
        
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"解绑";
}

#pragma mark - Fcns


- (void)loadModels{

    L();
  

    [self.models removeAllObjects];
    [self willConnect:self.view];

    
     [_networkClient queryCards:_userController.uid block:^(NSDictionary *dict, NSError *error) {
     
         
         [self willDisconnect];
         [self.refreshControl endRefreshing];
  
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



@end
