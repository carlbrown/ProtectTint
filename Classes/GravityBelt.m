//
//  GravityBelt.m
//  ProtectTint
//
//  Created by Carl Brown on 11/10/10.
//  Copyright 2010 PDAgent, LLC. All rights reserved.
//

#import "GravityBelt.h"
#import "ShipSprite.h"


@implementation GravityBelt
-(id)initWithLayer:(CCLayer*)l
{
	self = [super init];
	
	if(nil != self) {
		layer = l;
		ships = [[NSMutableArray alloc] init];
	}
	
	return self;
}

-(void)dealloc
{
	[ships release];
	ships = nil;
	
	[super dealloc];
}

-(NSUInteger) count
{
	return [ships count];
}

-(id)addShip
{
	CGSize size = [[CCDirector sharedDirector] winSize];

	NSInteger pos = size.width/2;
	
	NSInteger ypos = size.height+ kShipHeight/2;
	
	CGPoint endPoint = ccp(size.width/2, 0);
	
	CCSpriteBatchNode* batch = (CCSpriteBatchNode*) [layer getChildByTag:99];
	
	NSUInteger randnum = RANDOM_SHIP_FUNC();
	
	ShipSprite *Ship = [[ShipSprite alloc] initWithBatchNode:batch rect:CGRectMake(randnum*kShipWidth, 0, kShipWidth, kShipHeight)];
	Ship.tag = randnum;
	[ships addObject:Ship];
	[batch addChild:Ship z:1];
	
	CGPoint newShipPos = ccp(pos, size.height - (kShipHeight+kShipWidth));
	Ship.position = ccp(pos, ypos);
	id act1 = [CCMoveTo actionWithDuration:1 position:newShipPos];
	id act2 = [CCMoveTo actionWithDuration:4.5 position:endPoint];
	id addTheShip = [CCCallFunc actionWithTarget:self selector:@selector(addShip)];
	id remTheShip = [CCCallFuncN actionWithTarget:self selector:@selector(removeShip:)];
	id delTheShip = [CCCallFuncN actionWithTarget:self selector:@selector(deleteShip:)];
	id combine = [CCSequence actions:act1, addTheShip, act2, remTheShip, delTheShip, nil];
	[Ship runAction:combine];
	
	return Ship;
}

-(id)ShipAt:(NSUInteger)index
{
	return [ships objectAtIndex:index];;
}

-(void)removeShip:(id)Ship
{
	CGFloat xpos = ((CCSprite*)Ship).position.x;
	
	[ships removeObject:Ship];
	
	if(xpos <= (CGFloat) kShipWidth) {
		CCSprite* b = [self addShip];
		CGPoint p = b.position;
		p.x = ((CCSprite*)Ship).position.x - kShipMargin - kShipWidth;
		b.position = p;
	}
}

-(void)deleteShip:(id)Ship
{
	CCSpriteBatchNode* batch = (CCSpriteBatchNode*) [layer getChildByTag:99];
	[batch removeChild:Ship cleanup:YES];
}

@end
