//
//  CAMyScene.m
//  CAbird
//
//  Created by Yuki Tomiyoshi on 2014/03/17.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "CAMyScene.h"

@implementation CAMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
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
        
        // スタートボタン
        _startButton = [[SKSpriteNode alloc] initWithImageNamed:@"start.png"];
        _startButton.anchorPoint = CGPointMake(0, 0);
        _startButton.size = CGSizeMake(self.frame.size.width / 3,
                                       self.frame.size.width / 6);
        _startButton.position = CGPointMake((self.frame.size.width - _startButton.frame.size.width) / 2,
                                            (self.frame.size.height - _startButton.frame.size.height) / 5);
        _startButton.name = @"startButton";
        [self addChild:_startButton];
        
    }
    return self;
}

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
    
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
//    }
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if(node != nil && [node.name isEqualToString:@"startButton"]) {
        _startButton.hidden = YES;
        
        [_timer invalidate];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.05f
                                                          target:self
                                                        selector:@selector(updataDisplay)
                                                        userInfo:nil
                                                         repeats:YES];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
