//
//  AppDelegate.m
//  fastocr
//
//  Created by etiantian on 2020/5/8.
//  Copyright © 2020 etiantian. All rights reserved.
//

#import "AppDelegate.h"
#import <JSPatchPlatform/JSPatch.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [JSPatch startWithAppKey:@"8beb6ce8d7ff5ded"];
    [JSPatch setupRSAPublicKey:@"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCqI6Ad6MtdKQ8QGqgOdnpngDpD\naBIr9ml/sYW3hYMMcJqI0eXRmZe7HD9lYuN8qpL+KSNltrMhtyMaHg6sUxerQTx+\nzcbfa85pUIkn3qVSqAlAOuF0a8fuV50qZfP5uBl3YNFkRvO1zR5oeZTQ9SrRUjC1\njjbjreNnN1EtW+RokQIDAQAB\n-----END PUBLIC KEY-----"];
    [JSPatch showDebugView];
    
    [JSPatch showLog];
    //[JSPatch tests_sinbund];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [JSPatch sync];
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
