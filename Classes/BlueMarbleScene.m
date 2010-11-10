//
//  BlueMarbleSceneLayer.m
//  ProtectTint
//
//  Created by Carl Brown on 11/9/10.
//  Copyright PDAgent, LLC 2010. All rights reserved.
//

// Import the interfaces
#import "BlueMarbleScene.h"
#import "cocos2d.h"
#import "ShipSprite.h"
#import "ButtonSprite.h"

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
		ButtonSprite * blueButton = [CCSprite spriteWithFile:@"BlueButton.png"];
		ButtonSprite * redButton = [CCSprite spriteWithFile:@"RedButton.png"];
		ButtonSprite * greenButton = [CCSprite spriteWithFile:@"GreenButton.png"];
		
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		// position the Earth on the Bottom of the screen
		earth.position =  ccp( size.width/2 ,  50 /*Button Offset*/ + 48 /*Height of PNG/2 */ );
		blueButton.position =  ccp(  53.0 , 25);
		redButton.position =  ccp(  size.width - 53.0, 25);
		greenButton.position =  ccp( size.width/2 , 25);
		
		/*  Add the Space Ship sprite as a CCSprite
		*/
		CCSpriteBatchNode *shipList = [CCSpriteBatchNode batchNodeWithFile:@"SpaceShips.png"];
		[self addChild:shipList z:0];
		
		ShipSprite *ship = [[CCSprite alloc] initWithBatchNode:shipList rect:CGRectMake(0, 0, 60, 36)];
		ship.position = ccp(size.width/2, size.height-50);
		
		// add the label as a child to this Layer
		[self addChild: earth z:-1];
		[self addChild: blueButton z:0];
		[self addChild: redButton z:0];
		[self addChild: greenButton z:0];
		
		[shipList addChild:ship z:1];		

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
