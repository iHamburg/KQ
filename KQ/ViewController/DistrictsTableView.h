//
//  DistrictsTableView.h
//  KQ
//
//  Created by AppDevelopper on 14-6-28.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistrictsTableView : UIView<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_leftTv, *_rightTv;
    
}

@property (nonatomic, strong) NSDictionary *dataSource; // district -> titles
@property (nonatomic, assign) int leftIndex;
@property (nonatomic, copy) void (^selectedBlock)(int);

@end
