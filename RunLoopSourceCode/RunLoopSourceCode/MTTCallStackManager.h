//
//  MTTCallStackManager.h
//  RunLoopSourceCode
//
//  Created by etiantian on 2020/5/20.
//  Copyright © 2020 etiantian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTTCallStackManager : NSObject

+ (NSString *)backtraceWithAllThread;
+ (NSString *)backtraceWithCurrentThread;
+ (NSString *)backtraceWithMainThread;
+ (NSString *)backtraceWithThread:(NSThread *)thread;

@end

NS_ASSUME_NONNULL_END
