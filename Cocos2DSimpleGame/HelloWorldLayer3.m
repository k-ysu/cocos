//
//  HelloWorldLayer3.m
//  Cocos2DSimpleGame
//
//  Created by Yasushi Komori on 4/16/14.
//  Copyright Yasushi Komori 2014. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer3.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer3

// HelloWorldLayer3 implementation
@implementation HelloWorldLayer3

// Helper class method that creates a Scene with the HelloWorldLayer3 as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer3 *layer = [HelloWorldLayer3 node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // Choose one of the touches to work with
    UITouch *touch = [touches anyObject];
    CGPoint location = [self convertTouchToNodeSpace:touch];
    
    // get player
    CCSprite *player = [self getChildByTag:1];
    [player stopAllActions];
    
    // calculate the distance
    float moveX = player.position.x - location.x;
    float moveY = player.position.y - location.y;
    float absX = abs(moveX);
    float absY = abs(moveY);
    
    //calculate distance
    int distance = sqrt(absX + absY);
    
    // add action
    CCMoveTo * move =[CCMoveTo actionWithDuration:distance/10 position:ccp(location.x , location.y)];
    [move setTag:2];
    
    //add frame
    CCAnimation* animObj = [CCAnimation animation];
    if(absX < absY && moveY > 0){
        [animObj addSpriteFrameWithFilename:@"a1.jpg"];
        [animObj addSpriteFrameWithFilename:@"a2.jpg"];
        [animObj addSpriteFrameWithFilename:@"a3.jpg"];
        [animObj addSpriteFrameWithFilename:@"a2.jpg"];
     } else if (absX < absY && moveY < 0) {
        [animObj addSpriteFrameWithFilename:@"a11.jpg"];
        [animObj addSpriteFrameWithFilename:@"a10.jpg"];
        [animObj addSpriteFrameWithFilename:@"a12.jpg"];
        [animObj addSpriteFrameWithFilename:@"a10.jpg"];
     } else if (absX > absY && moveX > 0) {
        [animObj addSpriteFrameWithFilename:@"a4.jpg"];
        [animObj addSpriteFrameWithFilename:@"a5.jpg"];
        [animObj addSpriteFrameWithFilename:@"a6.jpg"];
        [animObj addSpriteFrameWithFilename:@"a5.jpg"];
     } else if (absX > absY && moveX < 0) {
        [animObj addSpriteFrameWithFilename:@"a7.jpg"];
        [animObj addSpriteFrameWithFilename:@"a8.jpg"];
        [animObj addSpriteFrameWithFilename:@"a9.jpg"];
        [animObj addSpriteFrameWithFilename:@"a8.jpg"];
     }
    
    [animObj setDelayPerUnit:0.1];
    [animObj setLoops:(distance / 10 * 2.5 + 1)];
    
    CCAnimate * animate =  [CCAnimate actionWithAnimation:animObj];
    [animate setTag:3];
    [player runAction:move];
    [player runAction:animate];
    
}


// on "init" you need to initialize your instance
-(id) init
{
    if ((self = [super initWithColor:ccc4(255,255,255,255)])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        CCSprite *player = [CCSprite spriteWithFile:@"a8.jpg"];
        player.position = ccp(player.contentSize.width/2, winSize.height/2);
        [player setScale:2];
        [self addChild:player z:1 tag:1];
        [self setIsTouchEnabled:YES];
    }
    
    [self schedule:@selector(gameLogic:) interval:1.0];
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
