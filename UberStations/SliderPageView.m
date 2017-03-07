//
//  SliderPageView.m
//  JukeBox
//
//  Created by Eric Rosas on 5/7/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//
#import "SliderPageView.h"
#import "HOME.h"

@interface SliderPageView ()
{
    NSMutableArray *logincheck;
    UINavigationController *nav;
    BOOL dashboardflag;
    NSArray *myData;
}
@end
@implementation SliderPageView
@synthesize tableview,Loginflag,mainview;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[UIScreen mainScreen] bounds].size.height==736)
    {
        
    }
    else if ([[UIScreen mainScreen] bounds].size.height==667)
    {
        SliderScrollView.contentSize=CGSizeMake(375, 870);
//        SliderScrollView.contentSize=CGSizeMake(self.view.frame.size.width,self.view.frame.size.height);
//        [SliderScrollView setContentSize:(CGSizeMake(self.view.frame.size.width, self.view.frame.size.height))];

    }
    else if ([[UIScreen mainScreen] bounds].size.height==568)
    {
        SliderScrollView.contentSize=CGSizeMake(320, 960);
    }
    else
    {
        SliderScrollView.contentSize=CGSizeMake(320, 1050);
    }
}
-(void)viewWillAppear:(BOOL)animated
{
       [super viewWillAppear:YES];
}
/*-(void)SizeSetForAllDevice
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[ UIScreen mainScreen ] bounds ].size.height == 736)
        {
            //iphone 6+
            textsize=21;
            cellheight=70;
            imageheight=30;
            imagewidth=30;
            wishcircle=40;
        }
        else if([[ UIScreen mainScreen ] bounds ].size.height == 667)
        {
            //iphone 6
            textsize=21;
            cellheight=65;
            imageheight=30;
            imagewidth=30;
            wishcircle=40;
        }
        else
        {
            if ([UIDevice currentResolution] == UIDevice_iPhoneTallerHiRes)
            {
                //iphone 5
                textsize=20;
                cellheight=55;
                imageheight=25;
                imagewidth=25;
                wishcircle=30;
            }
            else
            {
                //iphone 4
                textsize=18;
                cellheight=50;
                imageheight=25;
                imagewidth=25;
                wishcircle=30;
            }
        }
    }
    else
    {
        textsize=21;
        cellheight=70;
        imageheight=30;
        imagewidth=30;
        wishcircle=40;
    }
}*/
- (IBAction)SearchBtnClicked:(id)sender
{
    RevealController *revealController = [self.parentViewController isKindOfClass :[RevealController class]] ? (RevealController *)self.parentViewController : nil;
    if ([revealController.frontViewController isKindOfClass :[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass :[MainSearchViewController class]])
    {
        MainSearchViewController *Mainsearch = [[MainSearchViewController alloc] init] ;
        UINavigationController *Nav = [[UINavigationController alloc] initWithRootViewController:Mainsearch];
        [revealController setFrontViewController:Nav animated:NO];
    }
    else
    {
        [revealController revealToggle:self];
    }
}
- (IBAction)HomeClicked:(id)sender
{
    SongHistoryBtn.selected=NO;
    RateUsBtn.selected=NO;
    StationHistoryBtn.selected=NO;
    FevoriteStationBtn.selected=NO;
    FevoriteSongBtn.selected=NO;
    TopShowBtn.selected=NO;
    
    PremimumeBtn.selected=NO;
    LocalRadioBtn.selected=NO;
    SuggestionBtn.selected=NO;
    TopSongsBtn.selected=NO;
    SearchBtn.selected=NO;
    HomeBtn.selected=NO;
    
    RevealController *revealController = [self.parentViewController isKindOfClass :[RevealController class]] ? (RevealController *)self.parentViewController : nil;
    if ([revealController.frontViewController isKindOfClass :[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass :[Home class]])
    {
        Home *home = [[Home alloc] init] ;
        UINavigationController *Nav = [[UINavigationController alloc] initWithRootViewController:home] ;
        [revealController setFrontViewController:Nav animated:NO];
    }
    else
    {
        [revealController revealToggle:self];
    }
}
- (IBAction)TopSongClicked:(id)sender
{
    if ([TopSongsBtn isSelected])
    {
        TopSongsBtn.selected=NO;
    }
    else
    {
        TopSongsBtn.selected=YES;
        SearchBtn.selected=NO;
        HomeBtn.selected=NO;
        SuggestionBtn.selected=NO;
        LocalRadioBtn.selected=NO;
        PremimumeBtn.selected=NO;
        TopShowBtn.selected=NO;
        FevoriteSongBtn.selected=NO;
        FevoriteStationBtn.selected=NO;
        StationHistoryBtn.selected=NO;
        RateUsBtn.selected=NO;
        HelpBtn.selected=NO;
        SongHistoryBtn.selected=NO;
    }
    
    RevealController *revealController = [self.parentViewController isKindOfClass :[RevealController class]] ? (RevealController *)self.parentViewController : nil;
    if ([revealController.frontViewController isKindOfClass :[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass :[TopSongViewController class]])
    {
        TopSongViewController *Top=[[TopSongViewController alloc] init];
        
        UINavigationController *Nav = [[UINavigationController alloc] initWithRootViewController:Top];
        [revealController setFrontViewController:Nav animated:NO];
    }
    else
    {
        [revealController revealToggle:self];
    }
    
}
- (IBAction)SuggestionClicked:(id)sender
{
    if ([SuggestionBtn isSelected])
    {
        SuggestionBtn.selected=NO;
    }
    else
    {
        SuggestionBtn.selected=YES;

        TopSongsBtn.selected=NO;
        SearchBtn.selected=NO;
        HomeBtn.selected=NO;
        LocalRadioBtn.selected=NO;
        PremimumeBtn.selected=NO;
        TopShowBtn.selected=NO;
        FevoriteSongBtn.selected=NO;
        FevoriteStationBtn.selected=NO;
        StationHistoryBtn.selected=NO;
        RateUsBtn.selected=NO;
        HelpBtn.selected=NO;
        SongHistoryBtn.selected=NO;
    }
    RevealController *revealController = [self.parentViewController isKindOfClass :[RevealController class]] ? (RevealController *)self.parentViewController : nil;
    if ([revealController.frontViewController isKindOfClass :[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass :[SuggestionViewController class]])
    {
        SuggestionViewController *Suggestion=[[SuggestionViewController alloc] init];
        
        UINavigationController *Nav = [[UINavigationController alloc] initWithRootViewController:Suggestion];
        [revealController setFrontViewController:Nav animated:NO];
    }
    else
    {
        [revealController revealToggle:self];
    }
}
- (IBAction)LocalRadioClicked:(id)sender
{
    if ([LocalRadioBtn isSelected])
    {
        LocalRadioBtn.selected=NO;
    }
    else
    {
        LocalRadioBtn.selected=YES;
        
        SuggestionBtn.selected=NO;
        TopSongsBtn.selected=NO;
        SearchBtn.selected=NO;
        HomeBtn.selected=NO;
        PremimumeBtn.selected=NO;
        TopShowBtn.selected=NO;
        FevoriteSongBtn.selected=NO;
        FevoriteStationBtn.selected=NO;
        StationHistoryBtn.selected=NO;
        RateUsBtn.selected=NO;
        HelpBtn.selected=NO;
        SongHistoryBtn.selected=NO;
    }
    
    RevealController *revealController = [self.parentViewController isKindOfClass :[RevealController class]] ? (RevealController *)self.parentViewController : nil;
    if ([revealController.frontViewController isKindOfClass :[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass :[LocalRadioViewController class]])
    {
        LocalRadioViewController *Local=[[LocalRadioViewController alloc] init];
        
        UINavigationController *Nav = [[UINavigationController alloc] initWithRootViewController:Local];
        [revealController setFrontViewController:Nav animated:NO];
    }
    else
    {
        [revealController revealToggle:self];
    }
}
- (IBAction)PremimumeStationClicked:(id)sender
{
    if ([PremimumeBtn isSelected])
    {
        PremimumeBtn.selected=NO;
    }
    else
    {
        PremimumeBtn.selected=YES;
        LocalRadioBtn.selected=NO;
        
        SuggestionBtn.selected=NO;
        TopSongsBtn.selected=NO;
        SearchBtn.selected=NO;
        HomeBtn.selected=NO;
        TopShowBtn.selected=NO;
        FevoriteSongBtn.selected=NO;
        FevoriteStationBtn.selected=NO;
        StationHistoryBtn.selected=NO;
        RateUsBtn.selected=NO;
        HelpBtn.selected=NO;
        SongHistoryBtn.selected=NO;
    }
    RevealController *revealController = [self.parentViewController isKindOfClass :[RevealController class]] ? (RevealController *)self.parentViewController : nil;
    if ([revealController.frontViewController isKindOfClass :[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass :[PremimumeViewController class]])
    {
        PremimumeViewController *Prem=[[PremimumeViewController alloc] init];
        
        UINavigationController *Nav = [[UINavigationController alloc] initWithRootViewController:Prem];
        [revealController setFrontViewController:Nav animated:NO];
    }
    else
    {
        [revealController revealToggle:self];
    }
}
- (IBAction)TopShowsClicked:(id)sender
{
    if ([TopShowBtn isSelected])
    {
        TopShowBtn.selected=NO;
    }
    else
    {
        TopShowBtn.selected=YES;
        
        PremimumeBtn.selected=NO;
        LocalRadioBtn.selected=NO;
        SuggestionBtn.selected=NO;
        TopSongsBtn.selected=NO;
        SearchBtn.selected=NO;
        HomeBtn.selected=NO;

        FevoriteSongBtn.selected=NO;
        FevoriteStationBtn.selected=NO;
        StationHistoryBtn.selected=NO;
        RateUsBtn.selected=NO;
        HelpBtn.selected=NO;
        SongHistoryBtn.selected=NO;
    }
    RevealController *revealController = [self.parentViewController isKindOfClass :[RevealController class]] ? (RevealController *)self.parentViewController : nil;
    if ([revealController.frontViewController isKindOfClass :[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass :[TalkShowsViewController class]])
    {
        TalkShowsViewController *Talk = [[TalkShowsViewController alloc] init] ;
        UINavigationController *Nav = [[UINavigationController alloc] initWithRootViewController:Talk];
        [revealController setFrontViewController:Nav animated:NO];
    }
    else
    {
        [revealController revealToggle:self];
    }
}
- (IBAction)FavoriteSongClicked:(id)sender
{
    if ([FevoriteSongBtn isSelected])
    {
        FevoriteSongBtn.selected=NO;
    }
    else
    {
        FevoriteSongBtn.selected=YES;
        TopShowBtn.selected=NO;
        
        PremimumeBtn.selected=NO;
        LocalRadioBtn.selected=NO;
        SuggestionBtn.selected=NO;
        TopSongsBtn.selected=NO;
        SearchBtn.selected=NO;
        HomeBtn.selected=NO;
        

        FevoriteStationBtn.selected=NO;
        StationHistoryBtn.selected=NO;
        RateUsBtn.selected=NO;
        HelpBtn.selected=NO;
        SongHistoryBtn.selected=NO;
    }
    RevealController *revealController = [self.parentViewController isKindOfClass :[RevealController class]] ? (RevealController *)self.parentViewController : nil;
    if ([revealController.frontViewController isKindOfClass :[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass :[FevoriteSongViewController class]])
    {
        FevoriteSongViewController *FevSong = [[FevoriteSongViewController alloc] init] ;
        UINavigationController *Nav = [[UINavigationController alloc] initWithRootViewController:FevSong];
        [revealController setFrontViewController:Nav animated:NO];
    }
    else
    {
        [revealController revealToggle:self];
    }
}
- (IBAction)FevoriteStationClicked:(id)sender
{
    if ([FevoriteStationBtn isSelected])
    {
        FevoriteStationBtn.selected=NO;
    }
    else
    {
        FevoriteStationBtn.selected=YES;
        FevoriteSongBtn.selected=NO;
        TopShowBtn.selected=NO;
        
        PremimumeBtn.selected=NO;
        LocalRadioBtn.selected=NO;
        SuggestionBtn.selected=NO;
        TopSongsBtn.selected=NO;
        SearchBtn.selected=NO;
        HomeBtn.selected=NO;
        
        StationHistoryBtn.selected=NO;
        RateUsBtn.selected=NO;
        HelpBtn.selected=NO;
        SongHistoryBtn.selected=NO;
    }
    RevealController *revealController = [self.parentViewController isKindOfClass :[RevealController class]] ? (RevealController *)self.parentViewController : nil;
    if ([revealController.frontViewController isKindOfClass :[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass :[FevoriteStationViewController class]])
    {
        FevoriteStationViewController *FevStation = [[FevoriteStationViewController alloc] init] ;
        UINavigationController *Nav = [[UINavigationController alloc] initWithRootViewController:FevStation];
        [revealController setFrontViewController:Nav animated:NO];
    }
    else
    {
        [revealController revealToggle:self];
    }
}
- (IBAction)StationHistoryClicked:(id)sender
{
    if ([StationHistoryBtn isSelected])
    {
        StationHistoryBtn.selected=NO;
    }
    else
    {
        StationHistoryBtn.selected=YES;
        
        FevoriteStationBtn.selected=NO;
        FevoriteSongBtn.selected=NO;
        TopShowBtn.selected=NO;
        
        PremimumeBtn.selected=NO;
        LocalRadioBtn.selected=NO;
        SuggestionBtn.selected=NO;
        TopSongsBtn.selected=NO;
        SearchBtn.selected=NO;
        HomeBtn.selected=NO;
        
        RateUsBtn.selected=NO;
        HelpBtn.selected=NO;
        SongHistoryBtn.selected=NO;
    }
    RevealController *revealController = [self.parentViewController isKindOfClass :[RevealController class]] ? (RevealController *)self.parentViewController : nil;
    if ([revealController.frontViewController isKindOfClass :[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass :[HistoryStationViewController class]])
    {
        HistoryStationViewController *HistoryStation = [[HistoryStationViewController alloc] init] ;
        UINavigationController *Nav = [[UINavigationController alloc] initWithRootViewController:HistoryStation];
        [revealController setFrontViewController:Nav animated:NO];
    }
    else
    {
        [revealController revealToggle:self];
    }
}
- (IBAction)RateUsClicked:(id)sender
{
    if ([RateUsBtn isSelected])
    {
        RateUsBtn.selected=NO;
    }
    else
    {
        RateUsBtn.selected=YES;
        StationHistoryBtn.selected=NO;
        
        FevoriteStationBtn.selected=NO;
        FevoriteSongBtn.selected=NO;
        TopShowBtn.selected=NO;
        
        PremimumeBtn.selected=NO;
        LocalRadioBtn.selected=NO;
        SuggestionBtn.selected=NO;
        TopSongsBtn.selected=NO;
        SearchBtn.selected=NO;
        HomeBtn.selected=NO;
        
        HelpBtn.selected=NO;
        SongHistoryBtn.selected=NO;
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=995073942&onlyLatestVersion=false&type=Purple+Software"]];
    
    //https://itunes.apple.com/us/app/jukebox-on-demand-songs-talk/id995073942?mt=8&ign-mpt=uo%3D2
   
}
- (IBAction)HelpClicked:(id)sender
{
    if ([HelpBtn isSelected])
    {
        HelpBtn.selected=NO;
    }
    else
    {
        HelpBtn.selected=YES;

        
        RateUsBtn.selected=NO;
        StationHistoryBtn.selected=NO;
        
        FevoriteStationBtn.selected=NO;
        FevoriteSongBtn.selected=NO;
        TopShowBtn.selected=NO;
        
        PremimumeBtn.selected=NO;
        LocalRadioBtn.selected=NO;
        SuggestionBtn.selected=NO;
        TopSongsBtn.selected=NO;
        SearchBtn.selected=NO;
        HomeBtn.selected=NO;
        
        SongHistoryBtn.selected=NO;
    }
}
- (IBAction)SongHistoryClicked:(id)sender
{
    if ([SongHistoryBtn isSelected])
    {
        SongHistoryBtn.selected=NO;
    }
    else
    {
        SongHistoryBtn.selected=YES;
        
        RateUsBtn.selected=NO;
        StationHistoryBtn.selected=NO;
        
        FevoriteStationBtn.selected=NO;
        FevoriteSongBtn.selected=NO;
        TopShowBtn.selected=NO;
        
        PremimumeBtn.selected=NO;
        LocalRadioBtn.selected=NO;
        SuggestionBtn.selected=NO;
        TopSongsBtn.selected=NO;
        SearchBtn.selected=NO;
        HomeBtn.selected=NO;
    }
    RevealController *revealController = [self.parentViewController isKindOfClass :[RevealController class]] ? (RevealController *)self.parentViewController : nil;
    if ([revealController.frontViewController isKindOfClass :[UINavigationController class]] && ![((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass :[HistorySongViewController class]])
    {
        HistorySongViewController *HistorySong = [[HistorySongViewController alloc] init] ;
        UINavigationController *Nav = [[UINavigationController alloc] initWithRootViewController:HistorySong];
        [revealController setFrontViewController:Nav animated:NO];
    }
    else
    {
        [revealController revealToggle:self];
    }
}
@end
