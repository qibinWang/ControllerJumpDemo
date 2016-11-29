//
//  BussinessMediator.h
//  controllerJump
//
//  Created by bojoy-SDK3 on 16/11/11.
//  Copyright © 2016年 bojoy-SDK3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameFriendConfiguration.h"
@interface BussinessMediator : NSObject

+ (instancetype)defaultMediator;
-(void)doInitWithSuccessBlock:(GameFriendBlock)successBlock
                    failBlock:(GameFriendBlock)failBlock;
@end
