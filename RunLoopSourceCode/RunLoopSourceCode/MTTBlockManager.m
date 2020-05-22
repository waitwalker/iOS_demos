//
//  MTTBlockManager.m
//  RunLoopSourceCode
//
//  Created by etiantian on 2020/5/22.
//  Copyright © 2020 etiantian. All rights reserved.
//

#import "MTTBlockManager.h"

@implementation MTTBlockManager

+ (void)blockWithCallBack:(void (^)(NSDictionary * _Nonnull))callback {
    callback(@{@"name":@"zhangsan"});
}

@end
