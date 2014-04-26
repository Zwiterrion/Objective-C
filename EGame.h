//
//  EGame.h
//  Brick
//
//  Created by Etienne on 25/04/2014.
//  Copyright (c) 2014 Etienne. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface EGame : SKScene

@property (nonatomic, retain) UIButton *menu;
@property (nonatomic) NSMutableArray *brique;
@property (nonatomic) SKSpriteNode *raquet;

struct Player{
    float x;
    float y;
    int vies;
};

@end

