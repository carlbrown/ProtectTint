//
//  GravityBelt.h
//  ProtectTint
//
//  Created by Carl Brown on 11/10/10.
//  Copyright 2010 PDAgent, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface GravityBelt : NSObject {
	NSMutableArray* ships;
	CCLayer* layer;
}

@property (nonatomic, retain) NSMutableArray* ships;

-(id)initWithLayer:(CCLayer*)l;

-(NSUInteger) count;

-(id)addShip;

-(id)ShipAt:(NSUInteger)index;

-(void)removeShip:(id)Ship;

-(BOOL)checkForCollision;

@end
