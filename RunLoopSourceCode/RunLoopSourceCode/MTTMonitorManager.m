//
//  MTTMonitorManager.m
//  RunLoopSourceCode
//
//  Created by etiantian on 2020/5/20.
//  Copyright © 2020 etiantian. All rights reserved.
//

#import "MTTMonitorManager.h"
#import <execinfo.h>

//
static const NSUInteger MXRMonitorRunLoopMinOneStandstillMillisecond = 20;
static const NSUInteger MXRMonitorRunLoopMinStandstillCount = 1;

// 卡顿时间和有效卡顿次数
static const NSUInteger MXRMonitorRunLoopDefaulStandstillMillisecond = 400;
static const NSUInteger MXRMonitorRunLoopDefaultStandstillCount = 5;

@interface MTTMonitorManager()
@property (nonatomic) CFRunLoopObserverRef observer;//runloop 状态变化观察者
@property (nonatomic) dispatch_semaphore_t semaphore;//信号量
@property (nonatomic) CFRunLoopActivity activityState;//runloop 状态

@property (nonatomic, assign) BOOL isCancel;
@property (nonatomic, assign) NSUInteger countTime;//耗时次数
@property (nonatomic, strong) NSMutableArray *backtrace;//函数调用栈

@end

@implementation MTTMonitorManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static MTTMonitorManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [MTTMonitorManager new];
        manager.limitMillisecond = MXRMonitorRunLoopDefaulStandstillMillisecond;
        manager.standstillCount = MXRMonitorRunLoopDefaultStandstillCount;
    });
    return manager;
}

- (void)setLimitMillisecond:(int)limitMillisecond {
    [self willChangeValueForKey:@"limitMillisecond"];
    _limitMillisecond = limitMillisecond >= MXRMonitorRunLoopMinOneStandstillMillisecond ? limitMillisecond : MXRMonitorRunLoopMinOneStandstillMillisecond;
    [self didChangeValueForKey:@"limitMillisecond"];
}

- (void)setStandstillCount:(int)standstillCount {
    [self willChangeValueForKey:@"standstillCount"];
    _standstillCount = standstillCount >= MXRMonitorRunLoopMinStandstillCount ? standstillCount : MXRMonitorRunLoopMinStandstillCount;
    [self didChangeValueForKey:@"standstillCount"];
}

- (void)startMonitor {
    self.isCancel = false;
    [self registerObserver];
}

static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    MTTMonitorManager *manager = [MTTMonitorManager sharedInstance];
    manager.activityState = activity;
    
    dispatch_semaphore_t semaphore = manager.semaphore;
    dispatch_semaphore_signal(semaphore);
}


/// 注册观察者 监听RunLoop的状态变化
- (void)registerObserver {
    // 初始化RunLoop observer运行环境
    CFRunLoopObserverContext context = {0,(__bridge void *)self, NULL, NULL};
    
    //runloop observer
    _observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, true, 0, &runLoopObserverCallBack, &context);
    
    // 将observer item 添加到主线程RunLoop的common mode items里面
    CFRunLoopAddObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes);
    
    // 创建信号量
    _semaphore = dispatch_semaphore_create(0);
    
    __weak __typeof(self) weakSelf = self;
    
    // 在子线程中监听时长
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        
        while (1) {
            if (strongSelf.isCancel) {
                return;
            }
            
            // N次卡顿超过阈值记录为一次卡顿
            // Returns zero on success, or non-zero if the timeout occurred.
            long dsw = dispatch_semaphore_wait(self.semaphore, dispatch_time(DISPATCH_TIME_NOW, strongSelf.limitMillisecond * NSEC_PER_MSEC));
            
            if (dsw != 0) {
                if (self.activityState == kCFRunLoopBeforeSources || self.activityState == kCFRunLoopAfterWaiting) {
                    if (++strongSelf.countTime < strongSelf.standstillCount) {
                        NSLog(@"卡顿次数:%ld",strongSelf.countTime);
                        continue;
                    }
                    // 记录当前线程的调用栈
                    [strongSelf logStack];
                    [strongSelf printLogTrace];
                }
            }
            strongSelf.countTime = 0;
        }
    });
    
}

- (void)logStack {
    NSLog(@"当前线程:%@",[NSThread currentThread]);
    void *callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    int i;
    _backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (i = 0; i < frames; i++) {
        [_backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
}

- (void)printLogTrace {
    NSLog(@"========堆栈信息==========\n %@ \n",_backtrace);
}

- (void)endMonitor {
    self.isCancel = true;
    if (!_observer) {
        return;
    }
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes);
    CFRelease(_observer);
    _observer = NULL;
}


@end
