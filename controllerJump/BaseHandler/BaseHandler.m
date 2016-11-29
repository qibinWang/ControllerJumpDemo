//
//  BaseHandler.m
//  controllerJump
//
//  Created by bojoy-SDK3 on 16/11/11.
//  Copyright © 2016年 bojoy-SDK3. All rights reserved.
//

#import "BaseHandler.h"
#import "NSObject+ClassName.h"
@implementation BaseHandler

#pragma mark - life cycle
-(instancetype)init{
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(BJBaseHandlerPerformer)]) {
            self.performer = (id <BJBaseHandlerPerformer>)self;
        }
    }
    return self;
}

#pragma mark -private method
- (void)beforePerformWithParams:(NSDictionary *)params{
    if (self.interceptor && [self.interceptor respondsToSelector:@selector(handler:beforePerformWithParams:)]) {
        [self.interceptor handler:self afterPerformWithParams:params];
    }
}

- (void)afterPerformWithParams:(NSDictionary *)params{
    if (self.interceptor && [self.interceptor respondsToSelector:@selector(handler:afterPerformWithParams:)]) {
        [self.interceptor handler:self afterPerformWithParams:params];
    }
}

- (void)handleWithParams:(NSDictionary *)params successBlock:(GameFriendBlock)successBlock failBlock:(GameFriendBlock)failBlock;{
    [self beforePerformWithParams:params];
    if (self.performer && [self.performer respondsToSelector:@selector(handler:withParams:successBlock:failBlock:)]) {
        [self.performer handler:self withParams:params successBlock:successBlock failBlock:failBlock];
    }
    else{
        if (failBlock) {
            failBlock(nil);
        }
    }
    [self afterPerformWithParams:params];
}

#pragma mark - BJBaseHandlerPerformer
-(void)handler:(BaseHandler *)handler withParams:(NSDictionary *)params successBlock:(GameFriendBlock)successBlock failBlock:(GameFriendBlock)failBlock{
    
    
}

@end
