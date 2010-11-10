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

@synthesize gbelt;

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	BlueMarbleScene *layer = [BlueMarbleScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	[layer scheduleUpdate];
	
	// return the scene
	return scene;
}

/*
 * 360 8: Set random number seed
 */
-(void)setRandNumSeed
{
	struct timeval t;
	gettimeofday(&t, nil);
	unsigned int i;
	i = t.tv_sec;
	i += t.tv_usec;
	srandom(i);
}


// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		// create and initialize our Background
		CCSprite * earth = [CCSprite spriteWithFile:@"Earth.png"]; [earth setTag:360]; //it's a sphere
		CCSprite * moon = [CCSprite spriteWithFile:@"Moon.png"]; [earth setTag:180]; //it's a sphere
		[(id<CCRGBAProtocol>) moon setOpacity: 0];
		ButtonSprite * blueButton = [ButtonSprite spriteWithFile:@"BlueButton.png"]; [blueButton setTag:kCBlueColor];
		ButtonSprite * redButton = [ButtonSprite spriteWithFile:@"RedButton.png"];[redButton setTag:kCRedColor];;
		ButtonSprite * yellowButton = [ButtonSprite spriteWithFile:@"YellowButton.png"];[yellowButton setTag:kCYellowColor];;
		
		ShieldSprite * blueShield = [ShieldSprite spriteWithFile:@"BlueShield.png"]; [blueShield setTag:(kCShieldOffset + kCBlueColor)];
		ShieldSprite * redShield = [ShieldSprite spriteWithFile:@"RedShield.png"];[redShield setTag:(kCShieldOffset + kCRedColor)];
		ShieldSprite * greenShield = [ShieldSprite spriteWithFile:@"GreenShield.png"];[greenShield setTag:(kCShieldOffset + kCGreenColor)];
		ShieldSprite * purpleShield = [ShieldSprite spriteWithFile:@"PurpleShield.png"];[greenShield setTag:(kCShieldOffset + kCPurpleColor)];
		ShieldSprite * yellowShield = [ShieldSprite spriteWithFile:@"YellowShield.png"];[greenShield setTag:(kCShieldOffset + kCYellowColor)];
		ShieldSprite * orangeShield = [ShieldSprite spriteWithFile:@"OrangeShield.png"];[greenShield setTag:(kCShieldOffset + kCOrangeColor)];
		
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		// position the Earth on the Bottom of the screen
		earth.position =  ccp( size.width/2 ,  50 /*Button Offset*/ + 48 /*Height of PNG/2 */ );
		blueButton.position =  ccp(  53.0 , 25);
		redButton.position =  ccp(  size.width - 53.0, 25);
		yellowButton.position =  ccp( size.width/2 , 25);
		
		
		greenShield.position =  ccp( size.width/2 ,  50 /*Button Offset*/ + 48 /*Height of PNG/2 */ );
		blueShield.position =  ccp( size.width/2 ,  50 /*Button Offset*/ + 48 /*Height of PNG/2 */ );
		redShield.position =  ccp( size.width/2 ,  50 /*Button Offset*/ + 48 /*Height of PNG/2 */ );
		purpleShield.position =  ccp( size.width/2 ,  50 /*Button Offset*/ + 48 /*Height of PNG/2 */ );
		yellowShield.position =  ccp( size.width/2 ,  50 /*Button Offset*/ + 48 /*Height of PNG/2 */ );
		orangeShield.position =  ccp( size.width/2 ,  50 /*Button Offset*/ + 48 /*Height of PNG/2 */ );
		
		/*  Add the Space Ship sprite as a CCSprite
		*/
		CCSpriteBatchNode *shipList = [CCSpriteBatchNode batchNodeWithFile:@"SpaceShips.png"];
		[self addChild:shipList z:0 tag:99];
		
//		ShipSprite *ship = [[ShipSprite alloc] initWithBatchNode:shipList rect:CGRectMake(0, 0, 60, 36)];
//		ship.position = ccp(size.width/2, size.height-50);
		
		// add the label as a child to this Layer
		[self addChild: earth z:-2];
		[self addChild: moon z:-1];
		[self addChild: blueButton z:1];
		[self addChild: redButton z:1];
		[self addChild: yellowButton z:1];
		
//		id moveDownAction = [CCMoveTo actionWithDuration:2.0f position:ccp(size.width/2, 50.0)];
//		id blockMoveSeq = [CCSequence actions: moveDownAction, nil];
//		id spawnaction = [CCSpawn actions: blockMoveSeq, nil];
//		[ship runAction:[CCRepeatForever actionWithAction:spawnaction]];
//		[shipList addChild:ship];	
		
		[self setRandNumSeed];
		
		self.gbelt = [[GravityBelt alloc] initWithLayer:self];
		
		[blueButton setGbelt:self.gbelt];
		[redButton setGbelt:self.gbelt];
		[yellowButton setGbelt:self.gbelt];
		
		[self.gbelt setShields:[NSMutableArray arrayWithObjects:blueShield, greenShield, redShield, purpleShield, yellowShield, orangeShield, nil]];
		[self.gbelt addShip];


	}
	return self;
}

- (void)update:(ccTime)dt {
	[self.gbelt checkForCollision];
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
