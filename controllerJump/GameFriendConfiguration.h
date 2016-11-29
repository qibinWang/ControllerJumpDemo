//
//  GameFriendConfiguration.h
//  GameFriendSDK
//
//  Created by  好玩友2 on 16/3/23.
//  Copyright © 2016年  好玩友2. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef void(^GameFriendBlock)(NSDictionary *dictionary);

#define SuccessBlockParam(msg,obj) [NSDictionary dictionaryWithObjectsAndKeys:msg,@"msg",obj,@"obj", nil]

//replacebind msg
#define kNeedReplacBindMSG @"NeedReplacBindMSG"


typedef NS_ENUM (NSUInteger, GameFriendThirdPartyType){
    GameFriendThirdPartyTypeFB = 1,
    GameFriendThirdPartyTypeGoogle,
    GameFriendThirdPartyTypeTry,
    GameFriendThirdPartyTypeKakao,
    GameFriendThirdPartyTypeNaver,
    GameFriendThirdPartyTypeGameCenter
};

typedef NS_ENUM (NSUInteger, GameFriendActivityType){
    GameFriendActivityTypeExperience = 1,
    GameFriendActivityTypeRetention,
    GameFriendActivityTypeBuy,
};

