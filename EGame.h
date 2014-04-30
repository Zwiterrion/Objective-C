//
//  EGame.h
//  Brick
//
//  Created by Etienne on 25/04/2014.
//  Copyright (c) 2014 Etienne. All rights reserved.
//

/*typedef enum : uint8_t {
    EColliderTypeBoule = 1,
    EColliderTypeTouch = 2
}EColliderType; */

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface EGame : SKScene <AVAudioPlayerDelegate>
{
    int compteur;
    int m_lvl;
    int m_countDown;
    NSTimer *timer;
    NSTimer *time;
    NSTimer *chgLvl;
    NSTimer *finished;
    NSTimer *change;
    NSUserDefaults *musicDefauts;
    SystemSoundID back_music;
    NSArray *paths;
    NSString *repertoire;
    NSString *chemin;
    NSMutableDictionary *dic;
}

@property (nonatomic) UIButton *menu;
@property (nonatomic) SKLabelNode *score;
@property (nonatomic) NSMutableArray *pictures;
@property (nonatomic) SKLabelNode *decompte;
@property (nonatomic) UIButton *next;
@property (nonatomic) SKLabelNode *level;
@property (nonatomic) SKLabelNode *regle;
@property (assign) long musicDefaults;

-(void)moveToMenu;
-(void)changeLevel;
-(void)countDown;
-(void)nextLevel;
-(void)initLevel;
-(void)initCount;
-(void)moveToGame;
-(void)changeToGame;
-(void)dataGame;
-(void)creatOutLine;

@end
