//
//  EMyScene.m
//  Brick
//
//  Created by Etienne on 25/04/2014.
//  Copyright (c) 2014 Etienne. All rights reserved.
//

#import "EMyScene.h"
#import "EGame.h"
#import "EOption.h"

@implementation EMyScene
{
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Casse Briques";
        myLabel.fontSize = 50.0;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame)+100);
        
        [self addChild:myLabel];
    }
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    _button_start = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_button_start setBackgroundImage:[UIImage imageNamed:@"startButton.png"] forState:UIControlStateNormal];
    _button_start.frame = CGRectMake(CGRectGetMidX(self.frame) - 100, CGRectGetMidY(self.frame), 200, 50);
    [_button_start addTarget:self action:@selector(moveToGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button_start];
    
    _button_option = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_button_option setBackgroundImage:[UIImage imageNamed:@"optionButton.png"] forState:UIControlStateNormal];
    _button_option.frame = CGRectMake(CGRectGetMidX(self.frame) - 100, CGRectGetMidY(self.frame)+75, 200, 50);
    [_button_option addTarget:self action:@selector(moveToOption) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button_option];
    
    _button_exit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_button_exit setBackgroundImage:[UIImage imageNamed:@"exitButton.png"] forState:UIControlStateNormal];
    _button_exit.frame = CGRectMake(CGRectGetMidX(self.frame) - 100, CGRectGetMidY(self.frame)+150, 200, 50);
    [_button_exit addTarget:self action:@selector(moveToExit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button_exit];
}
- (void) moveToGame
{
    EGame *scene = [[EGame alloc]initWithSize:CGSizeMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame))];
    [_button_start removeFromSuperview];
    [_button_option removeFromSuperview];
    [_button_exit removeFromSuperview];
    [self.view presentScene:scene];
}
- (void) moveToOption
{
    EOption *scene = [[EOption alloc]initWithSize:CGSizeMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame))];
    [_button_start removeFromSuperview];
    [_button_option removeFromSuperview];
    [_button_exit removeFromSuperview];
    SKTransition *transition = [SKTransition revealWithDirection:SKTransitionDirectionLeft duration:0.5];
    [self.view presentScene:scene transition:transition];
    
}
- (void) moveToExit
{
    [_button_start removeFromSuperview];
    [_button_option removeFromSuperview];
    [_button_exit removeFromSuperview];
    exit(0);
}
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
