//
//  ShipSprite.m
//  ProtectTint
//
//  Created by Carl Brown on 11/9/10.
//  Copyright 2010 PDAgent, LLC. All rights reserved.
//

#import "ShipSprite.h"


@implementation ShipSprite

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


#pragma mark -
#pragma mark CCTargetedTouchDelegate

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	
	CGRect rect = CGRectMake(position_.x-(contentSize_.width/2), (position_.y-(contentSize_.height/2)), contentSize_.width, contentSize_.height);
	CGPoint p = [self convertTouchToNodeSpaceAR:touch];
	CGPoint wp = [self convertToWorldSpaceAR:p];
	
	if(CGRectContainsPoint(rect, wp)) {
		NSLog(@"Ship touch began");
		return YES;
	}
	return NO;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
}


@end
