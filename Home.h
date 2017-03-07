//
//  Home.h
//  JukeBox
//
//  Created by Eric Rosas on 4/13/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ZUUIRevealController.h"
#import "RevealController.h"
#import "TopSongViewController.h"
#import "LocalRadioViewController.h"


#import <FMDB/FMDB.h>
#import "FevoriteSongViewController.h"
#import "HistorySongViewController.h"

#import "SuggestionViewController.h"
#import "PremimumeViewController.h"

@interface Home : UIViewController
{
    
    __weak IBOutlet UILabel *TimeLbl;
    __weak IBOutlet UILabel *DateLbl;
    __weak IBOutlet UILabel *DayLbl;
    
    __weak IBOutlet UIButton *NearByBtn;
    __weak IBOutlet UIButton *TopSongBtn;
    __weak IBOutlet UIButton *FevoritesBtn;
    
    __weak IBOutlet UIButton *HistoryBtn;
    FMDatabase *db;
    __weak IBOutlet UIButton *PremimumeBtn;
    

}
- (IBAction)HistorySongClick:(id)sender;
- (IBAction)FevoritesClick:(id)sender;

- (IBAction)TopSongClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *slidermenu;
- (IBAction)NearByClicked:(id)sender;
- (IBAction)SuggestionClick:(id)sender;
- (IBAction)PremimumeClick:(id)sender;
@end
