//
//  CityViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-5-31.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "CityViewController.h"
#import "UserController.h"

@interface CityCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *label;

@end

@implementation CityCell

- (void)layoutSubviews{
    
    [super layoutSubviews];

}

@end

@interface CityViewController (){

    NSDictionary *_citys;
    NSMutableArray *_cityKeys;
}

@end

@implementation CityViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    L();
    self.title = @"选择城市";
    
    NSString *cityPath = [NSString filePathForResource:@"citydict.plist"];
    _citys = [NSDictionary dictionaryWithContentsOfFile:cityPath];
    _cityKeys = [[_citys allKeys] mutableCopy];
    
    [_cityKeys sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [_cityKeys removeObject:@"热门"];
    [_cityKeys removeObject:@"GPS定位"];
    [_cityKeys insertObject:@"热门" atIndex:0];
//    [_cityKeys insertObject:@"GPS定位" atIndex:0];
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"国内",@"海外"]];
    seg.frame = CGRectMake(0, 0, 160, 30);
    seg.selectedSegmentIndex = 0;
    self.navigationItem.titleView = seg;
    
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:kColorYellow];
    
    UIBarButtonItem *backBB = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backPressed:)];
    self.navigationItem.leftBarButtonItem = backBB;
//    NSLog(@"citys # %@",_citys);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    L();
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    L();
    [super viewDidAppear:animated];
}

#pragma makr - IBAction

- (IBAction)backPressed:(id)sender{
    [self back];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return [_cityKeys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    
    NSString *key = _cityKeys[section];
    NSArray *sectionCitys = _citys[key];
     return [sectionCitys count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CityCell";

    [tableView registerClass:[CityCell class] forCellReuseIdentifier:identifier];

    
//    [tableView registerNib:[UINib nibWithNibName:@"CityCell" bundle:nil] forCellReuseIdentifier:identifier];
    CityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    NSString *key = _cityKeys[indexPath.section];
    NSArray *sectionCitys = _citys[key];
    
    cell.textLabel.text = sectionCitys[indexPath.row];
//    cell.label.text = @"ssss";
    
    return cell;
}

- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _cityKeys;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return _cityKeys[section];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{

    return index;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *key = _cityKeys[indexPath.section];
    NSArray *sectionCitys = _citys[key];
    NSString *city = sectionCitys[indexPath.row];

    [self selectCity:city];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)selectCity:(NSString*)city{

//    [[UserController sharedInstance] setCity:city];
    
    [self back];
    
//    [self.navigationController popViewControllerAnimated:YES];
    
//    [self.view removeFromSuperview];
}

- (void)back{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
