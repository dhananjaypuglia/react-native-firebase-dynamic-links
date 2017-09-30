//
//  FirebaseDynamicLink.m
//  iService
//
//  Copyright © 2017 Dhananjay Puglia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <RNFirebaseDynamicLinks.h>
#import <FirebaseDynamicLinks/FirebaseDynamicLinks.h>

static NSString *const DEEPLINKRECEIVED = @"DEEPLINKRECEIVED";

@implementation AppDelegate(AppDelegate)

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *, id> *)options {
    return [self application:app openURL:url sourceApplication:nil annotation:@{}];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    FIRDynamicLink *dynamicLink = [[FIRDynamicLinks dynamicLinks] dynamicLinkFromCustomSchemeURL:url];
    
    if (dynamicLink) {
        // Dispacth a local notification when the deeplink received.
        [[NSNotificationCenter defaultCenter] postNotificationName:DEEPLINKRECEIVED object:dynamicLink.url];
        return YES;
    }
    
    return NO;
}

- (BOOL)application:(UIApplication *)application
continueUserActivity:(NSUserActivity *)userActivity
 restorationHandler:(void (^)(NSArray *))restorationHandler {
    
    BOOL handled = [[FIRDynamicLinks dynamicLinks]
                    handleUniversalLink:userActivity.webpageURL
                    completion:^(FIRDynamicLink * _Nullable dynamicLink,
                                 NSError * _Nullable error) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:DEEPLINKRECEIVED object: dynamicLink.url];
                    }];
    
    return handled;
}

@end
