//
//  LocalRadioViewController.h
//  JukeBox
//
//  Created by Eric Rosas on 4/16/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "JSON.h"
#import "SBJSON.h"

#import "ASIHTTPRequest.h"
#import "MBProgressHUD.h"

#import "GetData.h"
#import "RevealController.h"

#import "AsyncImageView.h"

#import "AppDelegate.h"
#import "AudioStreamer.h"
@class AppDelegate;
@interface LocalRadioViewController : UIViewController<CLLocationManagerDelegate,MBProgressHUDDelegate>
{
    AppDelegate *app;
     AudioStreamer *streamer;
    CLLocationManager *locationManagerApp;
    
    NSString *latValue;
    NSString *longValue;
    
    NSString *encodeing;
    NSURL *url;
    MBProgressHUD *HUD;
    NSMutableArray *NearDataArray;
    __weak IBOutlet UITableView *NearTable;
    AsyncImageView *FeedSearchUserImage;
    
    long path;
    NSString *ServicePeram;
    NSString *NearEncodeing;
    NSMutableArray *Near_StationArray;
    UITableViewCell *cell;
}
@property (nonatomic, retain) ASIHTTPRequest *GetNewarRequest;
@property (nonatomic, retain) ASIHTTPRequest *GetNewarUrlRequest;


@end
