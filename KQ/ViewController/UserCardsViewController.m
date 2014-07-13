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

@interface CardCell : ConfigCell{

}

@end

@implementation CardCell


- (void)setValue:(Card*)card{
    
    _value = card;
    
//    NSLog(@"card.title # %@",card.title);
    
    self.firstLabel.text = [self cardTitleWithSecurity:card.title];

}


//100
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
              
        UIImageView *bgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 300, 90)];
        bgV.image = [UIImage imageNamed:@"card_bg.png"];

        _firstLabel = [[KQLabel alloc] initWithFrame:CGRectMake(60, 56, 240, 30)];
        _firstLabel.textColor = [UIColor whiteColor];
        _firstLabel.font  = [UIFont fontWithName:kFontBoldName size:24];
        _firstLabel.minimumScaleFactor = .6;
        _firstLabel.adjustsFontSizeToFitWidth = YES;
        
        [bgV addSubview:_firstLabel];
        [self addSubview:bgV];
       
    }
    return self;
}


- (void)layoutSubviews{
    
    
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

@implementation UserCardsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    L();
    self.title = @"我的银行卡";
    
    _config = [[TableConfiguration alloc] initWithResource:@"UserCardsConfig"];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 
    self.isLoadMore = NO;
}

- (void)viewWillAppear:(BOOL)animated{

//    L();
    [super viewWillAppear:animated];
  
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//
- (void)loadModels{

    L();
  
    [_libraryManager startProgress:nil];

    //539560f2e4b08cd56b62cb98
     [_networkClient queryCards:_userController.uid block:^(NSArray *array, NSError *error) {
     
         [_libraryManager dismissProgress:nil];

         
        if (ISEMPTY(array)) {
            return ;
        }
        
        for (NSDictionary *dict in array) {
            Card *card = [Card cardWithDict:dict];
            [_models addObject:card];
            
        }
        
         [self.tableView reloadData];
         
    }];
}

- (void)refreshModels{
    [_models removeAllObjects];
    
    [self loadModels];
}

- (IBAction)addCard{
    L();

    [self performSegueWithIdentifier:@"AddCard" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    L();

    [segue.destinationViewController setValue:self forKeyPath:@"parent"];
    
}

- (void)didAddCard{
    L();
    
    /// 在viewwillappear中会重新load
    
    [_models removeAllObjects];
    
}



@end
