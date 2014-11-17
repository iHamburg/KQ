//
//  UserShopsViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-10.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "UserShopsViewController.h"
#import "ShopListCell.h"
#import "ShopDetailsViewController.h"


@interface UserShopsViewController ()

@end

@implementation UserShopsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我收藏的商户";
    
     self.config = [[TableConfiguration alloc] initWithResource:@"UserShopsConfig"];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshModels) name:@"refreshFavoritedShops" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Tableview
- (void)configCell:(ShopListCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if ([cell isKindOfClass:[ShopListCell class]]) {
        
        Shop *project = _models[indexPath.row];
        
        [cell setValue:project];
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id obj = self.models[indexPath.row];
    
    [self toShopDetails:obj];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Fcns

- (void)loadModels{
    
    [_libraryManager startProgress:nil];
    
    [self.models removeAllObjects];
    
    [_networkClient queryFavoritedShop:_userController.uid skip:0 block:^(NSArray *couponDicts, NSError *error) {

        [_libraryManager dismissProgress:nil];
        if (ISEMPTY(couponDicts)) {
             [_libraryManager startHint:@"还没有收藏商户" duration:1];
        }
        else{
            for (NSDictionary *dict in couponDicts) {
                
//                NSLog(@"dict # %@",dict);
                
                Shop *obj = [Shop shopWithDictionary:dict];
                [self.models addObject:obj];
                
            }
            
        }
        
        [self.tableView reloadData];
     
    }];
    
    
}

- (void)refreshModels{
    [self.models removeAllObjects];
    
    [_networkClient queryFavoritedShop:_userController.uid skip:0 block:^(NSArray *couponDicts, NSError *error) {
        //
      
        NSLog(@"shops # %@",couponDicts);
        if (ISEMPTY(couponDicts)) {

        }
        else{
            for (NSDictionary *dict in couponDicts) {
                
                Shop *obj = [Shop shopWithDictionary:dict];
                [self.models addObject:obj];
                
            }
            
        }
        
        [self.tableView reloadData];
        
    }];

}

- (void)toShopDetails:(Shop*)shop{
//    [self performSegueWithIdentifier:@"toShopDetails" sender:shop];
    
    ShopDetailsViewController *vc = [[ShopDetailsViewController alloc] init];
    vc.view.alpha = 1;
    vc.shop = shop;
    [_networkClient queryShopBranches:shop.id block:^(NSArray *shopbranches, NSError *error) {
        
        if (!ISEMPTY(shopbranches)) {
            NSMutableArray *shops = [NSMutableArray arrayWithCapacity:shopbranches.count];
            for (NSDictionary *dict in shopbranches) {
                
                Shop *shop = [Shop shopWithDictionary:dict];
                [shops addObject:shop];
            }
            
            shops = [[shops sortedArrayUsingFunction:nearestShopSort context:nil] mutableCopy];
//            [segue.destinationViewController setValue:shops forKeyPath:@"shopBranches"];
            vc.shopBranches = shops;
        }
    }];


    [self.navigationController pushViewController:vc animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(Shop*)sender
{
    if ([segue.identifier isEqualToString:@"toShopDetails"])
    {
        
        [_networkClient queryShopBranches:sender.id block:^(NSArray *shopbranches, NSError *error) {
            
            if (!ISEMPTY(shopbranches)) {
                NSMutableArray *shops = [NSMutableArray arrayWithCapacity:shopbranches.count];
                for (NSDictionary *dict in shopbranches) {

                    Shop *shop = [Shop shopWithDictionary:dict];
                    [shops addObject:shop];
                }
                
                shops = [[shops sortedArrayUsingFunction:nearestShopSort context:nil] mutableCopy];
                 [segue.destinationViewController setValue:shops forKeyPath:@"shopBranches"];
            }
        }];
        
        [segue.destinationViewController setValue:sender forKeyPath:@"shop"];
       
    }
}

NSInteger nearestShopSort(Shop* obj1, Shop* obj2, void *context ) {
    // returns random number -1 0 1
    return obj1.distance - obj2.distance;
}


@end
