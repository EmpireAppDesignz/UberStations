//
//  PlayerViewController.h
//  JukeBox
//
//  Created by Eric Rosas on 5/7/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AsyncImageView.h"
#import "BottomPlayerView.h"
#import "AppDelegate.h"

#import <MediaPlayer/MPVolumeView.h>
#import <FMDB/FMDB.h>


@interface PlayerViewController : UIViewController
{
    __weak IBOutlet UIButton *CloseBtn;
    __weak IBOutlet UILabel *TitelLbl;
    __weak IBOutlet UILabel *SubTitleLbl;
    
    __weak IBOutlet UIButton *HistoryBtn;
    __weak IBOutlet UIButton *PrevouseBtn;
    __weak IBOutlet UIButton *PlayPuaseBtn;
    __weak IBOutlet UIButton *NextBtn;
    __weak IBOutlet UIButton *FevoritesBtn;
    __weak IBOutlet UISlider *Slider;
//    AsyncImageView *ArtWorkImage;
    
    __weak IBOutlet AsyncImageView *ArtWorkImage;
    AppDelegate *app;
    
    __weak IBOutlet MPVolumeView *mpVolumeView;
    FMDatabase *db;
    NSString *Chackimage;
    NSString *ChackHistoryImage;
    
    NSMutableArray *FevoritesTitlenameArray;
    NSMutableArray *FevoritesSubTitlenameArray;
    NSMutableArray *FevoritesSongUrlArray;
    NSMutableArray *FevoriteSongIdArray;
    
    NSMutableArray *FevoritesStation_TitlenameArray;
    NSMutableArray *FevoritesStation_SubTitlenameArray;
    NSMutableArray *FevoritesStation_SongUrlArray;
    NSMutableArray *FevoriteStation_SongIdArray;
    NSMutableArray *FevoriteStation_ImageUrlArray;
    
    int TempIndex;
    int TempStationIndex;
    __weak IBOutlet UIActivityIndicatorView *ProcessIndicater;
}
@property (retain,nonatomic)NSString *currentSongsURLArray;
@property (retain,nonatomic)NSString *songName;
@property(retain ,nonatomic)NSString *SubName;
@property(retain ,nonatomic)NSString *SongId;
@property (retain,nonatomic)NSString *ImageUrl;

- (IBAction)CloseBtnClick:(id)sender;
- (IBAction)HistoryClick:(id)sender;
- (IBAction)PrevouseClick:(id)sender;
- (IBAction)PlayPuaseClick:(id)sender;
- (IBAction)NextClick:(id)sender;
- (IBAction)FevritesClick:(id)sender;
- (IBAction)PlayerSliderClick:(id)sender;

@end
