//
//  SliderPageView.h
//  Apka Code
//
//  Created by CI004 on 2/16/15.
//  Copyright (c) 2015 CI004. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDevice+Resolutions.h"
#import "RevealController.h"
@class MainViewController;

@interface SliderPageView : UIViewController
{
    int textsize,imagewidth,imageheight,cellheight,wishcircle;
    
    __weak IBOutlet UIScrollView *SliderScrollView;
    
    //Slider Buttons Objects
    __weak IBOutlet UIButton *SearchBtn;
    __weak IBOutlet UIButton *HomeBtn;
    __weak IBOutlet UIButton *TopSongsBtn;
    __weak IBOutlet UIButton *SuggestionBtn;
    __weak IBOutlet UIButton *LocalRadioBtn;
    __weak IBOutlet UIButton *PremimumeBtn;
    __weak IBOutlet UIButton *TopShowBtn;
    __weak IBOutlet UIButton *FevoriteSongBtn;
    __weak IBOutlet UIButton *FevoriteStationBtn;
    __weak IBOutlet UIButton *StationHistoryBtn;
    __weak IBOutlet UIButton *RateUsBtn;
    __weak IBOutlet UIButton *HelpBtn;
    __weak IBOutlet UIButton *SongHistoryBtn;
    
}
- (IBAction)SearchBtnClicked:(id)sender;
- (IBAction)HomeClicked:(id)sender;
- (IBAction)TopSongClicked:(id)sender;
- (IBAction)SuggestionClicked:(id)sender;
- (IBAction)LocalRadioClicked:(id)sender;
- (IBAction)PremimumeStationClicked:(id)sender;
- (IBAction)TopShowsClicked:(id)sender;
- (IBAction)FevoriteSongClicked:(id)sender;
- (IBAction)FevoriteStationClicked:(id)sender;
- (IBAction)StationHistoryClicked:(id)sender;
- (IBAction)RateUsClicked:(id)sender;
- (IBAction)HelpClicked:(id)sender;
- (IBAction)SongHistoryClicked:(id)sender;


-(void)SizeSetForAllDevice;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic)BOOL Loginflag;
@property (nonatomic,retain)RevealController *viewcontroller;
@property (nonatomic, retain) MainViewController *mainview;

@end

