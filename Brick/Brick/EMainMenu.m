//
//  EMainMenu.m
//  Touch Spash
//
//  Created by Etienne on 28/04/2014.
//  Copyright (c) 2014 Etienne. All rights reserved.
//

#import "EMainMenu.h"
#import "constantes.h"


@implementation EMainMenu


-(id)initWithSize:(CGSize)size
{
    if(self = [super initWithSize:size])
    {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"apple.jpg"]];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Touch Splash";
        myLabel.fontSize = 50.0;
        myLabel.position = CGPointMake(WIDTH/2,
                                       HEIGHT/2 -100);
        
        NSLog(@"Init Main menu scene");
        [self addChild:myLabel];
    }
    return self;
}

//----------------------------/
#pragma mark - Touches
//----------------------------/
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    node.name = @"name";
    NSLog(@"Location x, %f", location.x);
    NSLog(@"Location y, %f \n\n", location.y);
}

@end
