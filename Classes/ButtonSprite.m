//
//  ButtonSprite.m
//  ProtectTint
//
//  Created by Carl Brown on 11/9/10.
//  Copyright 2010 PDAgent, LLC. All rights reserved.
//

#import "ButtonSprite.h"

@implementation ButtonSprite

@synthesize shield;

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
		NSLog(@"Button with tag %d pushed",self.tag);
		if (self.shield) {
			[self.parent addChild:self.shield z:2];
		}
		return YES;
	}
	return NO;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	NSLog(@"Button with tag %d moved",self.tag);

}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	NSLog(@"Button with tag %d ended",self.tag);
	if (self.shield) {
		[self.parent removeChild:self.shield cleanup: YES];
	}
	

}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
	NSLog(@"Button with tag %d canceled",self.tag);
}

@end
