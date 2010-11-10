//
//  GravityBelt.m
//  ProtectTint
//
//  Created by Carl Brown on 11/10/10.
//  Copyright 2010 PDAgent, LLC. All rights reserved.
//

#import "GravityBelt.h"
#import "ShipSprite.h"
#import "ShieldSprite.h"

@implementation GravityBelt

@synthesize ships, shields, blueButtondown, greenButtondown, redButtondown, currentShield;

-(id)initWithLayer:(CCLayer*)l
{
	self = [super init];
	
	if(nil != self) {
		layer = l;
		ships = [[NSMutableArray alloc] init];
		blueButtondown=NO;
		greenButtondown=NO;
		redButtondown=NO;
		currentShield=nil;
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

-(CGRect)getSpriteBounds:(CCSprite*)sprite
{
	CGPoint p = sprite.position;
	//	CGPoint point = [layer convertToWorldSpaceAR:sprite.position];
	CGSize size = sprite.contentSize;
	
	return CGRectMake(p.x, p.y, size.width, size.height);
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
	CCSequence *combine = [CCSequence actions:act1, addTheShip, act2, remTheShip, delTheShip, nil];
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

-(BOOL)checkForCollision {
	
	//Check to see if there is an active shield
	ShieldSprite *activeShield = (ShieldSprite*) [layer getChildByTag:100];
	if (activeShield==nil) {
		activeShield = (ShieldSprite*) [layer getChildByTag:101];
	}
	if (activeShield==nil) {
		activeShield = (ShieldSprite*) [layer getChildByTag:102];
	}	
	if (activeShield==nil) {
		//TODO: Check for an Earth collision here. but for now we only care about shields
		return NO;
	}
	
	CGRect targetRect = [self getSpriteBounds:activeShield];
	NSUInteger value = (activeShield.tag-100);
	
	for(NSUInteger i = 0; i < [self.ships count]; i++) {
		ShipSprite* ship = (ShipSprite*) [self ShipAt:i];
		CGRect ShipRect = [self getSpriteBounds:ship];
		
		if(!CGRectIsNull(CGRectIntersection(targetRect, ShipRect))) {
			if(ship.tag == value) {
				[ship stopAllActions];
				[self removeShip:ship];
				
				CGSize contentSize = [activeShield contentSize];
				
				id move1 = [CCMoveBy actionWithDuration:0.5 position:ccp(contentSize.width, 0.0)];
				id delShip = [CCCallFuncN actionWithTarget:self selector:@selector(deleteShip:)];
				id seq = [CCSequence actions:move1, delShip, nil];
				
				[ship runAction:seq];
				
				
				return YES;
			}
			else {
				return NO;
			}
		}
	}

	return NO;
}

-(void) displayShield {
	if (self.currentShield) {
		[layer removeChild:self.currentShield cleanup:YES];
	}
	if (self.greenButtondown && !self.blueButtondown && !self.redButtondown) {
		[self setCurrentShield:[shields objectAtIndex:kCGreenColor]];
	} else if (!self.greenButtondown && self.blueButtondown && !self.redButtondown) {
		[self setCurrentShield:[shields objectAtIndex:kCBlueColor]];
	} else if (!self.greenButtondown && !self.blueButtondown && self.redButtondown) {
		[self setCurrentShield:[shields objectAtIndex:kCRedColor]];
	} else if (!self.greenButtondown && self.blueButtondown && self.redButtondown) {
		[self setCurrentShield:[shields objectAtIndex:kCPurpleColor]];
	} else if (self.greenButtondown && self.blueButtondown && !self.redButtondown) {
		[self setCurrentShield:[shields objectAtIndex:kCYellowColor]];
	} else if (self.greenButtondown && !self.blueButtondown && self.redButtondown) {
		[self setCurrentShield:[shields objectAtIndex:kCOrangeColor]];
	} 
	[layer addChild:self.currentShield];
}


-(void) buttonDownForButton:(NSInteger) button {
	if (button==kCBlueColor) {
		self.blueButtondown=YES;
	} else if (button==kCGreenColor) {
		self.greenButtondown=YES;
	} else if (button==kCRedColor) {
		self.redButtondown=YES;
	}
	[self displayShield];
}

-(void) buttonUpForButton:(NSInteger) button {
	if (button==kCBlueColor) {
		self.blueButtondown=NO;
	} else if (button==kCGreenColor) {
		self.greenButtondown=NO;
	} else if (button==kCRedColor) {
		self.redButtondown=NO;
	}
	[self displayShield];	
}



@end
