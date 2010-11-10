//
//  BlueMarbleSceneLayer.m
//  ProtectTint
//
//  Created by Carl Brown on 11/9/10.
//  Copyright PDAgent, LLC 2010. All rights reserved.
//

// Import the interfaces
#import "BlueMarbleScene.h"
#import "CCSprite.h"

// BlueMarbleScene implementation
@implementation BlueMarbleScene

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	BlueMarbleScene *layer = [BlueMarbleScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		// create and initialize our Background
		CCSprite * earth = [CCSprite spriteWithFile:@"Earth.png"];
		
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		// position the label on the Bottom of the screen
		earth.position =  ccp( 0 , size.height - 96 );
		
		// add the label as a child to this Layer
		[self addChild: earth];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
