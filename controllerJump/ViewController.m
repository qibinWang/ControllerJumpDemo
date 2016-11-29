//
//  ViewController.m
//  controllerJump
//
//  Created by bojoy-SDK3 on 16/11/11.
//  Copyright © 2016年 bojoy-SDK3. All rights reserved.
//

#import "ViewController.h"
#import "BussinessMediator.h"
#import <objc/runtime.h>
@interface ViewController ()
@property (nonatomic ,strong) NSDictionary *handlerKeyValuePairs;
@property (nonatomic ,strong) NSMutableDictionary *handlerKeyInstancePairs;
@property (nonatomic ,strong) NSMutableArray *handlerClassArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[BussinessMediator defaultMediator] doInitWithSuccessBlock:^(NSDictionary *dictionary){
//        
//    }failBlock:^(NSDictionary *dictionary){
//        
//    }];
     // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)jumpBtn:(UIButton *)sender {
    [self defaultMediator];
    [self instanceWithShortName:@"second"];

}


-(void)defaultMediator{
    static BussinessMediator *defaultMediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultMediator = [[BussinessMediator alloc] init];
        NSString *ruleFilePath = [[NSBundle mainBundle] pathForResource:@"HandlerKeyList.plist" ofType:nil];
        NSDictionary *ruleDict = [[NSDictionary alloc] initWithContentsOfFile:ruleFilePath];
        if (!ruleDict) {
            NSLog(@"HandlerKeyList.plist is not existed!");
        }
        self.handlerKeyValuePairs = [[NSDictionary alloc] initWithContentsOfFile:ruleFilePath];
        self.handlerKeyInstancePairs = [NSMutableDictionary dictionary];
        self.handlerClassArray = [NSMutableArray array];
    });
//    return defaultMediator;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)instanceWithShortName:(NSString *)className{
    UIViewController *handlerClass = nil;
    if (![self.handlerKeyInstancePairs objectForKey:className]) {
        Class class = NSClassFromString([self.handlerKeyValuePairs objectForKey:className]);
        if (class_isMetaClass(object_getClass(class))) {
            if ([class isSubclassOfClass:[UIViewController class]]) {
                handlerClass = [[class alloc] init];
            } else {
//                return nil;
            }
        }
        else {
//            return nil;
        }
        
        [self.handlerKeyInstancePairs setObject:handlerClass forKey:className]; //延长生命周期,并使其成为唯一instance
        NSLog(@"add handlerInstance %@",handlerClass);
        NSLog(@"handlerKeyInstancePairs %@",self.handlerKeyInstancePairs);
    }
    else{
        handlerClass = [self.handlerKeyInstancePairs objectForKey:className];
    }
    
    [self presentViewController:handlerClass animated:nil completion:nil];
}
@end
