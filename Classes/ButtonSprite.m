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
	[[CCTouchDispatcher sharedDispatcher] addStandardDelegate:self priority:0];
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}


#pragma mark -
#pragma mark CCTargetedTouchDelegate

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	for (UITouch *touch in touches) {

		CGRect rect = CGRectMake(position_.x-(contentSize_.width/2), (position_.y-(contentSize_.height/2)), contentSize_.width, contentSize_.height);
		CGPoint p = [self convertTouchToNodeSpaceAR:touch];
		CGPoint wp = [self convertToWorldSpaceAR:p];
		
		if(CGRectContainsPoint(rect, wp)) {
			NSLog(@"Button with tag %d pushed, touch count is %d, %u",self.tag, [touches count], [touch hash]);
			if (self.shield) {
				[self.parent addChild:self.shield z:2];
			}

		}
	}
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	//for (UITouch *touch in touches) {
//		NSLog(@"Button with tag %d moved count is %d",self.tag, [touches count]);
//	}

}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	for (UITouch *touch in touches) {
		NSLog(@"Button with tag %d ended, %u",self.tag, [touch hash]);
	if (self.shield) {
		[self.parent removeChild:self.shield cleanup: YES];
	}
	}
	

}

- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"Button with tag %d canceled",self.tag);
}

@end
