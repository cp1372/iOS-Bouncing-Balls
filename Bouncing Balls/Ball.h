//
//  Ball.h
//  Bouncing Balls
//
//  Created by Colin T Power on 2016-02-23.
//  Copyright © 2016 Colin Power. All rights reserved.
//

//#ifndef Ball_h
//#define Ball_h
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Ball : NSObject

@property double x_vel;
@property double y_vel;
@property int x_pos;
@property int y_pos;
@property double friction;
@property double radius;
@property NSString *imageName;

- (void)applyFriction;
- (void) updatePosition;
- (void) calculateBallCollision:(Ball*) secondball;
- (void)calculateWallCollision:(int)height :(int)width;
- (void)detectCollision;
- (id) init;
- (id)init:(int)x :(int)y;
- (CGRect) getBallRectangle;

@end
