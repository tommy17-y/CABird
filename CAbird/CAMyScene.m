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
        self.physicsWorld.gravity = CGVectorMake(0, -5);
        self.physicsWorld.contactDelegate = self;
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        

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
        SKPhysicsBody* body1 = [SKPhysicsBody bodyWithRectangleOfSize:_ground1.size];
        body1.dynamic = NO;
        body1.restitution = 1;
        body1.categoryBitMask = GroundCategory;
        body1.contactTestBitMask = BirdCategory;
        _bird.physicsBody = body1;
        [self addChild:_ground1];

        _ground2 = [[SKSpriteNode alloc] initWithImageNamed:@"ground.png"];
        _ground2.anchorPoint = CGPointMake(0, 0);
        _ground2.size = CGSizeMake(self.frame.size.width, self.frame.size.height / 666 * 147);
        _ground2.position = CGPointMake(self.frame.size.width, 0);
        SKPhysicsBody* body2 = [SKPhysicsBody bodyWithRectangleOfSize:_ground2.size];
        body2.dynamic = NO;
        body2.restitution = 1;
        body2.categoryBitMask = GroundCategory;
        body2.contactTestBitMask = BirdCategory;
        _ground1.physicsBody = body2;
        [self addChild:_ground2];
        
        // スタートボタン
        _startButton = [[SKSpriteNode alloc] initWithImageNamed:@"start.png"];
        _startButton.anchorPoint = CGPointMake(0, 0);
        _startButton.size = CGSizeMake(self.frame.size.width / 3,
                                       self.frame.size.width / 6);
        _startButton.position = CGPointMake((self.frame.size.width - _startButton.frame.size.width) / 2,
                                            (self.frame.size.height - _startButton.frame.size.height) / 5);
        _startButton.name = @"startButton";
        [self addChild:_startButton];

        // ロゴ
        _logo = [[SKSpriteNode alloc] initWithImageNamed:@"logo.png"];
        _logo.anchorPoint = CGPointMake(0, 0);
        _logo.size = CGSizeMake(self.frame.size.width / 1.5,
                                       self.frame.size.width / 5);
        _logo.position = CGPointMake((self.frame.size.width - _logo.frame.size.width) / 2,
                                     (self.frame.size.height - _logo.frame.size.height) / 5 * 3);
        [self addChild:_logo];

        _size = size;
        [self addBird];
        [self addDokanAt:-40];
        
    }
    return self;
}



-(void)addBird {
    CGPoint location = CGPointMake(_size.width/2, _size.height/2);

    _bird = [SKSpriteNode spriteNodeWithImageNamed:@"bird.png"];

//    _bird.size = CGSizeMake(_bird.size.width/4, _bird.size.height/4);
    _bird.position = location;

    SKAction *action = [SKAction rotateByAngle:M_PI duration:1];

    [_bird runAction:[SKAction repeatActionForever:action]];


    SKPhysicsBody* body = [SKPhysicsBody bodyWithRectangleOfSize:_bird.size]; // 1
    body.dynamic = NO;
    body.restitution = 1;
    body.categoryBitMask = BirdCategory;
    body.contactTestBitMask = DokanCategory|GroundCategory;
    _bird.physicsBody = body;

    [self addChild:_bird];
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
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */

    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if(node != nil && [node.name isEqualToString:@"startButton"]) {
        _startButton.hidden = YES;
        _logo.hidden = YES;
        _bird.physicsBody.dynamic = YES;
    }
    
    _bird.physicsBody.velocity = CGVectorMake(0, 0);
    [_bird.physicsBody applyImpulse:CGVectorMake(0, 30)];
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
        if (secondBody.categoryBitMask & (DokanCategory|GroundCategory)) {
            NSLog(@"contact!");
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    _bird.zRotation = 0;
    _bird.physicsBody.velocity = CGVectorMake(0, _bird.physicsBody.velocity.dy);
    _bird.position = CGPointMake(_size.width/4, _bird.position.y);
    
    _ground1.position = CGPointMake(_ground1.position.x - 2, 0);
    _ground2.position = CGPointMake(_ground2.position.x - 2, 0);
    
    if (_ground1.position.x <= -self.frame.size.width) {
        _ground1.position = CGPointMake(self.frame.size.width, 0);
    }
    if (_ground2.position.x <= -self.frame.size.width) {
        _ground2.position = CGPointMake(self.frame.size.width, 0);
    }

    if (_previousTime) {
        CFTimeInterval dt = currentTime - _previousTime;
        // generate dokan
        _dokanTimer += dt;
        if (_dokanTimer >= 1) {
            int minY = -50;
            int maxY = 50;
            int rangeY = maxY - minY;
            int height = arc4random() % rangeY + minY;

            [self addDokanAt: height];
            _dokanTimer = 0;
        }

    }
    _previousTime = currentTime;
}

@end
