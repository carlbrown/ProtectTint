//
//  GravityBelt.h
//  ProtectTint
//
//  Created by Carl Brown on 11/10/10.
//  Copyright 2010 PDAgent, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ShieldSprite.h"

@interface GravityBelt : NSObject {
	NSMutableArray* ships;
	CCLayer* layer;
	NSMutableArray *shields;
	BOOL blueButtondown;
	BOOL redButtondown;
	BOOL yellowButtondown;
	ShieldSprite *currentShield;
	int opacity;
}

@property (nonatomic, retain) NSMutableArray* ships;
@property (nonatomic, retain) NSMutableArray* shields;
@property (nonatomic, retain) ShieldSprite *currentShield;
@property (nonatomic, readwrite) BOOL blueButtondown;
@property (nonatomic, readwrite) BOOL redButtondown;
@property (nonatomic, readwrite) BOOL yellowButtondown;

-(id)initWithLayer:(CCLayer*)l;

-(NSUInteger) count;

-(id)addShip;

-(id)ShipAt:(NSUInteger)index;

-(void)removeShip:(id)Ship;
-(void)runShipOffEnd:(id)Ship;

-(BOOL)checkForCollision;

-(void) buttonDownForButton:(NSInteger) button;
-(void) buttonUpForButton:(NSInteger) button;

-(void) displayShield;

@end
