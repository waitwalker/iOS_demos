//
//  MTTMonitorManager.h
//  RunLoopSourceCode
//
//  Created by etiantian on 2020/5/20.
//  Copyright © 2020 etiantian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTTMonitorManager : NSObject
+ (instancetype)sharedInstance;
// 超过多少毫秒算为一次卡顿
@property (nonatomic, assign) int limitMillisecond;

// 多少次卡顿记录为一次有效, 默认为5次
@property (nonatomic, assign) int standstillCount;

// 发生一次有效的卡顿回调函数
@property (nonatomic, copy) void (^callBackWhenStandstill)(void);

// 开始监听
- (void)startMonitor;

// 结束监听
- (void)endMonitor;

@end

NS_ASSUME_NONNULL_END
