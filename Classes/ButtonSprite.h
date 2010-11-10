//
//  ButtonSprite.h
//  ProtectTint
//
//  Created by Carl Brown on 11/9/10.
//  Copyright 2010 PDAgent, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ShieldSprite.h"

@interface ButtonSprite : CCSprite <CCTargetedTouchDelegate> {
	ShieldSprite *shield;
}

@property (nonatomic, retain) ShieldSprite *shield;

@end
