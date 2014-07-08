//
//  ConfigCell.h
//  Makers
//
//  Created by AppDevelopper on 14-6-1.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "KQLabel.h"

@protocol ConfigCellDelegate;

@interface ConfigCell : UITableViewCell{
    NSString *_key;
    id _value;
    
    __unsafe_unretained id<ConfigCellDelegate> _delegate;
    
    UILabel *_firstLabel;
    UILabel *_secondLabel;
    UILabel *_thirdLabel;
    UIImageView *_avatarV;
    
    NSBlockOperation *_op;
}

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) id value;

@property (nonatomic, strong) IBOutlet UILabel *firstLabel;
@property (nonatomic, strong) IBOutlet UILabel *secondLabel;
@property (nonatomic, strong) IBOutlet UILabel *thirdLabel;
@property (nonatomic, strong) IBOutlet UIImageView *avatarV;


/**
 *	@brief	cell初始化完后，是否在VC进行初始设置的flag
 */
@property (nonatomic, assign) BOOL isInited;

@property (nonatomic, strong) NSBlockOperation *op;

@property (nonatomic, unsafe_unretained) id <ConfigCellDelegate> delegate;

+ (CGFloat)cellHeightWithValue:(id)value;

- (void)load;
- (void)cancelOperation;

@end


@protocol ConfigCellDelegate <NSObject>

@optional

- (void)didSelectedCell:(ConfigCell*)cell;

@end