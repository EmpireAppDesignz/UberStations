//
//  TopSongViewController.m
//  JukeBox
//
//  Created by Eric Rosas on 4/13/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import "TopSongViewController.h"



@interface TopSongViewController ()

@end

@implementation TopSongViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //http://api.dar.fm/topsongs.php?q=70%27s&&callback=json
    
    TempView.hidden=YES;
//    self.PekerView.hidden=YES;
    PekerData=[[NSMutableArray alloc] initWithObjects:@"70's",@"80's",@"90's",@"00's",@"Adult Contemporary",@"Alternative",@"Christian",@"Christmas",@"Classical",@"Classic Country",@"Country",@"Electronic",@"Hip Hop",@"Hit Music",@"Indian",@"Jazz",@"Latin Hits",@"Oldies",@"Rap",@"Reggae",@"Rock",@"Roots",@"Soul",@"World",@"Music",nil];
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    NSString *str1=@"Data Loading";
    HUD.delegate = self;
    HUD.labelText = str1;
    HUD.detailsLabelText=@"Please Wait...";
    HUD.dimBackground = YES;
    [self.view addSubview:HUD];
    
    PeramStr=@"Music";
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
        //Add Genres Buttons
//        UIImage *GenreImage = [UIImage imageNamed:@"SliderButton.png"];
        GenresBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [GenresBtn setTitle:@"Genres" forState:UIControlStateNormal];
//        [GenresBtn setImage:buttonImage forState:UIControlStateNormal];
        [GenresBtn setFont:[UIFont systemFontOfSize:15]];
        GenresBtn.frame = CGRectMake(300, 0.0, 50,30);
        [GenresBtn.titleLabel setTextAlignment:UITextAlignmentRight];
        UIBarButtonItem *GenresButtonItem = [[UIBarButtonItem alloc] initWithCustomView:GenresBtn];
        [GenresBtn addTarget:self action:@selector(GenresCliecked:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = GenresButtonItem;
    }
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]}];
    self.title=@"Top Songs";
    if (floor(NSFoundationVersionNumber)<=NSFoundationVersionNumber_iOS_6_1)
    {
        [self.navigationController.navigationBar setBackgroundImage :[UIImage imageNamed: @"Nav.png"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage :[UIImage imageNamed: @"Nav.png"] forBarMetrics:UIBarMetricsDefault];
        
    }
    [self GetSong];
}
-(void)GetSong
{
    NSString *Track=[NSString stringWithFormat:@"http://api.dar.fm/topsongs.php?q=%@&callback=json",PeramStr];
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
    TopSongArray =[[NSMutableArray alloc] init];
    if (request==self.GetSongRequest)
    {
        NSDictionary  *SongDic= [request.responseString JSONValue];
        NSMutableArray *AllData=[SongDic objectForKey:@"result"];
        
        for (NSMutableDictionary *Dics in AllData)
        {
            GetData *Data=[[GetData alloc] init];
            Data.songartistStr=[Dics objectForKey:@"songartist"];
            Data.songtitleStr=[Dics  objectForKey:@"songtitle"];
            Data.currently_playingStr=[Dics  objectForKey:@"currently_playing"];
            Data.callsignStr=[Dics  objectForKey:@"callsign"];
            Data.station_idInt=[Dics  objectForKey:@"station_id"];
            Data.genreStr=[[Dics objectForKey:@"playlist"] objectForKey:@"genre"];
            Data.artistStr=[[Dics objectForKey:@"playlist"] objectForKey:@"artist"];
            Data.titleStr=[[Dics objectForKey:@"playlist"] objectForKey:@"title"];
            Data.songstampStr=[[Dics objectForKey:@"playlist"] objectForKey :@"songstamp"];
            Data.seconds_remainingStr=[[Dics objectForKey:@"playlist"] objectForKey:@"seconds_remaining"];
            Data.uberurlStr=[[Dics objectForKey:@"uberurl"] objectForKey:@"url"];
            Data.uberurlwebsiteurlStr=[[Dics objectForKey:@"uberurl"] objectForKey:@"websiteurl"];
            
            [TopSongArray addObject:Data];
            NSLog(@"Data is:%@",Data.uberurlStr);
        }
    }
    NSLog(@"Top Song Array is :%@",TopSongArray);
    [TopSongTable reloadData];
    [HUD hide:YES];
}
-(void)PlaySong
{
    GetData *Data=[TopSongArray objectAtIndex:path];
    
//    resourcePath =Data.Station_StationurlStr;
//    NSMutableArray *Temp=[[NSMutableArray alloc] init];
//    [Temp addObject:resourcePath];
    
    app=[[UIApplication sharedApplication] delegate];
    app.bottomplayerview.currentSongIndex=0;
    app.bottomplayerview.currentSongsNameArray=Data.songtitleStr;
    app.bottomplayerview.currentSongsURLArray=Data.uberurlStr;
    app.bottomplayerview.currentSongsIdArray=Data.station_idInt;
    NSString *TempImg=@"Icon-40.png";
    app.bottomplayerview.ImageUrlStr=TempImg;
    app.bottomplayerview.SongSubName=Data.songartistStr;
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
            TopSongTable.frame=CGRectMake(0, 46, 320, 485);
        }
        else
        {
            TopSongTable.frame=CGRectMake(0, 46, 320, 395);
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
            TopSongTable.frame=CGRectMake(0, 46, 320, 485);
        }
        else
        {
            TopSongTable.frame=CGRectMake(0, 46, 320, 395);
        }
    }
    //    self.PlayerShowStr=@"Yes";
}
#pragma mark Table Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return TopSongArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetData *Data =[TopSongArray objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = Data.songtitleStr;
    cell.detailTextLabel.text=Data.songartistStr;
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    path=indexPath.row;
    [self PlaySong];
    GetData *Data=[TopSongArray objectAtIndex:indexPath.row];
    StationListViewController *Station=[[StationListViewController alloc] init];
    Station.StationPeramStr=Data.songartistStr;
    Station.SongName=Data.songtitleStr;
    Station.TopSongSubNameStr=Data.songartistStr;
    Station.SongId=Data.station_idInt;
    [self.navigationController pushViewController:Station animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)GenresCliecked:(id)sender
{
    TempView.hidden=NO;
}
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return PekerData.count;
}
// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return PekerData[row];
}
// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    
    PeramStr=[NSString stringWithFormat:@"%@",[PekerData objectAtIndex:row]];
}
- (IBAction)DoneClick:(id)sender
{
    TempView.hidden=YES;
    NSLog(@"Peram is:%@",PeramStr);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]}];
    self.title=PeramStr;
    [HUD show:YES];
    [self GetSong];
}
@end
