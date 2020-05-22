//
//  MTTBlockManager.h
//  RunLoopSourceCode
//
//  Created by etiantian on 2020/5/22.
//  Copyright © 2020 etiantian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTTBlockManager : NSObject

+ (void)blockWithCallBack:(void(^)(NSDictionary *))callback;

@end

NS_ASSUME_NONNULL_END
