//
//  NSObject+ClassName.m
//  GameFriendSDK
//
//  Created by  好玩友2 on 15/12/17.
//  Copyright © 2015年  好玩友2. All rights reserved.
//

#import "NSObject+ClassName.h"

@implementation NSObject(ClassName)

+ (NSString *) className {
    return NSStringFromClass([self class]);
}

- (NSString *) className {
    return NSStringFromClass([self class]);
}

@end
