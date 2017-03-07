//
//  StationListViewController.m
//  JukeBox
//
//  Created by Eric Rosas on 4/13/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//


#import "StationListViewController.h"

@interface StationListViewController ()

@end

@implementation StationListViewController
@synthesize StationPeramStr;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Call Sign Is:%@",StationPeramStr);
    
//    [[self.navigationController.navigationBar.subviews lastObject] setTintColor:[UIColor whiteColor]];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    //set back button arrow color
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.title=@"Stations";
    [self GetStation];
}
-(void)GetStation
{
    //http://api.dar.fm/uberstationurl.php?callsign=KKFN&partner_token=2787730925&callback=json
    NSString *Track=[NSString stringWithFormat:@"http://api.dar.fm/playlist.php?q=%@&callback=json",StationPeramStr];
    encodeing=[[NSString alloc]init];
    encodeing =[Track stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    url = [NSURL URLWithString:encodeing];
    self.GetStationRequest = [ASIHTTPRequest requestWithURL:url];
    [self.GetStationRequest setTimeOutSeconds:60];
    [self.GetStationRequest setDelegate:self];
    [self.GetStationRequest startAsynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    if (request==self.GetStationRequest)
    {
        StationArray =[[NSMutableArray alloc] init];

        NSDictionary  *SongDic= [request.responseString JSONValue];
        NSMutableArray *AllData=[SongDic objectForKey:@"result"];
        
        for (NSMutableDictionary *Dics in AllData)
        {
            GetData *Data=[[GetData alloc] init];
            /*TopStation_songartistStr;
             TopStation_songtitleStr;
             TopStation_seconds_remaining;
             TopStation_callsignStr;
             *TopStation_station_idInt;
             TopStation_genreStr;*/
            
            Data.TopStation_songartistStr=[Dics objectForKey:@"artist"];
            Data.TopStation_songtitleStr=[Dics objectForKey:@"title"];
            Data.TopStation_seconds_remaining=[Dics objectForKey:@"seconds_remaining"];
            Data.TopStation_station_idInt=[Dics objectForKey:@"station_id"];
            Data.TopStation_genreStr=[Dics objectForKey:@"genre"];
            Data.TopStation_callsignStr=[Dics objectForKey:@"callsign"];
            
           /* Data.Station_StationurlStr=[Dics objectForKey:@"url"];
            Data.Station_StationencodingStr=[Dics objectForKey:@"encoding"];
            Data.Station_callsign=[Dics objectForKey:@"callsign"];
            Data.Station_websiteurl=[Dics objectForKey:@"websiteurl"];
            Data.Station_station_id=[[Dics objectForKey:@"station_id"] intValue];*/
            
            
            
            [StationArray addObject:Data];
        }
        NSLog(@"Top Song Array is :%@",StationArray);
        [StationTable reloadData];
    }
   else if (request==self.PlayStationRequest)
    {
        PlayStationArray=[[NSMutableArray alloc] init];
        
        NSDictionary  *StationDic= [request.responseString JSONValue];
        NSMutableArray *StationAllData=[StationDic objectForKey:@"result"];
        
        for (NSMutableDictionary *Dics in StationAllData)
        {
            GetData *Data=[[GetData alloc] init];
            
            Data.Station_StationurlStr=[Dics objectForKey:@"url"];
            Data.Station_StationencodingStr=[Dics objectForKey:@"encoding"];
            Data.Station_callsign=[Dics objectForKey:@"callsign"];
            Data.Station_websiteurl=[Dics objectForKey:@"websiteurl"];
            Data.Station_station_id=[Dics objectForKey:@"station_id"];
            
            [PlayStationArray addObject:Data];
        }
        [self PlayStation];
    }
    [HUD hide:YES];
}
#pragma mark Tableview Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return StationArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetData *Data =[StationArray objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = Data.TopStation_callsignStr;
    cell.detailTextLabel.text=Data.TopStation_genreStr;
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
    
    [self PlayUrlServicePass];
    
}
-(void)PlayUrlServicePass
{
    GetData *Data=[StationArray objectAtIndex:path];
    NSString *ServiceField= Data.TopStation_callsignStr;
    
    NSString *Track=[NSString stringWithFormat:@"http://api.dar.fm/uberstationurl.php?callsign=%@&partner_token=2787730925&callback=json",ServiceField];
    Playencodeing=[[NSString alloc]init];
    Playencodeing =[Track stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    Playurl = [NSURL URLWithString:Playencodeing];
    self.PlayStationRequest = [ASIHTTPRequest requestWithURL:Playurl];
    [self.PlayStationRequest setTimeOutSeconds:60];
    [self.PlayStationRequest setDelegate:self];
    [self.PlayStationRequest startAsynchronous];
}
-(void)PlayStation
{
    GetData *Data1=[PlayStationArray objectAtIndex:0];
    
//    resourcePath =Data.Station_StationurlStr;
//    NSMutableArray *Temp=[[NSMutableArray alloc] init];
//    [Temp addObject:resourcePath];
    
    app=[[UIApplication sharedApplication] delegate];
    app.bottomplayerview.currentSongIndex=0;
    app.bottomplayerview.currentSongsNameArray=Data1.Station_callsign;
    app.bottomplayerview.currentSongsURLArray=Data1.Station_StationurlStr;
    app.bottomplayerview.currentSongsIdArray=Data1.Station_station_id;
    NSString *TempImg=@"Icon-40.png";
    app.bottomplayerview.ImageUrlStr=TempImg;
    app.bottomplayerview.SongSubName=Data1.Station_StationencodingStr;
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
            StationTable.frame=CGRectMake(0, 46, 320, 485);
        }
        else
        {
            StationTable.frame=CGRectMake(0, 46, 320, 395);
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
            StationTable.frame=CGRectMake(0, 46, 320, 485);
        }
        else
        {
            StationTable.frame=CGRectMake(0, 46, 320, 395);
        }
    }
    //    self.PlayerShowStr=@"Yes";
}
/*-(void) playSongsByNilesh
{
    GetData *Data=[StationArray objectAtIndex:path];
    
    resourcePath =Data.Station_StationurlStr;
    NSLog(@"url is : %@",resourcePath);
    
    NSData *_objectData = [NSData dataWithContentsOfURL:[NSURL URLWithString:resourcePath]];
    NSError *error;
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithData:_objectData error:&error];
    self.audioPlayer.numberOfLoops = 0;
    self.audioPlayer.volume = 1.0f;
    [self.audioPlayer prepareToPlay];
    
    if (self.audioPlayer == nil)
        NSLog(@"%@", [error description]);
    else
        [self.audioPlayer play];
}
-(void)viewWillAppear:(BOOL)animated
{
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
            StationTable.frame=CGRectMake(0, 46, 320, 485);
        }
        else
        {
            StationTable.frame=CGRectMake(0, 46, 320, 395);
        }
    }
    //    self.PlayerShowStr=@"Yes";
}*/
-(void)PlaySong
{
     GetData *Data=[StationArray objectAtIndex:path];
    
    resourcePath =Data.Station_StationurlStr; //your url
    
   /*  NSString* encodedUrl = [resourcePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [[NSURL alloc]initWithString:encodedUrl];
    NSError *error;
    audioPlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:url1 error:&error];
    audioPlayer.delegate = self;
//    [url release];
    
    [audioPlayer prepareToPlay];
    [audioPlayer play];*/
    
   /* NSString* encodedUrl=[NSString stringWithFormat:@"%@.mp3",resourcePath];
    
    NSURL *url1 = [[NSURL alloc]initWithString:encodedUrl];
      NSError *error;
    AVAudioPlayer  *audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:url1 error:&error];
    audioPlayer=audioPlayer1;
    
    audioPlayer.delegate = self;
    
    [audioPlayer prepareToPlay];
    [audioPlayer play];*/
    
//    AVAsset *avAsset;
//    AVPlayerItem *avPlayerItem;
//    AVPlayer *avPlayer;
//    AVPlayerLayer *avPlayerLayer;
//    
//    avAsset = [AVAsset assetWithURL:[NSURL URLWithString:resourcePath]];
//    avPlayerItem =[[AVPlayerItem alloc]initWithAsset:avAsset];
//    avPlayer = [[AVPlayer alloc]initWithPlayerItem:avPlayerItem];
//    avPlayerLayer =[AVPlayerLayer playerLayerWithPlayer:avPlayer];
//    [avPlayerLayer setFrame:self.view.frame];
//    [self.view.layer addSublayer:avPlayerLayer];
//    //[avPlayerLayer setBackgroundColor:[[UIColor redColor]CGColor]];
//    [avPlayer seekToTime:kCMTimeZero];
//    [avPlayer play];
    
//    [self playselectedsong];
    
}
/*-(void)playselectedsong
{
    
    AVPlayer *player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:resourcePath]];
    self.songPlayer = player;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[_songPlayer currentItem]];
    [self.songPlayer addObserver:self forKeyPath:@"status" options:0 context:nil];
//    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == self.songPlayer && [keyPath isEqualToString:@"status"]) {
        if (self.songPlayer.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayer Failed");
            
        } else if (self.songPlayer.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            [self.songPlayer play];
        } else if (self.songPlayer.status == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
        }
    }
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    
    //  code here to play next sound file
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}*/
@end
