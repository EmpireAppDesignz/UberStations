//
//  AppDelegate.h
//  JukeBox
//
//  Created by Eric Rosas on 5/7/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RevealController.h"
#import "SliderPageView.h"
#import "Home.h"

#import "BottomPlayerView.h"
@class BottomPlayerView;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navigationcont;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RevealController *viewController;
@property (strong,nonatomic) BottomPlayerView *bottomplayerview;

@end

