//
//  AppDelegate.h
//  UberStations
//
//  Created by CI004 on 4/13/15.
//  Copyright (c) 2015 CI004. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RevealController.h"
#import "SliderPageView.h"
#import "Home.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navigationcont;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RevealController *viewController;
@end

