//
//  ViewController.h
//  DemoTest
//
//  Created by Kuldeep Gadhvi on 19/11/16.
//  Copyright © 2016 Kuldeep Gadhvi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    hello1,
    hello2,
    hello3,
    hello4,
} hellos;


enum {
    hello11,
    hello12,
    hello13,
    hello14,
};



@interface ViewController : UIViewController

{
    int d;
}
@property (nonatomic,readwrite) int e;



@end

