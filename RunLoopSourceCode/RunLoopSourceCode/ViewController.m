//
//  ViewController.m
//  RunLoopSourceCode
//
//  Created by etiantian on 2020/5/18.
//  Copyright © 2020 etiantian. All rights reserved.
//

#import "ViewController.h"
#import "MTTThread.h"


@interface ViewController ()
@property (nonatomic, strong) MTTThread *thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self threadTest];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self performSelector:@selector(touchTheadAction) onThread:self.thread withObject:nil waitUntilDone:false];
}

- (void)threadTest {
    MTTThread *thread = [[MTTThread alloc]initWithTarget:self selector:@selector(threadAction) object:nil];
    [thread setName:@"myThread"];
    [thread start];
    self.thread = thread;
}

- (void)threadAction {
    
    @autoreleasepool {
        NSLog(@"当前线程:%@ 开始执行任务",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"当前线程:%@ 结束执行任务",[NSThread currentThread]);
    }
}

- (void)touchTheadAction {
    @autoreleasepool {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        NSLog(@"mode: %@",runLoop.currentMode);
        [runLoop run];
    }
}


@end
