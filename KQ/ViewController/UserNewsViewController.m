//
//  UserNewsViewController.m
//  KQ
//
//  Created by Forest on 14-11-16.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "UserNewsViewController.h"
#import "News.h"

@interface NewsCell : ConfigCell

@end

@implementation NewsCell

- (void)setValue:(News*)value{
    
    _value = value;
    
    _secondLabel.text = value.title;
    _thirdLabel.text = value.text;
}


- (void)load{
    
    //    L();
    
    
//    self.separatorInset = UIEdgeInsetsMake(0, 0, 0,0); // 分割线是全屏的
    
    self.imageView.frame = CGRectMake(10, 10, 108, 65);
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 3;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    // title
    self.textLabel.frame = CGRectMake(130, 10, 150, 20);
    self.textLabel.font = [UIFont fontWithName:kFontBoldName size:14];
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    
    _secondLabel = [[KQLabel alloc] initWithFrame:CGRectMake(130, CGRectGetMaxY(self.textLabel.frame)+10, 150, 20)];
    _secondLabel.font = [UIFont fontWithName:kFontBoldName size:14];
    _secondLabel.textAlignment = NSTextAlignmentLeft;
    _secondLabel.textColor = kColorDarkYellow;
    
    
    //distance
    _thirdLabel = [[KQLabel alloc] initWithFrame:CGRectMake(250, 20, 60, 30)];
    _thirdLabel.font = [UIFont fontWithName:kFontName size:12];
    
    [self addSubview:_secondLabel];
    [self addSubview:_thirdLabel];
    
    
    self.backgroundColor = [UIColor whiteColor];
    
}

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
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView
- (void)configCell:(ConfigCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell isKindOfClass:[NewsCell class]]) {
        
        [cell setValue:_models[indexPath.row]];
        
    }
    
    
}


#pragma mark - Fcns

///还是要调用的，因为people不会include favoritedCoupon的信息
- (void)loadModels{
    L();
    
    [_libraryManager startProgress:nil];
    
    [self.models removeAllObjects];
    
    NSLog(@"uid # %@",_userController.uid);
    
    [_networkClient queryUserNews:_userController.uid skip:0 block:^(NSDictionary *dict, NSError *error) {
        
        [_libraryManager dismissProgress:nil];
      
        if (!error) {
            if (ISEMPTY(dict)) {
                [_libraryManager startHint:@"还没有收藏商户" duration:1];
            }
            else{
                //            NSLog(@"couponDicts # %@",couponDicts);
                NSArray *newsArray = dict[@"news"];
                for (NSDictionary *newsDict in newsArray) {
                    NSLog(@"dict # %@",newsDict);
                    News *news = [[News alloc] initWithDict:newsDict];
                    
                    [self.models addObject:news];
                }
                
                [self.tableView reloadData];
            }

        }
        else{
            [ErrorManager alertError:error];
        }
    }];
    
}


@end
