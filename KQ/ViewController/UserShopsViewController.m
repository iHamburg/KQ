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

    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshModels) name:@"refreshFavoritedShops" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Tableview
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
    
    [self toShopDetails:obj];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Fcns

- (void)loadModels{
    

    
    [self.models removeAllObjects];
    
    [self willConnect:self.view];
    
    [_networkClient queryFavoritedShop:_userController.uid skip:0 block:^(NSDictionary *dict, NSError *error) {

        [self willDisconnect];
        [self.refreshControl endRefreshing];
        
//        if (!_networkFlag) {
//            return ;
//        }
        
        if (!error) {
            NSArray *array = dict[@"shopbranches"];
            
//            NSLog(@"array # %@",array);
         
            if (ISEMPTY(array)) {
                [_libraryManager startHint:@"还没有收藏商户" duration:1];
            }

            
            for (NSDictionary *dict in array) {
               
                Shop *shop = [[Shop alloc] initWithFavoriteDict:dict];
                
                [self.models addObject:shop];
            }
            
            if (self.models.count <kLimit) {
                self.isLoadMore = NO;
            }
            
            [self.tableView reloadData];
        }
        else{
            [ErrorManager alertError:error];
        }

     
    }];
    
    
}


- (void)loadMore:(VoidBlock)finishedBlock{
    int count = [_models count];
    
    //    NSLog(@"networkflag # %d",_networkFlag);
    
//    _networkFlag = YES;
    
    //从现有的之后进行载入
    [_networkClient queryFavoritedCoupon:_userController.uid skip:count block:^(NSDictionary *couponDicts, NSError *error) {
        
        finishedBlock();
        
        //        if (!_networkFlag) {
        //            return ;
        //        }
        
        if (!error) {
            NSArray *array = couponDicts[@"shopbranches"];
            
//            NSLog(@"array # %@",array);
            
            for (NSDictionary *dict in array) {
                
                Shop *shop = [[Shop alloc] initWithFavoriteDict:dict];
                
                [self.models addObject:shop];
            }
            
            
            [self.tableView reloadData];
            
            
        }
        else{
            [ErrorManager alertError:error];
        }
        
        
    }];
    
}

- (void)toShopDetails:(Shop*)shop{

    
    ShopDetailsViewController *vc = [[ShopDetailsViewController alloc] init];
    vc.view.alpha = 1;
    vc.shop = shop;


    [self.navigationController pushViewController:vc animated:YES];
}


NSInteger nearestShopSort(Shop* obj1, Shop* obj2, void *context ) {
    // returns random number -1 0 1
    return obj1.locationDistance - obj2.locationDistance;
}


@end
