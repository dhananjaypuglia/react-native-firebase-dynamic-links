//
//  FirebaseDynamicLink.m
//  iService
//
//  Copyright © 2017 Dhananjay Puglia. All rights reserved.
//

#import "RNFirebaseDynamicLinks.h"

static NSString *const DEEPLINKRECEIVED = @"DEEPLINKRECEIVED";
static NSString *const EVENT_DEEP_LINK_RECEIVED = @"onDeepLinkReceived";

@implementation RNFirebaseDynamicLinks
{
    bool hasListeners;
}

RCT_EXPORT_MODULE();

-(instancetype)init
{
    self = [super init];
    hasListeners = NO;
    return self;
}

- (NSArray<NSString *> *)supportedEvents
{
    return @[EVENT_DEEP_LINK_RECEIVED];
}

// Will be called when this module's first listener is added.
-(void)startObserving {
    hasListeners = YES;
    // Set up any upstream listeners or background tasks as necessary
    // Attach local notification listener for any deeplink received
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deepLinkReceived:) name:DEEPLINKRECEIVED object:nil];
}

// Will be called when this module's last listener is removed, or on dealloc.
-(void)stopObserving {
    hasListeners = NO;
    // Remove upstream listeners, stop unnecessary background tasks
    // Remove local notification listener when there is no react native listener
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notification
- (void)deepLinkReceived:(NSNotification *) notification
{
    NSURL *deeplinkUrl = [notification object];
    if (hasListeners) { // Only send events if anyone is listening
        [self sendEventWithName:EVENT_DEEP_LINK_RECEIVED body:deeplinkUrl.absoluteString];
    }
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

