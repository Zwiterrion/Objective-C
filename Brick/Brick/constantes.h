//
//  constantes.h
//  Touch Spash
//
//  Created by Etienne on 28/04/2014.
//  Copyright (c) 2014 Etienne. All rights reserved.
//

#ifndef Touch_Spash_constantes_h
#define Touch_Spash_constantes_h

static const float WIDTH = 768;
static const float HEIGHT = 1024;

typedef enum : uint8_t {
 NewtonSphereCollisionSphere = 1,
 NewtonSphereCollisionOutline = 2
 }NewtonSphereCollision;

static const float NewtonOutlineFriction = 0.5;


#endif
