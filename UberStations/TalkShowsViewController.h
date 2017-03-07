//
//  TalkShowsViewController.h
//  JukeBox
//
//  Created by Eric Rosas on 4/13/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "JSON.h"
#import "SBJSON.h"

#import "ASIHTTPRequest.h"
#import "MBProgressHUD.h"

#import "GetData.h"
#import "RevealController.h"

#import "AppDelegate.h"
#import "AudioStreamer.h"
@class AppDelegate;
@interface TalkShowsViewController : UIViewController<MBProgressHUDDelegate>
{
    AudioStreamer *streamer;

    NSString *encodeing;
    NSURL *url;
    NSMutableArray *TalkShowArray;
    __weak IBOutlet UITableView *TalkShowTable;
    MBProgressHUD *HUD;
    
    AppDelegate *app;
    
    NSString *ServicePeram;
    NSString *ShowEncodeing;
    NSMutableArray *ShowUrlArray;
    long path;
    
}
@property (nonatomic, retain) ASIHTTPRequest *GetTalkShowRequest;
@property (nonatomic, retain) ASIHTTPRequest *GetTalkShowUrlRequest;


@end
