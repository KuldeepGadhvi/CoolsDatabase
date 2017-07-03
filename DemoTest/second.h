//
//  second.h
//  DemoTest
//
//  Created by Kuldeep Gadhvi on 20/11/16.
//  Copyright © 2016 Kuldeep Gadhvi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface second : UIViewController

@property (nonatomic,copy) NSString *str;

@property (copy) void (^myBlock)(NSString *);

+(void)ChangeValue;
+(int )GetVvalue;
-(void)testMethods;


@end
