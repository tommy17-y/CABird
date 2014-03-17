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
    DokanCategory = 2
};


@interface CAMyScene : SKScene<SKPhysicsContactDelegate>
{
    SKSpriteNode* _bird;
    NSMutableArray* _dokans;
    CGSize _size;
}

@property (nonatomic, retain) SKSpriteNode *startButton;

@property (nonatomic, retain) SKSpriteNode *ground1;
@property (nonatomic, retain) SKSpriteNode *ground2;

<<<<<<< HEAD
@property (nonatomic, retain) NSTimer *timer;

=======
>>>>>>> 87b9a17d545dcdf696db2c7b0421bc43a37953ed

@end
