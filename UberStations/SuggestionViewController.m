//
//  SuggestionViewController.m
//  JukeBox
//
//  Created by Eric Rosas on 5/7/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import "SuggestionViewController.h"

@interface SuggestionViewController ()

@end
@implementation SuggestionViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    Suggestview.hidden=YES;
    Mal=0;

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
        //Add Genres Buttons
        //        UIImage *GenreImage = [UIImage imageNamed:@"SliderButton.png"];
        UIImage *SuggestImage = [UIImage imageNamed:@"SuggestBtn.png"];
        SuggestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [SuggestBtn setImage:SuggestImage forState:UIControlStateNormal];
        SuggestBtn.frame = CGRectMake(0, 0.0, 35,25);
//        [GenresBtn.titleLabel setTextAlignment:UITextAlignmentRight];
        UIBarButtonItem *GenresButtonItem = [[UIBarButtonItem alloc] initWithCustomView:SuggestBtn];
        [SuggestBtn addTarget:self action:@selector(GenresCliecked:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = GenresButtonItem;
    }
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]}];
    self.title=@"Suggestions";
    if (floor(NSFoundationVersionNumber)<=NSFoundationVersionNumber_iOS_6_1)
    {
        [self.navigationController.navigationBar setBackgroundImage :[UIImage imageNamed: @"Nav.png"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage :[UIImage imageNamed: @"Nav.png"] forBarMetrics:UIBarMetricsDefault];
    }
    //http://api.dar.fm/reco2.php?artist=abc&partner_token=2787730925&callback=json
}
-(void)ServicePass
{
    NSString *Track=[NSString stringWithFormat:@"http://api.dar.fm/reco2.php?artist=%@&partner_token=2787730925&callback=json",SuggestSearchbar.text];
    encodeing=[[NSString alloc]init];
    encodeing =[Track stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    url = [NSURL URLWithString:encodeing];
    self.GetSongRequest = [ASIHTTPRequest requestWithURL:url];
    [self.GetSongRequest setTimeOutSeconds:60];
    [self.GetSongRequest setDelegate:self];
    [self.GetSongRequest startAsynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    SuggestionArray =[[NSMutableArray alloc] init];
    if (request==self.GetSongRequest)
    {
        NSDictionary  *SongDic= [request.responseString JSONValue];
        NSMutableArray *AllData=[SongDic objectForKey:@"result"];
        
        for (NSMutableDictionary *Dics in AllData)
        {
            GetData *Data=[[GetData alloc] init];
            Data.Suggestions_songartistStr=[Dics objectForKey:@"songartist"];
            Data.Suggestions_songtitleStr=[Dics  objectForKey:@"songtitle"];
            Data.Suggestions_currently_playingStr=[Dics  objectForKey:@"currently_playing"];
            Data.Suggestions_callsignStr=[Dics  objectForKey:@"callsign"];
            Data.Suggestions_station_idInt=[Dics  objectForKey:@"station_id"];
            Data.Suggestions_genreStr=[[Dics objectForKey:@"playlist"] objectForKey:@"genre"];
            Data.Suggestions_artistStr=[[Dics objectForKey:@"playlist"] objectForKey:@"artist"];
            Data.Suggestions_titleStr=[[Dics objectForKey:@"playlist"] objectForKey:@"title"];
            Data.Suggestions_songstampStr=[[Dics objectForKey:@"playlist"] objectForKey :@"songstamp"];
            Data.Suggestions_seconds_remainingStr=[[Dics objectForKey:@"playlist"] objectForKey:@"seconds_remaining"];
            Data.Suggestions_uberurlStr=[[Dics objectForKey:@"uberurl"] objectForKey:@"url"];
            Data.Suggestions_uberurlwebsiteurlStr=[[Dics objectForKey:@"uberurl"] objectForKey:@"websiteurl"];
            
            [SuggestionArray addObject:Data];
            NSLog(@"Data is:%@",Data.Suggestions_uberurlStr);
        }
    }
    NSLog(@"Top Song Array is :%@",SuggestionArray);
    [SuggestTbl reloadData];
//    [HUD hide:YES];
}
-(IBAction)GenresCliecked:(id)sender
{
    SuggestSearchbar.text=@"";
    if (Mal==0)
    {
        Suggestview.hidden=NO;
        Mal=1;
    }
    else
    {
        Suggestview.hidden=YES;
        Mal=0;
    }
    
}
#pragma mark Table Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return SuggestionArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetData *Data =[SuggestionArray objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = Data.Suggestions_songtitleStr;
    cell.detailTextLabel.text=Data.Suggestions_songartistStr;
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    path=indexPath.row;
    //[self PlaySong];
    //    [self playSongsByNilesh];
    
    GetData *Data=[SuggestionArray objectAtIndex:path];
    
    app=[[UIApplication sharedApplication] delegate];
    app.bottomplayerview.currentSongIndex=0;
    app.bottomplayerview.currentSongsNameArray=Data.Suggestions_songtitleStr;
    app.bottomplayerview.currentSongsURLArray=Data.Suggestions_uberurlStr;
    app.bottomplayerview.currentSongsIdArray=Data.Suggestions_station_idInt;
    NSString *TempImg=@"Icon-40.png";
    app.bottomplayerview.ImageUrlStr=TempImg;
    app.bottomplayerview.SongSubName=Data.Suggestions_genreStr;
    app.bottomplayerview.typestr=@"Song";
    NSLog(@"Type is:%@",app.bottomplayerview.typestr);
    app.bottomplayerview.isRadio=NO;
    [app.bottomplayerview startPlaying];
    
    
    if ([app.bottomplayerview.PlayerShowStr isEqualToString:@"Yes"])
    {
        if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            SuggestTbl.frame=CGRectMake(0, 46, 320, 485);
        }
        else
        {
            SuggestTbl.frame=CGRectMake(0, 46, 320, 395);
        }
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    app=[[UIApplication sharedApplication] delegate];
    if ([app.bottomplayerview.PlayerShowStr isEqualToString:@"Yes"])
    {
        if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            SuggestTbl.frame=CGRectMake(0, 46, 320, 485);
        }
        else
        {
            SuggestTbl.frame=CGRectMake(0, 46, 320, 395);
        }
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch =[touches anyObject];
    if (touch.phase ==UITouchPhaseBegan)
    {
        UITouch *touchs = [[event allTouches] anyObject];
        if ([touchs view] == self.view)
        {
            NSLog(@"Ok");
            [SuggestSearchbar resignFirstResponder];
        }
        else
        {
            NSLog(@"CANCEL");
        }
        [self.view endEditing:YES];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // [TitleOfPosting resignFirstResponder];
    [textField resignFirstResponder];
//      [self.view endEditing:YES];
    return YES;
    // Do the search...
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)SuggestClick:(id)sender
{
    [self ServicePass];
    Suggestview.hidden=YES;
    Mal=0;
}
@end
