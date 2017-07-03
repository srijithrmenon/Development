//
//  AppDelegate.swift
//  Sample
//
//  Created by Hari Shankar on 21/06/17.
//  Copyright © 2017 Hari Shankar. All rights reserved.
//

import UIKit
import PushKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,PKPushRegistryDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?

    let trovaResourceBundle:Bundle = Bundle(path: Bundle.main.path(forResource: "TrovaStaticLibrary", ofType: "bundle")!)!
    let trova:Trova = Trova()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        if #available(iOS 10.0, *) {
            
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions,completionHandler: {_, _ in })
        } else {
            
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        self.voipRegistration()
        
        
        trova.initTrovaWidget("demoUserPhoneNumber", userName: "demoUserName", businessKey: "businesskey", resourceBundle: trovaResourceBundle)
        return true
    }
    
    // Register for VoIP notifications
    func voipRegistration(){
        
        let mainQueue = DispatchQueue.main
        // Create a push registry object
        let voipRegistry: PKPushRegistry = PKPushRegistry(queue: mainQueue)
        // Set the registry's delegate to self
        voipRegistry.delegate = self
        // Set the push type to VoIP
        voipRegistry.desiredPushTypes = [PKPushType.voIP]
    }
    
    // Handle updated push credentials
    func pushRegistry(_ registry: PKPushRegistry, didUpdate credentials: PKPushCredentials, forType type: PKPushType) {
        
        
        // Register VoIP push token (a property of PKPushCredentials) with server
            trova.trovaSendPushkitCredentials(credentials)
        
    }
    
    // Handle incoming pushes
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, forType type: PKPushType) {
        // Process the received push
        if(UIApplication.shared.applicationState == UIApplicationState.background){
            trova.trovaDidReceiveIncomingPush(with: payload)
        }
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: trovaResourceBundle)
        trova.trovaDidReceive(notification, window: self.window, storyboard: storyBoard)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.badge, .alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: trovaResourceBundle)
        trova.trovaDidReceive(response, window: self.window, storyboard: storyBoard)
        completionHandler()
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        trova.disconnectTrova()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        trova.connect()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        trova.disconnectTrova() 
    }


}

