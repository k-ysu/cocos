//
//  HelloWorldLayer3.h
//  Cocos2DSimpleGame
//
//  Created by Yasushi Komori on 4/16/14.
//  Copyright Yasushi Komori 2014. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer3
//@interface HelloWorldLayer3 : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
@interface HelloWorldLayer3 : CCLayerColor
{
}

// returns a CCScene that contains the HelloWorldLayer3 as the only child
+(CCScene *) scene;

@end
