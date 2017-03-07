//
//  StationListViewController.h
//  JukeBox
//
//  Created by Eric Rosas on 4/13/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "SBJSON.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "SBJSON.h"

#import "GetData.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

#import "AppDelegate.h"
#import "AudioStreamer.h"

@class AppDelegate;

AudioStreamer *streamer;
@interface StationListViewController : UIViewController<AVAudioPlayerDelegate>
{
    NSString *encodeing;
    NSURL *url;
    
    NSString *Playencodeing;
    NSURL *Playurl;
    
    MBProgressHUD *HUD;
    
    NSMutableArray *StationArray;
    NSMutableArray *PlayStationArray;
    __weak IBOutlet UITableView *StationTable;
    
    AVPlayer *audioPlayer;
    long path;

    NSString *resourcePath;
    AppDelegate *app;

}
@property(nonatomic,retain)NSString *TopSongSubNameStr;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic,retain)AVPlayer *songPlayer;
@property(nonatomic,retain)NSString *StationPeramStr;
@property(nonatomic,retain)NSString *SongName;
@property (nonatomic,retain)NSString *SongId;
@property (nonatomic, retain) ASIHTTPRequest *GetStationRequest;
@property (nonatomic, retain) ASIHTTPRequest *PlayStationRequest;


@end
