//
//  LocalRadioViewController.m
//  JukeBox
//
//  Created by Eric Rosas on 4/16/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import "LocalRadioViewController.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@interface LocalRadioViewController ()

@end

@implementation LocalRadioViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    NSString *str1=@"Data Loading";
    HUD.delegate = self;
    HUD.labelText = str1;
    HUD.detailsLabelText=@"Please Wait...";
    HUD.dimBackground = YES;
    [self.view addSubview:HUD];
    [HUD show:YES];
    
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
    self.title=@"Near By";
    if (floor(NSFoundationVersionNumber)<=NSFoundationVersionNumber_iOS_6_1)
    {
        [self.navigationController.navigationBar setBackgroundImage :[UIImage imageNamed: @"Nav.png"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage :[UIImage imageNamed: @"Nav.png"] forBarMetrics:UIBarMetricsDefault];
        
    }
    
    locationManagerApp=[[CLLocationManager alloc] init];
    
    locationManagerApp.delegate = self;
    locationManagerApp.distanceFilter = kCLDistanceFilterNone;
    locationManagerApp.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    if(IS_OS_8_OR_LATER)
    {
        [locationManagerApp requestAlwaysAuthorization];
        //[locationManagerApp requestWhenInUseAuthorization];
    }
    [locationManagerApp startUpdatingLocation];
    CLLocation *location1 = [locationManagerApp location];
    CLLocationCoordinate2D coordinate = [location1 coordinate];
    latValue= [NSString stringWithFormat:@"%f", coordinate.latitude];
    longValue = [NSString stringWithFormat:@"%f", coordinate.longitude];
    NSLog(@"Latitude  = %@",latValue);
    NSLog(@"Longitude = %@",longValue);
    
    latValue=@"32.89";
    longValue=@"-117.19";
    [self GetNearData];
}
-(void)GetNearData
{
    //api.dar.fm/darstations.php?latitude=32.89&longitude=-117.19&partner_token=123456789
    //http://api.dar.fm/uberguide.php?partner_token=2787730925&callback=json
    NSString *Track=[NSString stringWithFormat:@"http://api.dar.fm/darstations.php?latitude=%@&longitude=%@&partner_token=2787730925&callback=json",latValue,longValue];
    encodeing=[[NSString alloc]init];
    encodeing =[Track stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    url = [NSURL URLWithString:encodeing];
    self.GetNewarRequest = [ASIHTTPRequest requestWithURL:url];
    [self.GetNewarRequest setTimeOutSeconds:60];
    [self.GetNewarRequest setDelegate:self];
    [self.GetNewarRequest startAsynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    if (request==self.GetNewarRequest)
    {
        NearDataArray =[[NSMutableArray alloc] init];

        NSDictionary  *SongDic= [request.responseString JSONValue];
        NSMutableArray *AllData=[SongDic objectForKey:@"result"];
        NSMutableArray *Stationarray=[[AllData objectAtIndex:0] objectForKey:@"stations"];
        
        for (NSMutableDictionary *Dics in Stationarray)
        {
            GetData *Data=[[GetData alloc] init];
            
            Data.Near_band=[Dics objectForKey:@"band"];
            Data.Near_genre=[Dics  objectForKey:@"genre"];
            Data.Near_ubergenre=[Dics  objectForKey:@"ubergenre"];
            Data.Near_language=[Dics  objectForKey:@"language"];
            Data.Near_websiteurl=[Dics  objectForKey:@"websiteurl"];
            Data.Near_imageurl=[Dics  objectForKey:@"imageurl"];
            Data.Near_city=[Dics  objectForKey:@"city"];
            Data.Near_state=[Dics  objectForKey:@"state"];
            Data.Near_country=[Dics  objectForKey:@"country"];
            Data.Near_zipcode=[Dics  objectForKey:@"zipcode"];
            Data.Near_callsign=[Dics  objectForKey:@"callsign"];
            Data.Near_dial=[Dics  objectForKey:@"dial"];
            Data.Near_station_id=[Dics  objectForKey:@"station_id"];
            Data.Near_station_image=[Dics  objectForKey:@"station_image"];
            Data.Near_slogan=[Dics  objectForKey:@"slogan"];
                        
            [NearDataArray addObject:Data];
        }
        [NearTable reloadData];
        NSLog(@"Near Data Array is :%@",NearDataArray);
    }
    else if (request==self.GetNewarUrlRequest)
    {
        Near_StationArray =[[NSMutableArray alloc] init];
      
            NSDictionary  *NearDic= [request.responseString JSONValue];
            NSMutableArray *Near_AllData=[NearDic objectForKey:@"result"];
            
            for (NSMutableDictionary *Dics in Near_AllData)
            {
                GetData *Data=[[GetData alloc] init];
                
                Data.Near_Station_StationurlStr=[Dics objectForKey:@"url"];
                Data.Near_Station_StationencodingStr=[Dics objectForKey:@"encoding"];
                Data.Near_Station_callsign=[Dics objectForKey:@"callsign"];
                Data.Near_Station_websiteurl=[Dics objectForKey:@"websiteurl"];
                Data.Near_Station_station_id=[[Dics objectForKey:@"station_id"] intValue];
                
                [Near_StationArray addObject:Data];
                [self PlayUrl];
            }
        NSLog(@"Top Song Array is :%@",Near_StationArray);
    }
    [HUD hide:YES];
}
#pragma mark Tableview Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return NearDataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetData *Data =[NearDataArray objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"Cell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 280, 30.0)];
    [nameLabel setTag:1];
    [nameLabel setBackgroundColor:[UIColor clearColor]]; // transparent label background
    nameLabel.textColor=[UIColor whiteColor];
    [nameLabel setFont:[UIFont boldSystemFontOfSize:15]];
    nameLabel.text = Data.Near_slogan;
    // custom views should be added as subviews of the cell's contentView:
    [cell.contentView addSubview:nameLabel];
    
    UILabel *SubnameLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 20, 300.0, 30.0)];
    [SubnameLabel setTag:1];
    [nameLabel setBackgroundColor:[UIColor clearColor]]; // transparent label background
    SubnameLabel.textColor=[UIColor whiteColor];
    [SubnameLabel setFont:[UIFont boldSystemFontOfSize:10]];
    SubnameLabel.text = Data.Near_genre;//Near_genre
    // custom views should be added as subviews of the cell's contentView:
    [cell.contentView addSubview:SubnameLabel];
    
    FeedSearchUserImage=[[AsyncImageView alloc]initWithFrame:CGRectMake(5,8,35,35)];
    FeedSearchUserImage.image=[UIImage imageNamed:@"Icon-40.png"];
    FeedSearchUserImage.imageURL=[NSURL URLWithString:Data.Near_imageurl];
    FeedSearchUserImage.layer.cornerRadius = FeedSearchUserImage.frame.size.width / 2;
    FeedSearchUserImage.clipsToBounds = YES;
    [cell.contentView addSubview:FeedSearchUserImage];
    
    cell.backgroundColor=[UIColor clearColor];
    return cell;
    
    //http://api.dar.fm/uberurl.php?showinfo_id=RSS_24502&partner_token=2787730925&callback=json
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetData *Data=[NearDataArray objectAtIndex:indexPath.row];
    path=indexPath.row;
    ServicePeram=Data.Near_callsign;
    NSLog(@"Call Sign Is:%@",Data.Near_callsign);
    [self GetNearStationUrl];
}
-(void)GetNearStationUrl
{
    //http://api.dar.fm/uberstationurl.php?callsign=%@&partner_token=2787730925&callback=json
    NSString *GetStream=[NSString stringWithFormat:@"http://api.dar.fm/uberstationurl.php?callsign=%@&partner_token=2787730925&callback=json",ServicePeram];
    NearEncodeing=[[NSString alloc]init];
    NearEncodeing =[GetStream stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    url = [NSURL URLWithString:NearEncodeing];
    self.GetNewarUrlRequest = [ASIHTTPRequest requestWithURL:url];
    [self.GetNewarUrlRequest setTimeOutSeconds:60];
    [self.GetNewarUrlRequest setDelegate:self];
    [self.GetNewarUrlRequest startAsynchronous];
}
-(void)PlayUrl
{
    GetData *Data=[Near_StationArray objectAtIndex:0];
    GetData *Data1=[NearDataArray objectAtIndex:path];
    NSLog(@"Url Is:%@",Data.Near_Station_StationurlStr);
    NSLog(@"Url Is:%@",Data.Near_Station_websiteurl);
    NSLog(@"Name Is:%@",Data1.Near_slogan);
    NSLog(@"Data 1 Station Id Is:%@",Data1.Near_station_id);
    
    app=[[UIApplication sharedApplication] delegate];
    app.bottomplayerview.currentSongIndex=0;
    app.bottomplayerview.currentSongsURLArray=Data.Near_Station_StationurlStr;
    app.bottomplayerview.isRadio=NO;
    app.bottomplayerview.currentSongsNameArray=Data1.Near_slogan;
    app.bottomplayerview.ImageUrlStr=Data1.Near_imageurl;
    app.bottomplayerview.SongSubName=Data1.Near_genre;
    app.bottomplayerview.typestr=@"Station";
    app.bottomplayerview.currentSongsIdArray=Data1.Near_station_id;
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
            NearTable.frame=CGRectMake(0, 46, 320, 485);
        }
        else
        {
            NearTable.frame=CGRectMake(0, 46, 320, 395);
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
            NearTable.frame=CGRectMake(0, 46, 320, 485);
        }
        else
        {
            NearTable.frame=CGRectMake(0, 46, 320, 395);
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
