//
//  EOption.h
//  Brick
//
//  Created by Etienne on 25/04/2014.
//  Copyright (c) 2014 Etienne. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface EOption : SKScene <AVAudioPlayerDelegate>
{
    NSString *path;
    SystemSoundID bip;
}
@property (nonatomic,retain) UISwitch *sound;
@property (nonatomic,retain) UISwitch *music;
@property (nonatomic,retain) UISlider *bar_sound;
@property (nonatomic,retain) UISlider *bar_music;
@property (nonatomic,retain) SKLabelNode *l_sound;
@property (nonatomic,retain) SKLabelNode *l_music;
@property (nonatomic,retain) UIButton *menu;
@property (assign) long soundDefauts;
@property (assign) long musicDefauts;
@property (nonatomic,retain) NSUserDefaults *defaults;


-(void)moveToMenu;
-(NSUserDefaults*)defaults;
@end
