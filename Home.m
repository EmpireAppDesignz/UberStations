//
//  Home.m
//  JukeBox
//
//  Created by Eric Rosas on 4/13/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import "Home.h"

@interface Home ()

@end

@implementation Home
@synthesize slidermenu;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"Your App Name Here";
    if ([self.navigationController.parentViewController respondsToSelector:@selector(revealGesture:)] &&
        [self.navigationController.parentViewController respondsToSelector:@selector(revealToggle:)])
    {
        UIPanGestureRecognizer *navigationBarPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController action:@selector(revealGesture:)];
        [self.navigationController.navigationBar addGestureRecognizer:navigationBarPanGestureRecognizer];
        
        UIImage *buttonImage = [UIImage imageNamed:@"SliderButton.png"];
        UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [aButton setImage:buttonImage forState:UIControlStateNormal];
        aButton.frame = CGRectMake(0.0, 0.0, 20,20);
        UIBarButtonItem *aBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aButton];
        [aButton addTarget:self.navigationController.parentViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = aBarButtonItem;
        
//        NSDate *CurrentDate=[NSDate date];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MMMM dd, yyyy"];
        
        NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
        [timeFormat setDateFormat:@"HH:mm a"];
        
        NSDateFormatter *DayFormat = [[NSDateFormatter alloc] init];
        [DayFormat setDateFormat:@"cccc"];
        
        NSDate *now = [[NSDate alloc] init];
        
        NSString *theDate = [dateFormat stringFromDate:now];
        NSString *theTime = [timeFormat stringFromDate:now];
        NSString *TheDay=   [DayFormat stringFromDate:now];
        
        TimeLbl.text=theTime;
        DateLbl.text=theDate;
        DayLbl.text=TheDay;
        
        NSLog(@"\n"
              "theDate: |%@| \n"
              "theTime: |%@| \n"
              , theDate, theTime);
        
    }
      [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]}];
    if (floor(NSFoundationVersionNumber)<=NSFoundationVersionNumber_iOS_6_1)
    {
        [self.navigationController.navigationBar setBackgroundImage :[UIImage imageNamed: @"Nav.png"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage :[UIImage imageNamed: @"Nav.png"] forBarMetrics:UIBarMetricsDefault];
    }
    [self Database];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //Ask for Rating
    BOOL neverRate = [prefs boolForKey:@"neverRate"];
    
    int newCount = 0;
    //Get the number of launches
    newCount = [prefs integerForKey:@"newCount"];
    newCount++;
    
    [[NSUserDefaults standardUserDefaults] setInteger:newCount forKey:@"newCount"];
    
    if (!neverRate)
    {
        if ( (newCount == 2) || (newCount == 4) || (newCount == 6) || (newCount == 8) || (newCount == 10) || (newCount == 12) || (newCount == 14) || (newCount == 16) || (newCount == 18) || (newCount == 20) || (newCount == 22) || (newCount == 24) || (newCount == 26) || (newCount == 28) || (newCount == 30) || (newCount == 32) || (newCount == 34) || (newCount == 36) || (newCount == 38) || (newCount == 40) || (newCount == 42) || (newCount == 44) || (newCount == 46) || (newCount == 48) || (newCount == 50) || (newCount == 52) || (newCount == 54) || (newCount == 56) || (newCount == 58) || (newCount == 60) || (newCount == 80) || (newCount == 90) || (newCount == 100) || (newCount == 120) || (newCount == 130) || (newCount == 140) || (newCount == 150) || (newCount == 160) || (newCount == 180) || (newCount == 200))
        {
            [self rateApp];
        }
    }
    [prefs synchronize];
    
}

- (void)rateApp {
    BOOL neverRate = [[NSUserDefaults standardUserDefaults] boolForKey:@"neverRate"];
    
    if (neverRate != YES) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Do you like?"
                                                        message:@"If you enjoy using this app, would you mind rating it? Thank You for your support!"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Rate this App", @"Remind Me Later", @"No, Thanks", nil];
        alert.delegate = self;
        [alert show];
    }
}

//Beginning Rate Section

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"neverRate"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=995073942&onlyLatestVersion=false&type=Purple+Software"]]];
        
    }
    
    else if (buttonIndex == 1) {
        
    }
    
    else if (buttonIndex == 2) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"neverRate"];
    }
}
//end of rate section

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)HistorySongClick:(id)sender
{
    HistorySongViewController *History=[[HistorySongViewController alloc] init];
    [self.navigationController pushViewController:History animated:YES];
}
- (IBAction)FevoritesClick:(id)sender
{
    FevoriteSongViewController *FevSong=[[FevoriteSongViewController alloc] init];
    [self.navigationController pushViewController:FevSong animated:YES];
}
- (IBAction)TopSongClicked:(id)sender
{
    TopSongViewController *Top=[[TopSongViewController alloc] init];
    [self.navigationController pushViewController:Top animated:YES];
}
- (IBAction)NearByClicked:(id)sender
{
    LocalRadioViewController *Local=[[LocalRadioViewController alloc] init];
    [self.navigationController pushViewController:Local animated:YES];
}
- (IBAction)SuggestionClick:(id)sender
{
    SuggestionViewController *Sugg=[[SuggestionViewController alloc] init];
    [self.navigationController pushViewController:Sugg animated:YES];
}
- (IBAction)PremimumeClick:(id)sender
{
    PremimumeViewController *premi=[[PremimumeViewController alloc] init];
    [self.navigationController pushViewController:premi animated:YES];
}
#pragma mark FM DB Codes
-(void)Database
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",documentsDirectory,@"dbJukeBox.db"];
    db = [FMDatabase databaseWithPath:filePath];
    
    NSLog(@"Path is:%@",filePath);
    
    if (![db open])
    {
//        [db release];
        return;
    }
    else
    {
        if (![db tableExists:@"FevoriteSong"])
        {
            [db executeUpdate:@"create table FevoriteSong(id integer primary key,titlename text,subtitlename text,songurl Text,songid integer)"];
        }
        if (![db tableExists:@"FevoriteStation"])
        {
            [db executeUpdate:@"create table FevoriteStation(id integer primary key,titlename text,subtitlename text,stationurl text,stationid integer,stationimageurl text)"];
        }
        if (![db tableExists:@"SongHistory"])
        {
            [db executeUpdate:@"create table SongHistory(id integer primary key,titlename text,subtitlename text,songurl Text,songid integer)"];
        }
        if (![db tableExists:@"StationHistory"])
        {
            [db executeUpdate:@"create table StationHistory(id integer primary key,titlename text,subtitlename text,stationurl text,stationid integer,stationimageurl Text)"];
        }//stationimageurl,stationid
    }
//    [db retain];
}
@end
