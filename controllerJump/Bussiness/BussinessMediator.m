//
//  BussinessMediator.m
//  controllerJump
//
//  Created by bojoy-SDK3 on 16/11/11.
//  Copyright © 2016年 bojoy-SDK3. All rights reserved.
//

#import "BussinessMediator.h"
#import <objc/runtime.h>
#import "GameFriendConfiguration.h"
#import "BaseHandler.h"

//初始化模块
static NSString *kBJBusinessLaunchKey = @"second";

@interface BussinessMediator ()

@property (nonatomic ,strong) NSDictionary *handlerKeyValuePairs;
@property (nonatomic ,strong) NSMutableDictionary *handlerKeyInstancePairs;
@property (nonatomic ,strong) NSMutableArray *handlerClassArray;

@end

@implementation BussinessMediator


+ (instancetype)defaultMediator{
    static BussinessMediator *defaultMediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultMediator = [[BussinessMediator alloc] init];
        NSString *ruleFilePath = [[NSBundle mainBundle] pathForResource:@"HandlerKeyList.plist" ofType:nil];
        NSDictionary *ruleDict = [[NSDictionary alloc] initWithContentsOfFile:ruleFilePath];
        if (!ruleDict) {
            NSLog(@"HandlerKeyList.plist is not existed!");
        }
        defaultMediator.handlerKeyValuePairs = [[NSDictionary alloc] initWithContentsOfFile:ruleFilePath];
        defaultMediator.handlerKeyInstancePairs = [NSMutableDictionary dictionary];
        defaultMediator.handlerClassArray = [NSMutableArray array];
    });
    return defaultMediator;
}

-(BaseHandler *)instanceWithShortName:(NSString *)className{
    BaseHandler *handlerClass = nil;
    if (![self.handlerKeyInstancePairs objectForKey:className]) {
        Class class = NSClassFromString([self.handlerKeyValuePairs objectForKey:className]);
        if (class_isMetaClass(object_getClass(class))) {
            if ([class isSubclassOfClass:[BaseHandler class]]) {
                handlerClass = [[class alloc] init];
            } else {
                return nil;
            }
        }
        else {
            return nil;
        }
        
        [self.handlerKeyInstancePairs setObject:handlerClass forKey:className]; //延长生命周期,并使其成为唯一instance
        NSLog(@"add handlerInstance %@",handlerClass);
        NSLog(@"handlerKeyInstancePairs %@",self.handlerKeyInstancePairs);
    }
    else{
        handlerClass = [self.handlerKeyInstancePairs objectForKey:className];
    }
    
    return handlerClass;
}

-(void)doInitWithSuccessBlock:(GameFriendBlock)successBlock
                    failBlock:(GameFriendBlock)failBlock;{
    [self handleWithClassKey:kBJBusinessLaunchKey params:nil successBlock:successBlock failBlock:failBlock];
}
-(void)handleWithClassKey:(NSString *)handleClassKey
                   params:(NSDictionary *)params
             successBlock:(GameFriendBlock)successBlock
                failBlock:(GameFriendBlock)failBlock{
    BaseHandler *handlerInstance = [self instanceWithShortName:handleClassKey];
    if (!handlerInstance) {
        NSLog(@"handlerInstance %@ is not existed!",handleClassKey);
        NSLog(@"sdk stop handling");
        return;
    }

    [handlerInstance handleWithParams:params successBlock:successBlock failBlock:failBlock];
}

@end
