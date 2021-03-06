//
//  ConfigCell.h
//  Makers
//
//  Created by AppDevelopper on 14-6-1.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "KQLabel.h"

@interface ConfigCell : UITableViewCell{
    
    NSString *_key;
   
    id _value;
    
    
    UILabel *_firstLabel;
    UILabel *_secondLabel;
    UILabel *_thirdLabel;
    UILabel *_fourthLabel;
    UIImageView *_avatarV;
    

}

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) id value;

@property (nonatomic, strong) IBOutlet UILabel *firstLabel;
@property (nonatomic, strong) IBOutlet UILabel *secondLabel;
@property (nonatomic, strong) IBOutlet UILabel *thirdLabel;
@property (nonatomic, strong) IBOutlet UILabel *fourthLabel;
@property (nonatomic, strong) IBOutlet UIImageView *avatarV;

@property (nonatomic, strong) UIView *subView;

/**
 *	@brief 判断cell是否初始化完成，
 */
@property (nonatomic, assign) BOOL isInited;



+ (CGFloat)cellHeightWithValue:(id)value;

- (void)load;  //Cell的初始化


@end

