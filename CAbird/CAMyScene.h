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

@property (nonatomic, retain) SKSpriteNode *ground1;
@property (nonatomic, retain) SKSpriteNode *ground2;


@end
