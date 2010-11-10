//
//  ShieldSprite.m
//  ProtectTint
//
//  Created by Carl Brown on 11/10/10.
//  Copyright 2010 PDAgent, LLC. All rights reserved.
//

#import "ShieldSprite.h"


@implementation ShieldSprite

- (void)onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}

@end
