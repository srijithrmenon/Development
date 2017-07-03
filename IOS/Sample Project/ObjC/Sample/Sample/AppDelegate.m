//
//  AppDelegate.m
//  Sample
//
//  Created by Hari Shankar on 28/06/17.
//  Copyright © 2017 Hari Shankar. All rights reserved.
//

#import "AppDelegate.h"
#import <PushKit/PushKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

NSBundle *trovaSDKResourceBundle;
Trova *trova;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    trova = [[Trova alloc]init];
    trovaSDKResourceBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"TrovaStaticLibrary" ofType:@"bundle"]];
    [trova initTrovaWidget:@"demoUserPhoneNumber" userName:@"demoUserName"  businessKey:@"businesskey" resourceBundle: trovaSDKResourceBundle];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max) {
        
        UIUserNotificationType allNotificationTypes = (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        
        // iOS 10 or later
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
        
        // For iOS 10 display notification (sent via APNS)
        
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge; [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
        }];
#endif
    }
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    [self voipRegistration];
    
    return YES;
}



// Register for VoIP notifications

- (void) voipRegistration {
    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    // Create a push registry object
    PKPushRegistry * voipRegistry = [[PKPushRegistry alloc]
                                     initWithQueue: mainQueue];
    // Set the registry's delegate to self
    voipRegistry.delegate = self;
    // Set the push type to VoIP
    voipRegistry.desiredPushTypes = [NSSet
                                     setWithObject:PKPushTypeVoIP];
}

// Handle updated push credentials

- (void)pushRegistry:(PKPushRegistry *)registry didUpdatePushCredentials:

(PKPushCredentials *)credentials forType:(NSString *)type {
    
    // Register VoIP push token (a property of PKPushCredentials) with server
    [trova trovaSendPushkitCredentials:credentials];
}

// Handle incoming pushes
- (void)pushRegistry:(PKPushRegistry *)registry
didReceiveIncomingPushWithPayload:(PKPushPayload *)payload forType:
(NSString *)type {
    
    if(UIApplication.sharedApplication.applicationState == UIApplicationStateBackground){
        // Process the received push
        [trova trovaDidReceiveIncomingPushWithPayload:payload];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:
(UILocalNotification *)notification
{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: trovaSDKResourceBundle];
        [trova trovaDidReceiveLocalNotification:notification window:self.window storyboard:storyboard];
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge);
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: trovaSDKResourceBundle];

    [trova trovaDidReceiveNotificationResponse:response window:self.window storyboard:storyboard];
    completionHandler();
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [trova disconnectTrova];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [trova connectTrova];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [trova disconnectTrova];
}


@end
