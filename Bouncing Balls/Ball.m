//
//  Ball.m
//  Bouncing Balls
//
//  Created by Colin T Power on 2016-02-23.
//  Copyright © 2016 Colin Power. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
#import "Ball.h"
@implementation Ball





- (id)init: (int)xpos: (int)ypos {
    self = [super init];
    if (self) {
        
        //generate random doubles from 0 to 1.
        double random_x = arc4random() / ((double) (((long long)2<<31) -1) );
        random_x -= 0.5;
        
        double random_y = arc4random() / ((double) (((long long)2<<31) -1) );
        random_y -= 0.5;

        
        self->_friction = 0.1;
        self->_imageName = @"red_ball";
        self->_radius = 32;
        self->_x_vel = 10*random_x;
        
        self->_y_vel = 10*random_y;
        
        self->_x_pos = xpos;
        self->_y_pos = ypos;
        
    }
    return self;
}


-(void)calculateWallCollision: (int)height: (int)width
{
 
    //From persepctive of top left corner (origin) of a rectangle
    if (self.x_pos+2*self.radius >= width)
        self->_x_vel = -1*self->_x_vel;
    
    if (self.x_pos <= 0)
        self->_x_vel = -1*self->_x_vel;

    if (self.y_pos+2*self.radius >= height)
        self->_y_vel = -1*self->_y_vel;
    
    if (self.y_pos <= 0)
        self->_y_vel = -1*self->_y_vel;
    
    return;
}

-(void) detectCollision
{
    return;
}

-(void) applyFriction
{
    //update later to make it end up to zero
    self->_x_vel -= _friction;
    self->_y_vel -= _friction;
    
}

-(void) detectBallCollision: (Ball*) secondball
{
    
    return;
}

-(void) calculateBallCollision: (Ball*) secondball
{
    // Check whether there actually was a collision
    if (self == secondball)
        return;
    
    //Find centre of ball's relative to their topleft bounding box corner
    double a_centerX =  self.x_pos+self.radius;
    double a_centerY =  self.y_pos+self.radius;
    double b_centerX =  secondball.x_pos+secondball.radius;
    double b_centerY =  secondball.y_pos+secondball.radius;

    double distance = sqrt( (a_centerX-b_centerX)*(a_centerX-b_centerX) + (a_centerY-b_centerY)*(a_centerY-b_centerY) );
    
    
    if (distance < 2*self.radius) {
    //Just switch velocities for collisions of EQUAL MASS balls
        
    double swapX = self->_x_vel;
    double swapY = self->_y_vel;

    
    self->_x_vel = secondball->_x_vel;
    self->_y_vel = secondball->_y_vel;

    secondball->_x_vel = swapX;
    secondball->_y_vel = swapY;
    }
    
    return;
}

- (CGRect) getBallRectangle {
    return CGRectMake(self->_x_pos, self->_y_pos, 2*self->_radius, 2*self->_radius);
}



-(void) updatePosition {
    self->_x_pos += self.x_vel;
    self->_y_pos += self.y_vel;
    [self applyFriction];
}

@end