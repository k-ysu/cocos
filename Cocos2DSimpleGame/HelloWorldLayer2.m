//
//  HelloWorldLayer2.m
//  Cocos2DSimpleGame
//
//  Created by Yasushi Komori on 4/16/14.
//  Copyright Yasushi Komori 2014. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer3.h"
#import "HelloWorldLayer.h"
#import "HelloWorldLayer2.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer2

// HelloWorldLayer2 implementation
@implementation HelloWorldLayer2

// Helper class method that creates a Scene with the HelloWorldLayer2 as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer2 *layer = [HelloWorldLayer2 node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


- (void) addMonster {
/*
    int monster_type = (arc4random() % 3) + 1;
    NSString * image_str = [NSString stringWithFormat:@"monster_%d.png" , monster_type];
    CCSprite * monster = [CCSprite spriteWithFile:image_str];
    
    // Determine where to spawn the monster along the Y axis
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minY = monster.contentSize.height / 2;
    int maxY = winSize.height - monster.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    monster.position = ccp(winSize.width + monster.contentSize.width/2, actualY);
    [self addChild:monster];
    
    // Determine speed of the monster
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                position:ccp(-monster.contentSize.width/2, actualY)];
    CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [node removeFromParentAndCleanup:YES];
    }];
    [monster runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
    [self setIsTouchEnabled:YES];
*/
    
}



// on "init" you need to initialize your instance
-(id) init
{
    if (self = [super init]) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        CCSprite *player = [CCSprite spriteWithFile:@"background.png"];
        player.anchorPoint = ccp(0, 0);
        player.position = ccp(0, 0);
        player.scaleX = winSize.width / player.contentSize.width;
        player.scaleY = winSize.height / player.contentSize.height;
        
        //CCSprite *button = [CCSprite spriteWithFile:@"start-button.png"];
        
        CCMenuItem *button = [CCMenuItemImage
                                    itemFromNormalImage:@"start-button2.png" selectedImage:@"start-button2.png"
                                    target:self selector:@selector(starButtonTapped:)];
        
        button.position = ccp( winSize.width/2 , winSize.height/4);
        //button.scaleX =button.contentSize.width;
        //button.scaleY =button.contentSize.height/2;
        CCMenu *starMenu = [CCMenu menuWithItems:button, nil];
        starMenu.position = CGPointZero;
        

        


        
        [self addChild:player];
        [self addChild:starMenu];
        [self setIsTouchEnabled:YES];
    }
    return self;
}

- (void)starButtonTapped:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[HelloWorldLayer3 scene] ]];

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

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
