//
//  ProtectTintAppDelegate.h
//  ProtectTint
//
//  Created by Carl Brown on 11/9/10.
//  Copyright PDAgent, LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface ProtectTintAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
