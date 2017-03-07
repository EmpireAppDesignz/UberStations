//
//  BottomPlayerView.h
//  JukeBox
//
//  Created by Eric Rosas on 5/7/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioStreamer.h"
#import "AsyncImageView.h"

#import "PlayerViewController.h"
AudioStreamer *streamer;
@interface BottomPlayerView : UIView
{
    NSString *songName;
    NSString *songURL;
//    NSMutableArray *currentSongsURLArray, *currentSongsNameArray, *currentSongsIdArray;
    int currentSongIndex;
    NSString *currentPlayImageName;
    
    int currentRadioIndex;
    AsyncImageView *PlayerSongImage;
    BottomPlayerView *Tempview;

}
@property(nonatomic,retain)NSString *PlayerShowStr;
@property(assign)int TempFevoriteIndex;
@property(assign)int TempFevoriteStationIndex;

@property(retain,nonatomic)    NSString *currentPlayImageName;
@property (retain, nonatomic) NSString  *currentSongsURLArray;
@property (retain, nonatomic) NSString *currentSongsNameArray;
@property (retain, nonatomic) NSString *currentSongsIdArray;
@property(retain,nonatomic)NSString *ImageUrlStr;
@property(retain,nonatomic)NSString *typestr;

@property (nonatomic) BOOL isPlaying;
@property (nonatomic) BOOL isRadio;
@property (nonatomic) int currentSongIndex;
@property(nonatomic,retain)NSString *SongSubName;

@property (nonatomic,strong) IBOutlet UILabel *label;
@property (nonatomic,strong) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *TitleLbl;


@property (nonatomic,strong) IBOutlet UIButton *btnNext;
@property (nonatomic,strong) IBOutlet UIButton *btnPlay;
@property (nonatomic,strong) IBOutlet UIButton *btnPrevious;

+ (id)sharedInstance;
- (IBAction)previousButtonPressed:(id)sender;
- (IBAction)playButtonPressed:(id)sender;
- (IBAction)nextButtonPressed:(id)sender;
- (void)startPlaying;
- (IBAction)openPlayerButtonPressed:(id)sender;

-(void)ShowPlayer;
-(void)HidePlayer;
-(void)NewShow;


@end
