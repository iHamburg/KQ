//
//  NetworkTests.m
//  KQ
//
//  Created by AppDevelopper on 14-7-14.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NetworkClient.h"

#define EXP_SHORTHAND
#import "Expecta.h"

@interface NetworkTests : XCTestCase

@end

@implementation NetworkTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    [Expecta setAsynchronousTestTimeout:2];

}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

- (void)testA{

    XCTAssertTrue(1);
}



- (void)testAsync{
    
    __block id resObj = nil;
    __block id resError = nil;
    
    NSString *url = @"http://localhost/kq/index.php/kqapi3/coupon/id/539d8cd9e4b0a98c8733f8dc";
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperationManager manager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"get url # %@,response : %@ ", url,responseObject);
        
        //        NSDictionary *dict = responseObject;
        resObj = responseObject;
        return;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"get url %@,response # %@, error # %@",url, operation.responseString,[error localizedDescription]);
        //        [UIAlertView showAlertWithError:error];
        //        block(nil,error);
        resError = error;
        return;
    }];
    
    [operation waitUntilFinished];
    
    //    expect(operation.isFinished).will.beTruthy();
    expect([[resObj objectForKey:@"success"] boolValue]).will.beTruthy();
    expect(resObj).will.beNil;

    
    
}



- (void)testAsync2{
    
    __block id resObj = nil;
    __block id resError = nil;
    
    NSString *url = @"http://localhost/kq/index.php/kqapi3/coupon/id/539d8cd9e4b0a98c8733f8dc";
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperationManager manager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"get url # %@,response : %@ ", url,responseObject);
        
        //        NSDictionary *dict = responseObject;
        resObj = responseObject;
        return;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"get url %@,response # %@, error # %@",url, operation.responseString,[error localizedDescription]);
        //        [UIAlertView showAlertWithError:error];
        //        block(nil,error);
        resError = error;
        return;
    }];
    
    [operation waitUntilFinished];
    
    //    expect(operation.isFinished).will.beTruthy();
    expect([[resObj objectForKey:@"success"] boolValue]).will.beTruthy();
    expect(resObj).will.beNil;
    //    expect(2).to.equal(4);
    //    expect(@"foo").to.equal(@"foo2");
    
    
}


@end
