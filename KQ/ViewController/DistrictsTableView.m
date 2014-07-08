//
//  DistrictsTableView.m
//  KQ
//
//  Created by AppDevelopper on 14-6-28.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "DistrictsTableView.h"
#import "District.h"
#import "CouponType.h"

@interface DistrictsTableView ()

@property (nonatomic, strong) NSArray *leftKeys; //district，couponType
@property (nonatomic, strong) NSArray *rightKeys; //string
@property (nonatomic, strong) UITableView *leftTv;
@property (nonatomic, strong) UITableView *rightTv;

@end

@implementation DistrictsTableView


- (void)setDataSource:(NSDictionary *)dataSource{

    _dataSource = dataSource;
 
//    self.leftKeys = _dataSource.allKeys;

//       NSLog(@"datasource # %@, leftkeys # %@",dataSource,self.leftKeys);
    NSMutableArray *arr = [_dataSource.allKeys mutableCopy];
    [arr insertObject:[[[arr firstObject] class] allInstance] atIndex:0];
    
    self.leftKeys = [arr copy];
    
    self.leftIndex = 0; // to reload rightTv
    
    [self.leftTv reloadData];
}

- (void)setLeftIndex:(int)leftIndex{
    _leftIndex = leftIndex;
    

    id leftKey = self.leftKeys[leftIndex];
    
    
    if (leftIndex == 0) {
        NSMutableArray *allTitles = [NSMutableArray array];
        for (id obj in self.leftKeys) {
            [allTitles addObject:[obj title]];
        }
        self.rightKeys = [allTitles copy];
    }
    else
        self.rightKeys = [self.dataSource objectForKey:leftKey];
    
    
    
    [self.rightTv reloadData];
}

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        [self load];
        
    }
    return self;
}

- (void)awakeFromNib{
    [self load];
}

- (void)load{
    _leftTv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 160, self.height) style:UITableViewStylePlain];
    _leftTv.delegate = self;
    _leftTv.dataSource = self;
    _leftTv.autoresizingMask = kAutoResize;
    
    _rightTv = [[UITableView alloc] initWithFrame:CGRectMake(160, 0, 160, self.height) style:UITableViewStylePlain];
    _rightTv.dataSource = self;
    _rightTv.delegate = self;
    _rightTv.autoresizingMask = kAutoResize;
    
    [self addSubview:_leftTv];
    [self addSubview:_rightTv];

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    int rowCount;
    if (tableView == _leftTv) {
        rowCount = [self.leftKeys count];
    }
    else{
        rowCount = self.rightKeys.count;
    }

    
    
    return rowCount;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier;
    if (tableView == _leftTv) {
        identifier = @"leftCell";
    }
    else
        identifier = @"rightCell";

    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    int row = indexPath.row;
    
    if (tableView == _leftTv) {
        
        cell.textLabel.text = [self.leftKeys[row] title];
    }
    else{
        
        
        
        cell.textLabel.text = self.rightKeys[row];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
    if (tableView == _leftTv) {
        self.leftIndex = indexPath.row;
    }
    else{
        self.selectedBlock(indexPath.row);
    }
    
}

- (void)configCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath{
    
}


@end
