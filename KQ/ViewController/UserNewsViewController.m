//
//  UserNewsViewController.m
//  KQ
//
//  Created by Forest on 14-11-16.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "UserNewsViewController.h"
#import "News.h"
#import "AutoHeightCell.h"

@interface NewsCell : ConfigCell

@property (nonatomic, strong) UIView *seperatorV;

@end

@implementation NewsCell

- (void)setValue:(News*)value{
    
    _value = value;
    
    self.textLabel.text = value.title;
    _secondLabel.text = value.text;
    _thirdLabel.text = value.createdAt;

    CGSize constraint = CGSizeMake(300, 10000);

    CGRect textRect = [value.text boundingRectWithSize:constraint options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:nFont(14)} context:nil];
    float height = textRect.size.height;
   
    _secondLabel.frame = CGRectMake(10, 25, 300, height);
    
    _thirdLabel.frame = CGRectMake(10, CGRectGetMaxY(_secondLabel.frame)+5, 300, 25);
    
    _seperatorV.frame = CGRectMake(0, height + 54, _w, 1);
    
}


- (void)load{
    
    
    
    // title
    self.textLabel.frame = CGRectMake(10, 0, 300, 25);
    self.textLabel.font = bFont(16);
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    
   
    
    _secondLabel = [[KQLabel alloc] initWithFrame:CGRectMake(130, CGRectGetMaxY(self.textLabel.frame)+10, 150, 20)];
    _secondLabel.font = nFont(14);
    _secondLabel.numberOfLines = 0;
//    _secondLabel.textAlignment = NSTextAlignmentLeft;
    _secondLabel.textColor = kColorGray;
    
    
    //distance
    _thirdLabel = [[KQLabel alloc] initWithFrame:CGRectMake(250, 20, 60, 30)];
    _thirdLabel.font = nFont(14);
    
    _seperatorV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _w, 1)];
    _seperatorV.backgroundColor = kColorLightGray;
    
    [self addSubview:_secondLabel];
    [self addSubview:_thirdLabel];
    [self addSubview:_seperatorV];
    
    self.backgroundColor = [UIColor whiteColor];
    
}

+ (CGFloat)cellHeightWithValue:(News*)news{
    
    //    NSLog(@"shop # %@",self.va)
    
    
    CGSize constraint = CGSizeMake(300, 10000);
    
    
    CGRect textRect = [news.text boundingRectWithSize:constraint options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:nFont(14)} context:nil];
    
    
    return textRect.size.height + 60;
}

- (void)layoutSubviews{}

@end

#pragma mark -
#pragma mark - UserNewsVC

@interface UserNewsViewController ()

@end

@implementation UserNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"站内信";
    self.config =  [[TableConfiguration alloc] initWithResource:@"UserNewsConfig"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    News *news = _models[indexPath.row];
    
    CGFloat height = [NewsCell cellHeightWithValue:news];
    
    return height;
}

- (void)initConfigCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)configCell:(ConfigCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell isKindOfClass:[NewsCell class]]) {
        
        [cell setValue:_models[indexPath.row]];
        
    }
    
    
}


#pragma mark - Fcns

///还是要调用的，因为people不会include favoritedCoupon的信息
- (void)loadModels{
    L();
    
    
    [self.models removeAllObjects];
    
//    NSLog(@"uid # %@",_userController.uid);
    
    [self willConnect:self.view];
    
    [_networkClient queryUserNews:_userController.uid skip:0 limit:0 lastNewsId:_userController.people.lastNewsId  block:^(NSDictionary *dict, NSError *error) {
        
        [self willDisconnect];
         [self.refreshControl endRefreshing];
        
        if (!error) {
            if (ISEMPTY(dict)) {
                [_libraryManager startHint:@"还没有收藏商户" duration:1];
            }
            else{
                NSLog(@"couponDicts # %@",dict);
                
                NSArray *newsArray = dict[@"news"];
                
               NSDictionary *lastNewsDict = [newsArray firstObject];
                _userController.people.lastNewsId = [lastNewsDict[@"id"] intValue];
                [_userController savePeople:_userController.people];
                
                for (NSDictionary *newsDict in newsArray) {
//                    NSLog(@"dict # %@",newsDict);
                    News *news = [[News alloc] initWithDict:newsDict];
                    
                    [self.models addObject:news];
                }
                
//                if (self.models.count< kLimit) {
//                    self.isLoadMore = NO;
//                }
                
                [self.tableView reloadData];
            }

        }
        else{
            [ErrorManager alertError:error];
        }
    }];
    
}


- (void)loadMore:(VoidBlock)finishedBlock{
    int count = [_models count];
    
    
    //从现有的之后进行载入
    [_networkClient queryUserNews:_userController.uid skip:count limit:0 lastNewsId:_userController.people.lastNewsId block:^(NSDictionary *couponDicts, NSError *error) {
        
        finishedBlock();
        
        
        if (!error) {
            NSArray *array = couponDicts[@"news"];
            
            //            NSLog(@"array # %@",array);
            
                for (NSDictionary *newsDict in array) {
                //                    NSLog(@"dict # %@",newsDict);
                News *news = [[News alloc] initWithDict:newsDict];
                
                [self.models addObject:news];
            }
            
          
            
            [self.tableView reloadData];
            
            
        }
        else{
            [ErrorManager alertError:error];
        }
        
        
    }];
    
}

@end
