#include "GameLayer.h"
#include "SimpleAudioEngine.h"

using namespace; cocos2d;
using namespace CocosDenshion;

CCScene* GameLayer::scene()
{
    CCScene *scene = CCScene::create();
    GameLayer *layer = GameLayer::create();
    scene->addChild(layer);
    
    return scene;
}

bool GameLayer::init()
{
    if ( !CCLayerColor::initWithColor( ccc4(255,255,255,255)))
    {
        return false;
    }
    
    // スプライトの作成
    newSprite = CCSprite::create("char08x2.png");
    
    //画像の座標の決定
    newSprite->setPosition(ccp(100, 100));
    
    
    //画像をレイヤに追加
    this->addChild(newSprite);
    
    // タッチモードを設定する
    this->setTouchMode(kCCTouchesOneByOne);
    
    // タッチを有効にする
    this->setTouchEnabled(true);
    
    return true;
}

// タッチ用メソッド
bool GameLayer::ccTouchBegan(cocos2d::CCTouch* pTouch, cocos2d::CCEvent* pEvent)
{
    //タッチした座標を取得
    CCPoint location =pTouch->getLocation();
    
    //アニメーションを止める
    newSprite->stopActionByTag(1);
    newSprite->stopActionByTag(2);
    
    //移動距離のx, y座標を求める
    float moveX = newSprite->getPosition().x - location.x;
    float moveY = newSprite->getPosition().y - location.y;
    
    //移動距離の絶対値を求める
    float absMoveX = abs(moveX);
    float absMoveY = abs(moveY);
    
	//移動距離を求める
    float distance = sqrtf(absMoveX + absMoveY);
    
    //移動先の指定距離によって時間を変更する
    CCMoveTo* move = CCMoveTo::create(distance / 10, ccp(location.x,location.y));
    move->setTag(1);
    
    //アニメーションの作成
    CCAnimation* animation = CCAnimation::create();
    
    if (absMoveX < absMoveY && moveY > 0) {
        // 正面向きの4コマアニメーション
        animation->addSpriteFrameWithFileName("char07x2.png");
        animation->addSpriteFrameWithFileName("char08x2.png");
        animation->addSpriteFrameWithFileName("char09x2.png");
        animation->addSpriteFrameWithFileName("char08x2.png");
    } else if (absMoveX < absMoveY && moveY < 0) {
        // 後ろ向きの4コマアニメーション
        animation->addSpriteFrameWithFileName("char01x2.png");
        animation->addSpriteFrameWithFileName("char02x2.png");
        animation->addSpriteFrameWithFileName("char03x2.png");
        animation->addSpriteFrameWithFileName("char02x2.png");
    } else if (absMoveX > absMoveY && moveX > 0) {
        // 左向きの4コマアニメーション
        animation->addSpriteFrameWithFileName("char10x2.png");
        animation->addSpriteFrameWithFileName("char11x2.png");
        animation->addSpriteFrameWithFileName("char12x2.png");
        animation->addSpriteFrameWithFileName("char11x2.png");
    } else {
        // 右向きの4コマアニメーション
        animation->addSpriteFrameWithFileName("char04x2.png");
        animation->addSpriteFrameWithFileName("char05x2.png");
        animation->addSpriteFrameWithFileName("char06x2.png");
        animation->addSpriteFrameWithFileName("char05x2.png");
    }
    
    //アニメーションの設定 1 : 1コマ0.1秒で切り替える。
    animation->setDelayPerUnit(0.1);
    
 	//距離によってアニメーションのループ回数を変更する
    animation->setLoops(distance / 10 * 2.5 + 1);
    
    //アニメーションの設定
    CCAnimate* animate = CCAnimate::create(animation);
    animate->setTag(2);
    
    //アニメーションの実行
    newSprite->runAction(animate);
    newSprite->runAction(move);
    
    return true;
}

void GameLayer::ccTouchMoved(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent){
}

void GameLayer::ccTouchEnded(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent){
}

void GameLayer::ccTouchCancelled(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent){
}