//
//  EOption.m
//  Brick
//
//  Created by Etienne on 25/04/2014.
//  Copyright (c) 2014 Etienne. All rights reserved.
//

#import "EOption.h"
#import "EMyScene.h"

@implementation EOption

-(id)initWithSize:(CGSize)size
{
    if(self = [super initWithSize:size])
    {
        self.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        // Text for Scene option
        SKLabelNode *option = [[SKLabelNode alloc]initWithFontNamed:@"Chalkduster"];
        option.position = CGPointMake(CGRectGetMidX(self.frame),
                                      CGRectGetMidY(self.frame) + 100);
        option.fontSize = 75.0;
        option.text = @"Options";
        [self addChild:option];
        
        
        // Label for sound
        _l_sound = [[SKLabelNode alloc]initWithFontNamed:@"Chalkduster"];
        _l_sound.position = CGPointMake(CGRectGetMidX(self.frame) - 100,
                                        CGRectGetMidY(self.frame) - 75);
        _l_sound.fontSize = 50.0;
        _l_sound.text = @"Sound";
        [self addChild:_l_sound];
        
        // Label for music
        _l_music = [[SKLabelNode alloc]initWithFontNamed:@"Chalkduster"];
        _l_music.position = CGPointMake(CGRectGetMidX(self.frame) - 100,
                                        CGRectGetMidY(self.frame) - 150);
        _l_music.text = @"Music";
        _l_music.fontSize = 50.0;
        [self addChild:_l_music];
        
        _defaults = [NSUserDefaults standardUserDefaults];
        
        
        // Switch sound
        _sound = [[UISwitch alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.frame) + 20,
                                                           CGRectGetMidY(self.frame) + 45, 50, 50)];

        // Switch music
        _music = [[UISwitch alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.frame) + 20,
                                                           CGRectGetMidY(self.frame) + 120, 50, 50)];
        // Slider for sound
        _bar_sound = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.frame)+100, CGRectGetMidY(self.frame)+35,200,50)];
        [_bar_sound setValue:[_defaults floatForKey:@"bar_sound"] animated:YES];
        [_bar_sound setTintColor:[UIColor colorWithRed:0 green:1.0 blue:0 alpha:1.0]];
        _bar_sound.hidden = YES;

        // Slider for music
        _bar_music = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.frame)+100, CGRectGetMidY(self.frame)+110,200,50)];
        [_bar_music setValue:[_defaults floatForKey:@"bar_music"] animated:YES];
        [_bar_music setTintColor:[UIColor colorWithRed:0 green:1.0 blue:0 alpha:1.0]];
        _bar_music.hidden = YES;
       
        //Audio
        AudioServicesCreateSystemSoundID(CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("brique"), CFSTR("caf"), NULL), &bip);
    }
    return self;
}
-(void)didMoveToView:(SKView *)view
{
     [self.view addSubview:_music];
     [self.view addSubview:_sound];
    
    // Sound and music
    _soundDefauts = [_defaults integerForKey:@"sound"];
    _musicDefauts = [_defaults integerForKey:@"music"];
    
    // Retrieving
    if(_soundDefauts == 1){
        [_sound setOn:YES animated:YES];
    }
    else {
        [_sound setOn:NO animated:YES];
    }
    if(_musicDefauts == 1){
        [_music setOn:YES animated:YES];
    }
    else {
        [_music setOn:FALSE animated:YES];
    }

    [self.view addSubview:_bar_sound];
    [self.view addSubview:_bar_music];
    
    // Bouton menu
    _menu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_menu setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    _menu.frame = CGRectMake(CGRectGetMidX(self.frame)-100, 800, 200, 50);
    [_menu addTarget:self action:@selector(moveToMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_menu];
}
-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
    if(self.sound.on)
    {
        _bar_sound.hidden = NO;
        [_defaults setInteger:1 forKey:@"sound"];
        [_defaults setFloat:_bar_sound.value forKey:@"bar_sound"];
    }
    else
    {
        _bar_sound.hidden = YES;
        [_defaults setInteger:0 forKey:@"sound"];
        [_defaults setFloat:_bar_sound.value forKey:@"bar_sound"];
    }
    if(self.music.on) {
        _bar_music.hidden = NO;
        [_defaults setInteger:1 forKey:@"music"];
        [_defaults setFloat:_bar_music.value forKey:@"bar_music"];
    }
    else {
        _bar_music.hidden = YES;
        [_defaults setInteger:0 forKey:@"music"];
        [_defaults setFloat:_bar_music.value forKey:@"bar_music"];
    }
}
-(void)moveToMenu
{
    EMyScene *scene = [[EMyScene alloc]initWithSize:CGSizeMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame))];
    SKTransition *transition = [SKTransition revealWithDirection:SKTransitionDirectionLeft duration:0.4];
    [_menu removeFromSuperview];
    [_sound removeFromSuperview];
    [_music removeFromSuperview];
    [_bar_music removeFromSuperview];
    [_bar_sound removeFromSuperview];
    
    if(_soundDefauts == 1)
        AudioServicesPlaySystemSound(bip);
    [self.view presentScene:scene transition:transition];
}
-(NSUserDefaults*)defaults
{
    return _defaults;
}
@end
