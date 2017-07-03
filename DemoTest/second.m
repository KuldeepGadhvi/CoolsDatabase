//
//  second.m
//  DemoTest
//
//  Created by Kuldeep Gadhvi on 20/11/16.
//  Copyright © 2016 Kuldeep Gadhvi. All rights reserved.
//
#import "ViewController.h"

#import "second.h"

@interface second ()

@end

@implementation second
@synthesize myBlock;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ok");
    // Do any additional setup after loading the view.
    NSLog(@"g >> %d",g);
    NSLog(@"restrictNew >> %@",restrictNew);
    g = 2;
    
}


int g ;

+(void)ChangeValue{
    g = 3;
    NSLog(@"restrictNew >> %@",restrictNew);

}

-(void)testMethods{
    myBlock(@"cools");

    NSLog(@"restrictNew >> %@",restrictNew);

    
}
NSString *restrictNew;

+(int )GetVvalue{
    
    return g;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
