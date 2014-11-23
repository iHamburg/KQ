//
//  ShopListViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ShopBranchListViewController.h"
#import "ShopListCell.h"
#import "ShopDetailsViewController.h"

@interface ShopBranchListCell : ConfigCell{
   }

@end

@implementation ShopBranchListCell


@end

@interface ShopBranchListViewController ()

@end

@implementation ShopBranchListViewController

- (void)setModels:(NSMutableArray *)models{

    _models = models;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"商户列表";
   
    self.config = [[TableConfiguration alloc] initWithResource:@"ShopListConfig"];

    // 会返回所有门店
    self.isLoadMore = NO;
    
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
    return 1;
}
- (void)configCell:(ShopListCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if ([cell isKindOfClass:[ShopListCell class]]) {
        
        Shop *project = _models[indexPath.row];
        
        [cell setValue:project];
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id obj = self.models[indexPath.row];
    
    [self pushShopDetails:obj];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Fcns

- (void)loadModels{
    
    [self.models removeAllObjects];
    
    [self willConnect:self.view];
   
    [_networkClient queryAllShopBranches:_headerShopId block:^(NSDictionary *dict, NSError *error) {
        
        [self willDisconnect];
        [self.refreshControl endRefreshing];
        
        if (!error) {
            NSArray *array = dict[@"shopbranches"];
            
            NSLog(@"array # %@",array);
            
            
            for (NSDictionary *dict in array) {
                
                Shop *shop = [[Shop alloc] initWithListDict:dict];
                
                [self.models addObject:shop];
            }
            
//            if (self.models.count <kLimit) {
//                self.isLoadMore = NO;
//            }
            
            [self.tableView reloadData];
        }
        else{
            [ErrorManager alertError:error];
        }

    }];
}



- (void)pushShopDetails:(Shop*)shop{
    ShopDetailsViewController *vc = [[ShopDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.view.alpha = 1.0;
    vc.shop = shop;
    
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
