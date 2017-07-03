//
//  Trova.h
//  TrovaStaticLibrary
//
//  Created by Rajan on 04/12/16.
//  Copyright © 2016 Rajan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PushKit/PushKit.h>

#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
@import UserNotifications;
#endif

@class Trova;
@protocol TrovaApiDelegate <NSObject>

    - (void)trovaAPICallback:(NSString *)event
                    data:(NSArray *)data
                    from:(NSString *)from;
@end

@interface Trova : NSObject


@property(nonatomic, weak) id<TrovaApiDelegate> delegate;

- (instancetype)initWithDelegate:(id<TrovaApiDelegate>)delegate;

- (void)initTrovaWidget:(NSString *)userPhone userName:(NSString *)userName businessKey:(NSString *)businessKey resourceBundle:(NSBundle *)resourceBundle;

- (void)initTrova:(UIViewController *)viewController
      currentView:(UIViewController *)currentView
        userPhone:(NSString *)userPhone
         userName:(NSString *)userName
      businessKey:(NSString *)businessKey
   resourceBundle:(NSBundle *)resourceBundle;

- (void)initTrovAPIDashboard:(NSString *)userId
                   userPhone:(NSString *)userPhone
                    userName:(NSString *)userName
                businessName:(NSString *)businessName
                 businessKey:(NSString *)businessKey;

- (void)initTrovAPIWidget:(UIViewController *)viewController
              currentView:(UIViewController *)currentView
                userPhone:(NSString *)userPhone
                 userName:(NSString *)userName
              businessKey:(NSString *)businessKey
           resourceBundle:(NSBundle *)resourceBundle;

- (void)makeTrovaAudioCall:(NSString *)uniqueKey;

- (void)makeTrovaVideoCall:(NSString *)uniqueKey;

- (void)makeTrovaChat:(NSString *)uniqueKey;

- (void)updateTrovaCurrentViewController:(UIViewController *)fromController fromViewController:(UIViewController *)fromViewController;

- (void)connectTrova;

- (void)disconnectTrova;

- (void)trovaSendPushkitCredentials:(PKPushCredentials *)credentials;

- (void)trovaDidReceiveIncomingPushWithPayload:(PKPushPayload *)payload;

- (void)trovaPushWithPayloadAPI:(PKPushPayload *)payload;

- (void)trovaDidReceiveLocalNotification:(UILocalNotification *)notification
                                  window:(UIWindow *)window
                                   storyboard:(UIStoryboard *)storyboard;

- (void)trovaDidReceiveNotificationResponse:(UNNotificationResponse *)response
                                     window:(UIWindow *)window
                                      storyboard:(UIStoryboard *)storyboard;
- (void)amazonS3Init;

- (void)amazonS3Init:(NSString *)bucketName
           cognitoId:(NSString *)cognitoId
          regionName:(NSString *)regionName;

- (void)despatchChatEvents:(NSString *)messageId
                    userId:(NSString *)userId
                  callerId:(NSString *)callerId
                 productId:(NSString *)productId
                     event:(NSString *)event;

- (void)despatchMessage:(NSString *)message
              productId:(NSString *)productId
              messageId:(NSString *)messageId
               callerId:(NSString *)callerId;
- (void)despatchAttachment:(NSURL *)fileURL
                 productId:(NSString *)productId
                 messageId:(NSString *)messageId
                  callerId:(NSString *)callerId
                  mimeType:(NSString *)mimeType;

- (void)downloadAttachment:(NSString *)messageId
                  mimeType:(NSString *)mimeType
                 mediaLink:(NSString *)mediaLink
                   fileExt:(NSString *)fileExt;

- (void)getAllChatMessages:(NSString *)userId;

- (void)getAllNotification;

- (void)getAllSyncAppState;

- (void)getUnsyncedMessages;

- (void)pushNotification:(NSString *)message
                callerId:(NSString *)callerId
                priority:(NSString *)priority
                     ttl:(NSString *)ttl;

//#endif

@end
