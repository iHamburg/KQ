//
//  TableConfiguration.h
//  
//
//  Created by AppDevelopper on 14-4-17.
//
//


@interface TableConfiguration : NSObject{
    
    NSString *_configName;
    NSArray *_sections;
}

@property (strong, nonatomic) NSString *configName;
@property (strong, nonatomic) NSArray *sections;
@property (nonatomic, strong) NSArray *nibs;

- (id)initWithResource:(NSString *)resource;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString *)headerInSection:(NSInteger)section;


- (NSDictionary *)rowForIndexPath:(NSIndexPath *)indexPath;
- (NSString *)cellClassnameForIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)valuesForIndexPath:(NSIndexPath *)indexPath;
- (NSString *)attributeKeyForIndexPath:(NSIndexPath *)indexPath;
- (NSString *)labelForIndexPath:(NSIndexPath *)indexPath;
- (NSString*)imageNameForIndexPath:(NSIndexPath*)indexPath;


- (SEL)selectorForIndexPath:(NSIndexPath*)indexPath;


- (BOOL)isDynamicSection:(NSInteger)section;
- (NSString *)dynamicAttributeKeyForSection:(NSInteger)section;
- (NSString *)keyForIndexPath:(NSIndexPath*)indexPath;
- (CGFloat)heightForRowInSection:(NSInteger)section;
- (NSString *)cellIdentifierInSection:(NSInteger)section;
@end
