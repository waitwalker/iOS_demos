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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MTTThread *thread = [[MTTThread alloc]initWithTarget:self selector:@selector(threadAction) object:nil];
    [thread start];
    
}

- (void)threadAction {
    
    NSLog(@"当前线程:%@ 开始执行任务",[NSThread currentThread]);
    [NSThread sleepForTimeInterval:3.0];
    NSLog(@"当前线程:%@ 结束执行任务",[NSThread currentThread]);
}


@end
