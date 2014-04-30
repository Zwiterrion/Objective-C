//  Brick
//
//  Created by Etienne on 25/04/2014.
//  Copyright (c) 2014 Etienne. All rights reserved.

#import "EGame.h"
#import "EOption.h"
#import "EMyScene.h"
#import "constantes.h"
#import "EMainMenu.h"

@implementation EGame

//----------------------------/
#pragma mark - Create a scene 
//----------------------------/
- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        [self dataGame];
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
            m_lvl = 0;
            [dic setObject:[NSString stringWithFormat:@"%i", m_lvl] forKey:@"Level-1"];
            [dic writeToFile:chemin atomically:YES];
            
            musicDefauts = [NSUserDefaults standardUserDefaults];
            musicDefauts = [[[EOption alloc]init]defaults];
            _musicDefaults = [musicDefauts integerForKey:@"music"];
            
            AudioServicesCreateSystemSoundID(CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("brique"), CFSTR("caf"), NULL), &back_music);
            
            // Bouton menu
            _menu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [_menu setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
            _menu.frame = CGRectMake(650, HEIGHT- 100, 70, 70);
            [_menu addTarget:self action:@selector(moveToMenu) forControlEvents:UIControlEventTouchUpInside];
            _pictures = [NSMutableArray array];
            
            [self initLevel];
            self.physicsWorld.gravity = CGVectorMake(0, 0);
            
            // Timer for changeLevel
            timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeLevel) userInfo:nil repeats:YES];
            
            compteur = 0;
            _score = [[SKLabelNode alloc]initWithFontNamed:@"Chalkduster"];
            _score.text = [NSString stringWithFormat:@"Score : %d", compteur];
            [_score setName:@"score"];
            [_score setPosition:CGPointMake(120, 30)];
            [_score setFontSize:40.0];
            [self addChild:_score];
            [self initCount];
        }
    return self;
}
//----------------------------/
#pragma mark - Init Compteur
//----------------------------/
-(void)initCount
{
    // Init a time for a level
    _decompte = [[SKLabelNode alloc]initWithFontNamed:@"Chalkduster"];
    _decompte.position = CGPointMake(WIDTH/2, HEIGHT/2);
    m_countDown = 3;
    _decompte.text = [NSString stringWithFormat:@"%d", m_countDown];
    [_decompte setFontSize:100.0];
    [self addChild:_decompte];
    time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];

}
//----------------------------/
#pragma mark - Init Level
//----------------------------/
- (void)initLevel
{
    for(int i=0; i<4;i++)
    {
        SKShapeNode *nodes = [SKShapeNode node];
        nodes.name = @"Boule";
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddArc(path, NULL, 0, 0, 60, 0, M_PI * 2, YES);
        nodes.path = path;
        nodes.fillColor = [SKColor colorWithRed:rand()%2 green:rand()%1 blue:rand()%10 alpha:1];
        //  nodes.strokeColor = [SKColor clearColor];
        
        CGPathRelease(path);
        
        if(i == 0)
            nodes.position = CGPointMake(768/2 -100, 1024/2 +100);
        if(i == 1)
            nodes.position = CGPointMake(768/2 +100, 1024/2 +100);
        if(i == 2)
            nodes.position = CGPointMake(768/2 +100, 1024/2 -100);
        if(i == 3){
            nodes.position = CGPointMake(768/2 -100, 1024/2 -100);
        }
        
        nodes.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(200, 200)];
        nodes.physicsBody.dynamic = YES;
        nodes.physicsBody.friction = 50;
        nodes.physicsBody.collisionBitMask = NewtonSphereCollisionSphere;
        nodes.hidden = YES;
        self.userInteractionEnabled = NO;
    
        
        [_pictures addObject:nodes];
        [self addChild:nodes];
    }
    // Seconde Level Gravity
    if(m_lvl == 1) {
        NSLog(@"Deuxieme level");
        [_regle removeFromParent];
        [timer invalidate];
        for (SKShapeNode *n in _pictures)
        {
            n.position = CGPointMake(rand()%500 +150, 100);
            //n.physicsBody.angularVelocity = 2.0;
        }
        finished = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(changeLevel) userInfo:nil repeats:YES];
        [self initCount];
        [self creatOutLine];

    }
    m_lvl++;
    [dic setObject:[NSString stringWithFormat:@"%i", m_lvl] forKey:@"Level-2"];
    [dic writeToFile:chemin atomically:YES];

}
//----------------------------/
#pragma mark - Create Collision
//----------------------------/
-(void)creatOutLine
{
    CGRect worldRect = CGRectMake(0, 60, WIDTH+60, HEIGHT+5);
    SKNode *outline = [SKNode node];
    outline.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:worldRect];
    outline.physicsBody.collisionBitMask = NewtonSphereCollisionOutline;
    [self addChild:outline];
    self.physicsWorld.gravity = CGVectorMake(0.0, 0.05);
    self.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
}
//----------------------------/
#pragma mark - datGame
//----------------------------/
-(void)dataGame
{
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    repertoire = [paths objectAtIndex:0];
    chemin = [repertoire stringByAppendingPathComponent:@"level.plist"];
    dic = [[NSMutableDictionary alloc]initWithContentsOfFile:chemin];
}
//----------------------------/
#pragma mark - Decompte
//----------------------------/
- (void)countDown
{
    if(m_countDown > 1){
        m_countDown--;
        _decompte.text = [NSString stringWithFormat:@"%d", m_countDown];
    }
    else if (m_countDown == 1) {
        _decompte.text = @"Play !";
        m_countDown--;
    }
    else {
        self.userInteractionEnabled = YES;
        [time invalidate];
        _decompte.hidden = YES;
        for(int i=0; i<[_pictures count];i++) {
            SKSpriteNode *nodes = [_pictures objectAtIndex:i];
            nodes.hidden = NO;
        }
    }
        
}
//----------------------------/
#pragma mark - Touches
//----------------------------/
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if([node.name isEqualToString:@"Boule"] || [node.name isEqualToString:@"circle"]) {
        [node removeFromParent];
        [_pictures removeObject:node];
        compteur++;
        [_score setText:[NSString stringWithFormat:@"Score : %d", compteur]];
    }
}
//----------------------------/
#pragma mark - Add menu Button
//----------------------------/
-(void)didMoveToView:(SKView *)view
{
    [self.view addSubview:_menu];
}
//----------------------------/
#pragma mark - Move to Menu
//----------------------------/
-(void)moveToMenu
{
    EMyScene *scene = [[EMyScene alloc]initWithSize:CGSizeMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame))];
    [_menu removeFromSuperview];
    [self.view presentScene:scene];
}
//----------------------------/
#pragma mark - Change level
//----------------------------/
-(void)changeLevel
{
   // NSLog(@"Taille du tableau : %d", [_pictures count]);
    if([_pictures count] == 0 && m_lvl == 1){
        NSLog(@"Void changeLevel");
        [timer invalidate];
        _level = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        _level.fontSize = 75.0;
        _level.position = CGPointMake(WIDTH/2, HEIGHT/2);
        _level.fontColor = [UIColor whiteColor];
        _level.text = @"You win !";
        [self addChild:_level];
        [timer invalidate];
        chgLvl = [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(nextLevel) userInfo:nil repeats:NO];
    }
    if(m_lvl == 2 && [_pictures count] == 0) {
        [finished invalidate];
        NSLog(@"Deuxieme partie finie");
        [self moveToGame];
    }
}
//----------------------------/
#pragma mark - Next
//----------------------------/
-(void)nextLevel
{
    [chgLvl invalidate];
    [_level removeFromParent];
    _regle = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    _regle.text = @"Try again now with gravity";
    [_regle setFontSize:35.0];
    _regle.position = CGPointMake(WIDTH/2, HEIGHT/2);
    [self addChild:_regle];
    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(initLevel) userInfo:nil repeats:NO];
    
}
//----------------------------/
#pragma mark - MoveToGame
//----------------------------/
-(void)moveToGame
{
    [timer invalidate];
    SKLabelNode *finish = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    finish.text = @"The beginning is finished !";
    [finish setFontSize:50];
    [finish setPosition:CGPointMake(WIDTH/2, HEIGHT/2)];
    [self addChild:finish];
    change = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(changeToGame) userInfo:nil repeats:YES];
}
-(void)changeToGame
{
    if([change isValid])
        [change invalidate];
    NSLog(@"Changement de scene");
    EMainMenu *scene = [[EMainMenu alloc]initWithSize:CGSizeMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame))];
    [_menu removeFromSuperview];
    if(_musicDefaults == 1)
        AudioServicesPlaySystemSound(back_music);
    SKTransition *transition = [SKTransition revealWithDirection:SKTransitionDirectionRight duration:2];
    [self.view presentScene:scene transition:transition];
}
    
@end

