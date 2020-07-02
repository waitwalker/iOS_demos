//
//  AppDelegate.swift
//  JPushDemo
//
//  Created by etiantian on 2020/6/10.
//  Copyright © 2020 etiantian. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        registerNotifications(application)
        registerForRemoteNotifications()
        
        //推送代码
        let entity = JPUSHRegisterEntity()
        entity.types = 1 << 0 | 1 << 1 | 1 << 2
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        //需要IDFA 功能，定向投放广告功能
        //let advertisingId = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        JPUSHService.setup(withOption: launchOptions, appKey: "df496d10d06453ecec70c634", channel: "App Store", apsForProduction: false, advertisingIdentifier: nil)
        return true
    }
    
    //MARK:  注册推送
    func registerNotifications(_ application: UIApplication) {
        //-- 注册推送
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.getNotificationSettings { (setting) in
                if setting.authorizationStatus == .notDetermined{
                    // 未注册
                    center.requestAuthorization(options: [.badge,.sound,.alert]) { (result, error) in
                        print("显示内容：\(result) error：\(String(describing: error))")
                        if(result){
                            if !(error != nil){
                                print("注册成功了！")
                                application.registerForRemoteNotifications()
                            }
                        } else{
                            print("用户不允许推送")
                        }
                    }
                } else if (setting.authorizationStatus == .denied){
                    //用户已经拒绝推送通知
                    //-- 弹出页面提示用户去显示
                    
                }else if (setting.authorizationStatus == .authorized){
                    //已注册 已授权 --注册同志获取 token
                    self.registerForRemoteNotifications()
                }else{
                    
                }
            }
        }
        
    }

    // 注册通知，获取deviceToken
    func registerForRemoteNotifications() {
        // 请求授权时异步进行的，这里需要在主线程进行通知的注册
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }

}

//MARK:--推送代理
extension AppDelegate : JPUSHRegisterDelegate {
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification!) {
        
    }
    
    func jpushNotificationAuthorization(_ status: JPAuthorizationStatus, withInfo info: [AnyHashable : Any]!) {
        
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        
        let userInfo = notification.request.content.userInfo
        if notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
       // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
       completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
       let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        // 系统要求执行这个方法
        completionHandler()
    }
    
    //点推送进来执行这个方法
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
           JPUSHService.handleRemoteNotification(userInfo)
           completionHandler(UIBackgroundFetchResult.newData)
        
    }
    
    //系统获取Token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    //获取token 失败
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) { //可选
        print("did Fail To Register For Remote Notifications With Error: \(error)")
    }
}


