//
//  ShopListViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ShopBranchListViewController.h"
#import "ShopBranchesCell.h"

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
    
    self.title = @"门店列表";
   
    self.config = [[TableConfiguration alloc] initWithResource:@"ShopBranchListConfig"];
    self.isLoadMore = NO;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
//    NSLog(@"_models # %@",self.models);
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
- (void)configCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
//    L();
    if ([cell isKindOfClass:[ShopBranchesCell class]]) {
        ShopBranchesCell *aCell = (ShopBranchesCell*)cell;
        Shop *shop = _models[indexPath.row];
        [cell setValue:shop forKeyPath:@"value"];
        aCell.shopListB.hidden = YES;
        aCell.indicatorV.hidden = YES;
        aCell.nearestIndicatorV.hidden= YES;
        
        [aCell setToMapBlock:^(Shop *Shop) {
            [self toMap:shop];
        }];
    }
}


#pragma mark - Fcns
- (void)toMap:(id)shop{
    
    [self performSegueWithIdentifier:@"toMap" sender:shop];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSString *identifier = segue.identifier;
    
  if([identifier isEqualToString:@"toMap"]){
        
        [segue.destinationViewController setValue:sender forKeyPath:@"shop"];
        
}
   
}

@end
