//
//  ViewController.m
//  DemoTest
//
//  Created by Kuldeep Gadhvi on 19/11/16.
//  Copyright © 2016 Kuldeep Gadhvi. All rights reserved.
//




#import "ViewController.h"
#import "second.h"
#import "Database.h"

@interface ViewController ()
{
        int b;
    NSString *str;
    
}
@property (strong, nonatomic) NSString *traineeAddress;
@property (nonatomic,readwrite) int c;

@end

@implementation ViewController
{
    int f;
}

@synthesize traineeAddress;

int a;



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"traineeAddress"]){
         NSLog(@" new %@",[change valueForKey:@"new"]);
    }
}

-(IBAction)btnDelete:(id)sender{
    
}
-(IBAction)btnSearch:(id)sender{
    
}
-(IBAction)btnSave:(id)sender{
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    second *Class1 = [[second alloc] init];
    NSLog(@"str %@",[Class1 str]);
    NSMutableString *strNew = [[NSMutableString alloc] initWithString:@"str1"];
    [Class1 setStr:strNew];
    NSLog(@"str %@",[Class1 str]);
    [strNew stringByAppendingString:@"strNew"];
    NSLog(@"str %@",[Class1 str]);
    NSLog(@"strNew >> %@",strNew);


    
    
    
//    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.meetup.com/2/groups?lat=51.509980&amp;lon=-0.133700&amp;page=20&amp;key=1f5718c16a7fb3a5452f45193232"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        
//        NSLog(@"data >> %@",[NSJSONSerialization JSONObjectWithData:data options:nil error:nil]);
//        NSLog(@"ok");
//        
//    }];
    
    
//    void (^name)(int) = ^(int a){
//        NSLog(@"str >> %@",str);
//    };
    
    
//    NSLog(@"name >> %@",name);
    
    [Database copyDatabaseIfNeeded];
    NSMutableArray *Arr1 =  [Database executeQuery:@"SELECT * FROM supplier_groups INNER JOIN suppliers ON supplier_groups.group_id=suppliers.group_id where supplier_groups.group_id= '2'"];
    NSLog(@"Arr1 >> %@",Arr1);
//    traineeAddress = @"ok1";
//    
//    
//    [self addObserver:self forKeyPath:@"traineeAddress" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];//observing the key in this class
//    
////    NSString *strNew;
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        self.traineeAddress = @"ok2";
////        strNew = @"ok3";
////        str = @"ok4";
//        
//
//    });

    
    
//    second*sec  = [[second alloc] init];
//    sec.str = @"ok";
//    [sec setMyBlock:^(NSString *str1) {
//        NSLog(@"1 >> %@",str1);
//        
//    }];
    
//    [sec testMethods];
//
//    
//    NSMutableArray *arr = [[NSMutableArray alloc] init];
//    for (int a =0; a<10; a++) {
//        [arr addObject:sec];
//    }
//    
//    NSLog(@"arr >> %d",arr.count);
//    NSLog(@"ok");
    
    // Do any additional setup after loading the view, typically from a nib.
//    [self setValue:@"ok" forKey:@"str"];
//    NSLog(@"str %@",str);

//    NSLog(@" a %d",a);
//    NSLog(@" a %d",b);
//    NSLog(@" a %d",_c);
//    NSLog(@" a %d",d);
//    NSLog(@" a %d",_e);
//    NSLog(@" a %d",f);

//    NSLog(@"second %d",[second GetVvalue]);
//    [second ChangeValue];
//    NSLog(@"second %d",[second GetVvalue]);


}
-(void)instanceMethod{
    NSLog(@" a %d",a);
    NSLog(@" a %d",b);
    NSLog(@" a %d",_c);
    NSLog(@" a %d",d);
    NSLog(@" a %d",_e);
    NSLog(@" a %d",f);

}

+(void)ClassMethod{
    NSLog(@" a %d",a);
    
    
//    NSLog(@" a %d",b);
//    NSLog(@" a %d",_c);
//    NSLog(@" a %d",d);
//    NSLog(@" a %d",_e);
//    NSLog(@" a %d",f);
//    NSLog(@" a %d",self.c);
//    NSLog(@" a %d",self.e);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
