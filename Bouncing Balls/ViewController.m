//
//  ViewController.m
//  Bouncing Balls
//
//  Created by Colin T Power on 2016-02-23.
//  Copyright © 2016 Colin Power. All rights reserved.
//

#import "ViewController.h"
#import "Ball.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSMutableArray* listOfBalls;
@property (nonatomic, strong) NSMutableArray* listOfSubviews;
@property int screenWidth;
@property int screenHeight;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    _listOfBalls = [[NSMutableArray alloc] init];
    _listOfSubviews = [[NSMutableArray alloc] init];

    
    // 2: attach gesture recognizers
 //   UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGesture:)];
  //  [self.view addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGesture:)];
    [tap setMinimumPressDuration:1.0];
    [self.view addGestureRecognizer:tap];
    

    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    [self.view addGestureRecognizer:swipe];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGesture:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
    
    
    //Make call to updateWorld every 1.0 seconds
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateWorld) userInfo:nil repeats:YES];
    

    CGRect screenRect = [self.view bounds];
    _screenWidth = screenRect.size.width;
    _screenHeight = screenRect.size.height;
    

        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) updateWorld {
    
    for (UIImageView *aView in _listOfSubviews)
    {
        [aView removeFromSuperview];
    }

    for (Ball *aBall in _listOfBalls)
        
    {
        [aBall updatePosition];
        
        for (Ball *bBall in _listOfBalls){
            [bBall calculateBallCollision:aBall];
        }
        
        [aBall calculateWallCollision:_screenHeight:_screenWidth];
        
        NSLog(@"A ball was updated");
        UIImageView *newBall = [[UIImageView alloc] initWithFrame:CGRectMake(aBall.x_pos, aBall.y_pos, 64, 64)];
        newBall.image = [UIImage imageNamed:@"red_ball"];

        
        [_listOfSubviews addObject:newBall];
        
        
        [self.view addSubview:newBall];
    }
}


#pragma mark
#pragma mark Gesture Handlers
- (void)singleTapGesture:(UITapGestureRecognizer *)recognizer {
    
    CGPoint location = [recognizer locationInView:self.view];
    //Create a new ball using a subview and image
    
    
    CGRect tapRegion = CGRectMake(location.x, location.y, 64, 64);
    
    BOOL dragFlag = NO;
    
    for (Ball *aBall in _listOfBalls) {
        CGRect BallRegion = [aBall getBallRectangle];
        
        if ( CGRectIntersectsRect(tapRegion, BallRegion) )
        {
            
            [aBall setX_pos:location.x];
            [aBall setY_pos:location.y];
            dragFlag = YES;
        }
    }

    if (dragFlag == YES) return;
    
    
    UIImageView *newBall = [[UIImageView alloc] initWithFrame:CGRectMake(location.x, location.y, 64, 64)];
    newBall.image = [UIImage imageNamed:@"red_ball"];
    [self.view addSubview:newBall];
    
    Ball * testing = [[Ball alloc] init:location.x :location.y];
    
    [_listOfSubviews addObject:newBall]; //memory leak???
    [_listOfBalls addObject:testing];
}

- (void)swipeGesture:(UISwipeGestureRecognizer *)recognizer {
    //CGPoint location = [recognizer locationInView:self.view];
}


- (void)doubleTapGesture:(UITapGestureRecognizer *)recognizer {
    
    CGPoint location = [recognizer locationInView:self.view];
    //CGRect testing = [self.view bounds]; gets superviews regions

    
    CGRect tapRegion = CGRectMake(location.x, location.y, 64, 64);
    
    NSMutableArray* targetBalls = [[NSMutableArray alloc] init];
    
    for (Ball *aBall in _listOfBalls) {
        CGRect BallRegion = [aBall getBallRectangle];
        if ( CGRectIntersectsRect(tapRegion, BallRegion) )
            [targetBalls addObject:aBall];
    }
    
    for (Ball *aBall in targetBalls)
    {
        [_listOfBalls removeObject:aBall];
        //[_listOfBalls removeObjectIdenticalTo:aBall];

    }

    NSLog(@"Double tap");
}


  //  if ([recognizer isMemberOfClass:[UITapGestureRecognizer class]]) {


@end