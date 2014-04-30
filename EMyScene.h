//
//  EMyScene.h
//  Brick
//

//  Copyright (c) 2014 Etienne. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>


@interface EMyScene : SKScene <AVAudioPlayerDelegate>
{
    SystemSoundID click;
    NSArray *paths;
    NSString *repertoire;
    NSString *chemin;
    NSMutableDictionary *dic;
}

@property (nonatomic, retain) UIButton *button_start;
@property (nonatomic, retain) UIButton *button_option;
@property (nonatomic, retain) UIButton *button_exit;
@property (assign) long soundDefauts;
@property (assign) long musicDefauts;

-(void)dataGame;

@end
