//
//  CAMyScene.m
//  CA_bird
//
//  Created by Yuki Tomiyoshi on 2014/03/17.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "CAMyScene.h"

@implementation CAMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.scaleMode = SKSceneScaleModeAspectFit;
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsWorld.gravity = CGVectorMake(0, -2);
        self.physicsWorld.contactDelegate = self;
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
//        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
//        
//        myLabel.text = @"Hello, World!";
//        myLabel.fontSize = 30;
//        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
//                                       CGRectGetMidY(self.frame));
//
//        [self addChild:myLabel];
        _size = size;
        [self addBird];
        
//        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
//        
//        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
//        
//        myLabel.text = @"Hello, World!";
//        myLabel.fontSize = 30;
//        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
//                                       CGRectGetMidY(self.frame));
//        
//        [self addChild:myLabel];

        
        // 背景画像の設定
        SKSpriteNode *background = [[SKSpriteNode alloc] initWithImageNamed:@"background.png"];
        background.anchorPoint = CGPointMake(0,0);
        background.size = self.frame.size;
        [self addChild:background];

        // 左に流れる地面の設定
        _ground1 = [[SKSpriteNode alloc] initWithImageNamed:@"ground.png"];
        _ground1.anchorPoint = CGPointMake(0, 0);
        _ground1.size = CGSizeMake(self.frame.size.width, self.frame.size.height / 666 * 147);
        _ground1.position = CGPointMake(0, 0);
        [self addChild:_ground1];
        _ground2 = [[SKSpriteNode alloc] initWithImageNamed:@"ground.png"];
        _ground2.anchorPoint = CGPointMake(0, 0);
        _ground2.size = CGSizeMake(self.frame.size.width, self.frame.size.height / 666 * 147);
        _ground2.position = CGPointMake(self.frame.size.width, 0);
        [self addChild:_ground2];
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.05f
                                                          target:self
                                                        selector:@selector(updataDisplay)
                                                        userInfo:nil
                                                         repeats:YES];

    }
    return self;
}



-(void)addBird {
    CGPoint location = CGPointMake(_size.width/2, _size.height/2);

    _bird = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];

    _bird.size = CGSizeMake(_bird.size.width/4, _bird.size.height/4);
    _bird.position = location;

    SKAction *action = [SKAction rotateByAngle:M_PI duration:1];

    [_bird runAction:[SKAction repeatActionForever:action]];


    SKPhysicsBody* body = [SKPhysicsBody bodyWithRectangleOfSize:_bird.size]; // 1
    body.restitution = 1;
    body.categoryBitMask = BirdCategory;
    body.contactTestBitMask = DokanCategory;
    _bird.physicsBody = body;

    [self addChild:_bird];
    [self addDokanAt:-40];
}


-(SKSpriteNode*)makeDokan {
    SKSpriteNode* dokan = [SKSpriteNode spriteNodeWithImageNamed:@"dokan.png"];
    SKPhysicsBody* body = [SKPhysicsBody bodyWithRectangleOfSize:dokan.size];
    body.dynamic = NO;
    body.categoryBitMask = DokanCategory;
    body.contactTestBitMask = BirdCategory;
    dokan.physicsBody = body;
    return dokan;
}

-(SKSpriteNode*)makeDokanPairAt:(CGFloat)height {
    SKSpriteNode* dokan1 = [self makeDokan];
    SKSpriteNode* dokan2 = [self makeDokan];
    dokan2.zRotation = M_PI;

    SKSpriteNode* res = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(0,0)];


    dokan1.position = CGPointMake(0,height+500);//height-20);
    dokan2.position = CGPointMake(0,height);//height-20);
    [res addChild:dokan1];
    [res addChild:dokan2];
    return res;
}

-(void)addDokanAt:(CGFloat)height {
    SKSpriteNode* dokanPair = [self makeDokanPairAt:height];

    dokanPair.position = CGPointMake(_size.width,0);
    [dokanPair runAction:[SKAction moveTo:CGPointMake(-DokanWidth, dokanPair.position.y) duration:2]];
    [self addChild:dokanPair];

-(void)updataDisplay {
    
    _ground1.position = CGPointMake(_ground1.position.x - 2, 0);
    _ground2.position = CGPointMake(_ground2.position.x - 2, 0);
    
    if (_ground2.position.x == 0) {
        _ground1.position = CGPointMake(self.frame.size.width, 0);
    }
    if (_ground1.position.x == 0) {
        _ground2.position = CGPointMake(self.frame.size.width, 0);
    }
    

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    _bird.physicsBody.velocity = CGVectorMake(0, 0);
    [_bird.physicsBody applyImpulse:CGVectorMake(0, 100)];
}

-(void)didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody, *secondBody;

    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }

    if (firstBody.categoryBitMask & BirdCategory) {
        if (secondBody.categoryBitMask & DokanCategory) {
            NSLog(@"contact!");
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    _bird.zRotation = 0;
}

@end
