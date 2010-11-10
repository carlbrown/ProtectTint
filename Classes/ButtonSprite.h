//
//  ButtonSprite.h
//  ProtectTint
//
//  Created by Carl Brown on 11/9/10.
//  Copyright 2010 PDAgent, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GravityBelt.h"

@interface ButtonSprite : CCSprite <CCStandardTouchDelegate> {
	GravityBelt *gbelt;
	NSUInteger touchHash;
}

@property (nonatomic, retain) GravityBelt *gbelt;
@property (nonatomic, assign) NSUInteger touchHash;

@end
