//
//  BaseHandler.h
//  controllerJump
//
//  Created by bojoy-SDK3 on 16/11/11.
//  Copyright © 2016年 bojoy-SDK3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GameFriendConfiguration.h"
@class BaseHandler;
/*************************************************************************************************/
/*                                       BJBaseHandlerInterceptor                                */
/*************************************************************************************************/
@protocol BJBaseHandlerInterceptor <NSObject>

@optional
- (void)handler:(BaseHandler *)handler beforePerformWithParams:(NSDictionary *)params;
- (void)handler:(BaseHandler *)handler afterPerformWithParams:(NSDictionary *)params;

@end
/*************************************************************************************************/
/*                                       BJBaseHandlerPerformer                                  */
/*************************************************************************************************/
@protocol BJBaseHandlerPerformer <NSObject>

-(void)handler:(BaseHandler *)handler withParams:(NSDictionary *)params successBlock:(GameFriendBlock)successBlock failBlock:(GameFriendBlock)failBlock;

@end
@interface BaseHandler : NSObject
@property (nonatomic ,assign) id<BJBaseHandlerPerformer> performer;
@property (nonatomic, assign) id<BJBaseHandlerInterceptor> interceptor;

-(void)handleWithParams:(NSDictionary *)params successBlock:(GameFriendBlock)successBlock failBlock:(GameFriendBlock)failBlock;
@end
