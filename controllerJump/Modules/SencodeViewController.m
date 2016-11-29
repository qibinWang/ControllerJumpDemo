//
//  SencodeViewController.m
//  controllerJump
//
//  Created by bojoy-SDK3 on 16/11/11.
//  Copyright © 2016年 bojoy-SDK3. All rights reserved.
//

#import "SencodeViewController.h"
@interface SencodeViewController ()<BJBaseHandlerPerformer>
@property (nonatomic ,copy  ) GameFriendBlock       successBlock;
@property (nonatomic ,copy  ) GameFriendBlock       failBlock;
@end

@implementation SencodeViewController
#pragma mark - BJBaseHandlerPerformer
-(void)handler:(BaseHandler *)handler withParams:(NSDictionary *)params successBlock:(GameFriendBlock)successBlock failBlock:(GameFriendBlock)failBlock{
    self.successBlock = successBlock;
    self.failBlock = failBlock;

    //    [self.gameLoginAPIManager loadData];
}


@end
