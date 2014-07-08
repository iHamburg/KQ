//
//  TableConfiguration.m
//
//
//  Created by AppDevelopper on 14-4-17.
//
//

#import "TableConfiguration.h"

@implementation TableConfiguration

- (id)initWithResource:(NSString *)resource{
    if (self = [super init]) {
        
        NSURL *plistURL = [[NSBundle mainBundle] URLForResource:resource
                                                  withExtension:@"plist"];
        NSDictionary *plist = [NSDictionary dictionaryWithContentsOfURL:plistURL];
        
//        NSLog(@"resouces # %@,url # %@,plist # %@",resource,[plistURL description],plist);
        
        self.sections = [plist valueForKey:@"sections"];
        
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self.sections count]];
        for (int i = 0; i<[self.sections count]; i++) {
            NSString *nibName = self.sections[i][@"nib"];
            if (ISEMPTY(nibName)) {
                [array addObject:[NSNull null]];
            }
            else{
                [array addObject:[UINib nibWithNibName:nibName bundle:nil]];
            }
        }
        self.nibs = [array copy];
    }
    
    return self;
    
}


- (NSInteger)numberOfSections
{
    return self.sections.count;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return [_sections[section][@"rows"] count];
}

- (NSString *)headerInSection:(NSInteger)section{
    
    return _sections[section][@"header"];;
}


- (NSDictionary *)rowForIndexPath:(NSIndexPath *)indexPath{
    
    
    NSUInteger rowIndex = [self isDynamicSection:indexPath.section]?0:indexPath.row;
    
    return _sections[indexPath.section][@"rows"][rowIndex];
    
}


- (NSString *)cellClassnameForIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *row = [self rowForIndexPath:indexPath];
    return [row objectForKey:@"class"];
}
- (NSArray *)valuesForIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *row = [self rowForIndexPath:indexPath];
    return [row objectForKey:@"values"];
}
- (NSString *)attributeKeyForIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *row = [self rowForIndexPath:indexPath];
    return [row objectForKey:@"key"];
}
- (NSString *)labelForIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *row = [self rowForIndexPath:indexPath];
    return [row objectForKey:@"label"];
}

- (NSString*)imageNameForIndexPath:(NSIndexPath*)indexPath{
    NSDictionary *row = [self rowForIndexPath:indexPath];
    
//    NSLog(@"indexpath # %@, row # %@",indexPath,row);
    
    return [row objectForKey:@"image"];
}



- (SEL)selectorForIndexPath:(NSIndexPath*)indexPath{
    NSDictionary *row = [self rowForIndexPath:indexPath];
    return  NSSelectorFromString(row[@"selector"]);
}



- (CGFloat)heightForRowInSection:(NSInteger)section{
    
    CGFloat height = [_sections[section][@"height"] floatValue];
    
    
    
    return height;
}

- (NSString *)keyForIndexPath:(NSIndexPath*)indexPath{
    NSDictionary *row = [self rowForIndexPath:indexPath];
    return row[@"key"];
}

- (NSString *)cellIdentifierInSection:(NSInteger)section{
//    if ([self isDynamicSection:section]) {
//        return nil;
//    }
//    else{
//        return [NSString stringWithInt:section];
//    }

    return [NSString stringWithInt:section];

}

#pragma mark - Dynamic

- (BOOL)isDynamicSection:(NSInteger)section{
    BOOL dynamic = NO;
    
    NSDictionary *sectionDict = [self.sections objectAtIndex:section];
    NSNumber *dynamicNumber = [sectionDict objectForKey:@"dynamic"];
    if (dynamicNumber != nil)
        dynamic = [dynamicNumber boolValue];
    return dynamic;
}

- (NSString *)dynamicAttributeKeyForSection:(NSInteger)section
{
    if (![self isDynamicSection:section])
        return nil;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    return [self attributeKeyForIndexPath:indexPath];
}
@end
