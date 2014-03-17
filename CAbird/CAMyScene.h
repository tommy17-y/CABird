//
//  CAMyScene.h
//  CAbird
//

//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#define DokanWidth 108

enum Category {
    BirdCategory = 1,
    DokanCategory = 2,
    GroundCategory = 4
};


@interface CAMyScene : SKScene<SKPhysicsContactDelegate>
{
    SKSpriteNode* _bird;
    NSMutableArray* _dokans;
    CGSize _size;
    BOOL _started;
    CFTimeInterval _dokanTimer;
    CFTimeInterval _previousTime;

    CFTimeInterval _startTime;
    int _score;
    SKLabelNode* _scoreLabel;

    int birdImgFlag;
    int gameOverFlag;
}

@property (nonatomic, retain) SKSpriteNode *startButton;
@property (nonatomic, retain) SKSpriteNode *logo;

@property (nonatomic, retain) SKSpriteNode *ground1;
@property (nonatomic, retain) SKSpriteNode *ground2;

@property (nonatomic, retain) NSTimer *timer;

@end
