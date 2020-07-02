//
//  ViewController.m
//  RunLoopSourceCode
//
//  Created by etiantian on 2020/5/18.
//  Copyright © 2020 etiantian. All rights reserved.
//

#import "ViewController.h"
#import "MTTThread.h"
#import "MTTBlockManager.h"


@interface ViewController ()
@property (nonatomic, strong) MTTThread *thread;

@end



void(^GlobalBlock2)(void) = ^{
    NSLog(@"block 存储在全局区 情况2");
};;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self threadTest];
    
//    MTTBlockManager *block = [MTTBlockManager new];
//
    [MTTBlockManager blockWithCallBack:^(NSDictionary * _Nonnull parameter) {
        NSLog(@"%@",parameter);
    }];
    
    // 1 block 只要捕获了局部变量
    // 前提: 都会存储在栈上 stackBlock
    // 情况1) 没有__block修饰,捕获的是变量的值,而不是指针.修改变量,block内部并不会改变.
    // 情况2) 如果在block内部修改变量,需要用__block修饰变量,此时通过__Block_byref_捕获的是变量地址
    // 情况3) 如果捕获的局部静态变量,捕获的是变量的指针,能够在block内部直接修改变量的值
//    __block NSInteger A = 10;
//    NSInteger B = 20;
//
//    void (^MyBlock)(void) = ^{
//        A = 30;
//        NSLog(@"A:%ld  B:%ld",(long)A,(long)B);
//        NSLog(@"%@",block);
//    };
//
//    MyBlock();
//
//    A = 12;
//    B = 22;
//
//    MyBlock();
    
    // 2 block捕获静态局部变量,静态全局变量,全局变量
    // 前提: 都会存储在栈上 stackBlock
    // 情况1) 静态局部变量,通过指针访问其值,也能在block内部对其进行修改
    // 情况2) 静态全局变量,全局变量直接访问变量,也可以修改,其作用域比较大
//    static NSInteger A = 10;
//
//    void (^NewBlock)(void) = ^{
//        A = 12;
//        B = 22;
//        C = 32;
//        NSLog(@"A: %ld B:%ld C:%ld",(long)A,(long)B,(long)C);
//    };
//
//    NewBlock();
    
    // block存储区域 global
    // 情况1) 没有捕获任何变量
    // 情况2) block定义在全局区
//    void (^GlobalBlock1)(void) = ^{
//        NSLog(@"block 存储在全局区 情况1");
//    };
//
//    GlobalBlock1();
//    GlobalBlock2();
    
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
