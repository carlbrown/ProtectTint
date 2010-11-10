//
//  BlueMarbleScene.h
//  ProtectTint
//
//  Created by Carl Brown on 11/9/10.
//  Copyright 2010 PDAgent, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GravityBelt.h"

// BlueMarbleScene Layer
@interface BlueMarbleScene : CCLayer
{
	GravityBelt *gbelt;
}

@property (nonatomic, retain) GravityBelt *gbelt;

// returns a Scene that contains the BlueMarbleScene as the only child
+(id) scene;


@end

