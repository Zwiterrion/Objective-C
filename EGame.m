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

- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        // Bouton menu
        _menu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_menu setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
        _menu.frame = CGRectMake(550, 15, 200, 50);
        [_menu addTarget:self action:@selector(moveToMenu) forControlEvents:UIControlEventTouchUpInside];
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
