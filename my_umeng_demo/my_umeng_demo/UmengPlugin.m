//
//  UmengPlugin.m
//  my_umeng_demo
//
//  Created by etiantian on 2020/7/2.
//  Copyright © 2020 etiantian. All rights reserved.
//

#import "UmengPlugin.h"
#import <UMMobClick/MobClick.h>
#import <UMMobClick/MobClickSocialAnalytics.h>

@implementation UmengPlugin

+ (void)startAnalysis {
    [MobClick setLogEnabled:true];
    [MobClick setEncryptEnabled:true];
    [MobClick setLogSendInterval:1.0];
}

@end
