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
#import "ShieldSprite.h"

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
		ButtonSprite * blueButton = [ButtonSprite spriteWithFile:@"BlueButton.png"]; [blueButton setTag:kCBlueColor];
		ButtonSprite * redButton = [ButtonSprite spriteWithFile:@"RedButton.png"];[redButton setTag:kCRedColor];;
		ButtonSprite * greenButton = [ButtonSprite spriteWithFile:@"GreenButton.png"];[greenButton setTag:kCGreenColor];;
		
		ShieldSprite * blueShield = [ShieldSprite spriteWithFile:@"BlueShield.png"]; [blueShield setTag:(kCShieldOffset + kCBlueColor)];
		ShieldSprite * redShield = [ShieldSprite spriteWithFile:@"RedShield.png"];[redShield setTag:(kCShieldOffset + kCRedColor)];
		ShieldSprite * greenShield = [ShieldSprite spriteWithFile:@"GreenShield.png"];[greenShield setTag:(kCShieldOffset + kCGreenColor)];
		
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		// position the Earth on the Bottom of the screen
		earth.position =  ccp( size.width/2 ,  50 /*Button Offset*/ + 48 /*Height of PNG/2 */ );
		blueButton.position =  ccp(  53.0 , 25);
		redButton.position =  ccp(  size.width - 53.0, 25);
		greenButton.position =  ccp( size.width/2 , 25);
		
		
		greenShield.position =  ccp( size.width/2 ,  50 /*Button Offset*/ + 48 /*Height of PNG/2 */ );
		blueShield.position =  ccp( size.width/2 ,  50 /*Button Offset*/ + 48 /*Height of PNG/2 */ );
		redShield.position =  ccp( size.width/2 ,  50 /*Button Offset*/ + 48 /*Height of PNG/2 */ );

		[blueButton setShield:blueShield];
		[redButton setShield:redShield];
		[greenButton setShield:greenShield];
		
		/*  Add the Space Ship sprite as a CCSprite
		*/
		CCSpriteBatchNode *shipList = [CCSpriteBatchNode batchNodeWithFile:@"SpaceShips.png"];
		[self addChild:shipList z:0 tag:99];
		
		ShipSprite *ship = [[ShipSprite alloc] initWithBatchNode:shipList rect:CGRectMake(0, 0, 60, 36)];
		ship.position = ccp(size.width/2, size.height-50);
		
		// add the label as a child to this Layer
		[self addChild: earth z:-1];
		[self addChild: blueButton z:1];
		[self addChild: redButton z:1];
		[self addChild: greenButton z:1];
		
		id moveDownAction = [CCMoveTo actionWithDuration:2.0f position:ccp(size.width/2, 50.0)];
		id blockMoveSeq = [CCSequence actions: moveDownAction, nil];
		id spawnaction = [CCSpawn actions: blockMoveSeq, nil];
		[ship runAction:[CCRepeatForever actionWithAction:spawnaction]];
		[shipList addChild:ship];	


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
