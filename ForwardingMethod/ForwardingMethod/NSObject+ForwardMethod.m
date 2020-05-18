//
//  NSObject+ForwardMethod.m
//  ForwardingMethod
//
//  Created by etiantian on 2020/5/18.
//  Copyright © 2020 etiantian. All rights reserved.
//

#import "NSObject+ForwardMethod.h"

@implementation NSObject (ForwardMethod)

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"ForwardMethod:class:%@, unimplemetation method:%@",NSStringFromClass([anInvocation.target class]),NSStringFromSelector(anInvocation.selector));
}

@end
