//
//  SettingController.m
//  GSMA
//
//  Created by AppDevelopper on 14-4-29.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "SettingController.h"
#import "TableConfiguration.h"
#import "SettingCell.h"



@interface SettingController ()

@end

@implementation SettingController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _config.numberOfSections;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    return [self.config headerInSection:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    NSInteger rowCount = [self.config numberOfRowsInSection:section];
    
    
    return rowCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
	static NSString *CellIdentifier1 = @"Cell1";
    
    NSString *cellClassName = [self.config cellClassnameForIndexPath:indexPath];
    
	SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (!cell) {
        cell = [[NSClassFromString(cellClassName) alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
        cell.textLabel.font = [UIFont fontWithName:FONTNAME size:16];
        cell.detailTextLabel.font = [UIFont fontWithName:FONTNAME size:16];
        
    }
    
    
    cell.textLabel.text = LString([self.config labelForIndexPath:indexPath]);
  
    
    /// 如果不是dynamic的relationship， 判断是否是fetch property
    NSString *value = [[self.config rowForIndexPath:indexPath] objectForKey:@"value"];
    
    if (value != nil) {
        ///有value，说明是fetch property

        cell.detailTextLabel.text = value;

    }
    else{
        /// 没有value， 说明是普通的property
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }


    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    SEL selector = [self.config selectorForIndexPath:indexPath];
    
    [self performSelector:selector withObject:nil];
    
}

#pragma mark - Mail

- (void)mailComposeController:(MFMailComposeViewController *)controller

		  didFinishWithResult:(MFMailComposeResult)result

						error:(NSError *)error

{
	
	L();
	
    [controller dismissViewControllerAnimated:YES completion:nil];
  
}

#pragma mark - Fcns

- (void)aboutUs{

}

- (void)feedback{
    L();
    
}
//
- (void)version{

}

- (void)ratingUs{

}

- (void)recommend{

}

- (void)update{


}

@end
