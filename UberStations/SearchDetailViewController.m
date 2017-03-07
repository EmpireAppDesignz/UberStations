//
//  SearchDetailViewController.m
//  JukeBox
//
//  Created by Eric Rosas on 4/29/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import "SearchDetailViewController.h"

@interface SearchDetailViewController ()

@end

@implementation SearchDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GetDataArray=[[NSMutableArray alloc] init];
    
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
        
        //        //Add Genres Buttons
        //        //        UIImage *GenreImage = [UIImage imageNamed:@"SliderButton.png"];
        //        GenresBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [GenresBtn setTitle:@"Genres" forState:UIControlStateNormal];
        //        //        [GenresBtn setImage:buttonImage forState:UIControlStateNormal];
        //        [GenresBtn setFont:[UIFont systemFontOfSize:15]];
        //        GenresBtn.frame = CGRectMake(300, 0.0, 50,30);
        //        [GenresBtn.titleLabel setTextAlignment:UITextAlignmentRight];
        //        UIBarButtonItem *GenresButtonItem = [[UIBarButtonItem alloc] initWithCustomView:GenresBtn];
        //        [GenresBtn addTarget:self action:@selector(GenresCliecked:) forControlEvents:UIControlEventTouchUpInside];
        //        self.navigationItem.rightBarButtonItem = GenresButtonItem;
    }
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]}];
    self.title=self.ServicePeram;
    if (floor(NSFoundationVersionNumber)<=NSFoundationVersionNumber_iOS_6_1)
    {
        [self.navigationController.navigationBar setBackgroundImage :[UIImage imageNamed: @"Nav.png"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage :[UIImage imageNamed: @"Nav.png"] forBarMetrics:UIBarMetricsDefault];
    }
    [self GetData];
}
-(void)GetData
{
    NSString *GetStream=[NSString stringWithFormat:@"http://api.dar.fm/playlist.php?q=@callsign %@&callback=json",self.ServicePeram];
    SearchEncodingStr=[[NSString alloc]init];
    SearchEncodingStr =[GetStream stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    url = [NSURL URLWithString:SearchEncodingStr];
    self.GetDataRequest = [ASIHTTPRequest requestWithURL:url];
    [self.GetDataRequest setTimeOutSeconds:60];
    [self.GetDataRequest setDelegate:self];
    [self.GetDataRequest startAsynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    if (request ==self.GetDataRequest)
    {
        NSDictionary  *SearchDics= [request.responseString JSONValue];
        NSMutableArray *AllData=[SearchDics objectForKey:@"result"];
        
        for (NSMutableDictionary *Dics in AllData)
        {
            GetData *Data=[[GetData alloc] init];
            Data.DetailSearch_callsignStr=[Dics objectForKey:@"callsign"];
            Data.DetailSearch_genreStr=[Dics objectForKey:@"genre"];
            Data.DetailSearch_artistStr=[Dics objectForKey:@"artist"];
            Data.DetailSearch_titleStr=[Dics objectForKey:@"title"];
            Data.DetailSearch_songstampStr=[Dics objectForKey:@"songstamp"];
            Data.DetailSearch_seconds_remainingStr=[Dics objectForKey:@"seconds_remaining"];
            Data.DetailSearch_station_idStr=[Dics objectForKey:@"station_id"];
            [GetDataArray addObject:Data];
        }
        [DataTable reloadData];
    }
    else if (request==self.GetUrlRequest)
    {
        GetUrlArray=[[NSMutableArray alloc] init];
        NSDictionary  *SongDic= [request.responseString JSONValue];
        NSMutableArray *AllData=[SongDic objectForKey:@"result"];
        
        for (NSMutableDictionary *Dics in AllData)
        {
            GetData *Data=[[GetData alloc] init];
            
            Data.Search_Station_StationurlStr=[Dics objectForKey:@"url"];
            Data.Search_Station_StationencodingStr=[Dics objectForKey:@"encoding"];
            Data.Search_Station_callsign=[Dics objectForKey:@"callsign"];
            Data.Search_Station_websiteurl=[Dics objectForKey:@"websiteurl"];
            Data.Search_Station_station_id=[Dics objectForKey:@"station_id"];
            
            [GetUrlArray addObject:Data];
            NSLog(@"Name Is:%@",Data.Search_Station_callsign);

            [self PlaySong];
        }
    }
}
#pragma mark table delegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return GetDataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetData *Data =[GetDataArray objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"Cell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=Data.DetailSearch_callsignStr;
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetData *Data =[GetDataArray objectAtIndex:indexPath.row];
   NSLog(@"Id Str is:%@",Data.DetailSearch_station_idStr);
    SecondServiceStr=Data.DetailSearch_station_idStr;
    Path=indexPath.row;
    [self GateUrlService];
}
-(void)GateUrlService
{
    NSString *GetStream=[NSString stringWithFormat:@"http://api.dar.fm/uberstationurl.php?station_id=%@&partner_token=2787730925&callback=json",SecondServiceStr];
    GetUrlStr=[[NSString alloc]init];
    GetUrlStr =[GetStream stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    GetUrl = [NSURL URLWithString:GetUrlStr];
    self.GetUrlRequest = [ASIHTTPRequest requestWithURL:GetUrl];
    [self.GetUrlRequest setTimeOutSeconds:60];
    [self.GetUrlRequest setDelegate:self];
    [self.GetUrlRequest startAsynchronous];
}
-(void)PlaySong
{
    GetData *Data =[GetUrlArray objectAtIndex:0];
    app=[[UIApplication sharedApplication] delegate];
    app.bottomplayerview.currentSongIndex=0;
    NSLog(@"Name Is:%@",Data.Search_Station_callsign);
    app.bottomplayerview.currentSongsNameArray=Data.Search_Station_callsign;
    app.bottomplayerview.currentSongsURLArray=Data.Search_Station_StationurlStr;
    app.bottomplayerview.currentSongsIdArray=Data.Search_Station_station_id;
    NSString *TempImg=@"Icon-40.png";
    app.bottomplayerview.ImageUrlStr=TempImg;
    app.bottomplayerview.SongSubName=Data.Search_Station_StationencodingStr;
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
            DataTable.frame=CGRectMake(0, 46, 320, 485);
        }
        else
        {
            DataTable.frame=CGRectMake(0, 46, 320, 395);
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
            DataTable.frame=CGRectMake(0, 46, 320, 485);
        }
        else
        {
            DataTable.frame=CGRectMake(0, 46, 320, 395);
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
