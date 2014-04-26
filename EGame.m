//
//  EGame.m
//  Brick
//
//  Created by Etienne on 25/04/2014.
//  Copyright (c) 2014 Etienne. All rights reserved.
//

#import "EGame.h"
#import "EOption.h"
#import "EMyScene.h"

@implementation EGame
{
    
}

- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        // Bouton menu
        _menu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_menu setBackgroundImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        _menu.frame = CGRectMake(650, 25, 100, 100);
        [_menu addTarget:self action:@selector(moveToMenu) forControlEvents:UIControlEventTouchUpInside];
        
      /*  _brique = [NSMutableArray array];
        for(int i =0; i<10; i++)
        {
            SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"brique.png"];
            //node.position = CGPointMake(<#CGFloat x#>, <#CGFloat y#>)
            [_brique insertObject:node atIndex:i];
        }*/
    }
    return self;
}
-(void)didMoveToView:(SKView *)view
{
    [self.view addSubview:_menu];
    
    
}
-(void)moveToMenu
{
    EMyScene *scene = [[EMyScene alloc]initWithSize:CGSizeMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame))];
    SKTransition *transition = [SKTransition revealWithDirection:SKTransitionDirectionLeft duration:0.2];
    [_menu removeFromSuperview];
    [self.view presentScene:scene transition:transition];
}


@end
