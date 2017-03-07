//
//  PremimumeViewController.m
//  JukeBox
//
//  Created by Eric Rosas on 5/7/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import "PremimumeViewController.h"

@interface PremimumeViewController ()

@end

@implementation PremimumeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    SearchView.hidden=YES;
//    Mal=0;
    PekerData=[[NSMutableArray alloc] initWithObjects:@"Alternative",@"Christian",@"Christmas",@"Classical",@"Country",@"Electronic",@"Hip Hop",@"Hit Music",@"Indian",@"Jazz",@"Latin Hits",@"Oldies",@"Rock",@"Roots",@"Soul",@"World",@"Music",nil];
    
    PeramStr=@"Alternative";
    
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
        SearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [SearchBtn setTitle:@"Search" forState:UIControlStateNormal];
        //        [GenresBtn setImage:buttonImage forState:UIControlStateNormal];
        [SearchBtn setFont:[UIFont systemFontOfSize:15]];
        SearchBtn.frame = CGRectMake(300, 0.0, 50,30);
        [SearchBtn.titleLabel setTextAlignment:UITextAlignmentRight];
        UIBarButtonItem *SearchButtonItem = [[UIBarButtonItem alloc] initWithCustomView:SearchBtn];
        [SearchBtn addTarget:self action:@selector(SearchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = SearchButtonItem;
    }
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]}];
    self.title=@"Premium";
    if (floor(NSFoundationVersionNumber)<=NSFoundationVersionNumber_iOS_6_1)
    {
        [self.navigationController.navigationBar setBackgroundImage :[UIImage imageNamed: @"Nav.png"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage :[UIImage imageNamed: @"Nav.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
}
-(void)GetService
{
    //http://api.dar.fm/playlist.php?q=@callsign%20abc*
   // http://api.dar.fm/playlist.php?q=@callsign%Music*
    
    NSString *GetStream=[NSString stringWithFormat:@"http://api.dar.fm/playlist.php?q=@callsign %@*&callback=json",PeramStr];
    SearchEncodingStr=[[NSString alloc]init];
    SearchEncodingStr =[GetStream stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    url = [NSURL URLWithString:SearchEncodingStr];
    self.GetSearchRequest = [ASIHTTPRequest requestWithURL:url];
    [self.GetSearchRequest setTimeOutSeconds:60];
    [self.GetSearchRequest setDelegate:self];
    [self.GetSearchRequest startAsynchronous];    
}

- (void)SearchBtnClick:(id)sender
{
    SearchView.hidden=NO;
    SearchTextbox.text=@"";
    if (Mal==0)
    {
        SearchView.hidden=NO;
//        GenrePicker.hidden=YES;
//        PekerDataView.hidden=NO;
        [GenrePicker reloadAllComponents];
        Mal=1;
    }
    else
    {
        SearchView.hidden=YES;
        Mal=0;
    }
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    if (request==self.GetSearchRequest)
    {
        SearchAllDataArray =[[NSMutableArray alloc] init];
        NSDictionary  *SongDic= [request.responseString JSONValue];
        NSMutableArray *AllData=[SongDic objectForKey:@"result"];
//        NSMutableArray *Stationarray=[[AllData objectAtIndex:0] objectForKey:@"stations"];
        
        for (NSMutableDictionary *Dics in AllData)
        {
            GetData *Data=[[GetData alloc] init];
            
            Data.Premimume_genreStr=[Dics  objectForKey:@"genre"];
            Data.Premimume_callsignStr=[Dics  objectForKey:@"callsign"];
            Data.Premimume_station_idInt=[Dics  objectForKey:@"station_id"];
            Data.Premimume_songartistStr=[Dics  objectForKey:@"artist"];
            Data.Premimume_songtitleStr=[Dics  objectForKey:@"title"];
            Data.Premimume_SongStatmp=[Dics  objectForKey:@"songstamp"];
            Data.Premimume_seconds_remaining=[Dics  objectForKey:@"seconds_remaining"];
            Data.Premimume_station_idInt=[Dics  objectForKey:@"station_id"];
            
            [SearchAllDataArray addObject:Data];
        }
            [SearchTBL reloadData];
        NSLog(@"Near Data Array is :%@",SearchAllDataArray);
    }
    else if (request==self.GetUrlRequest)
    {
        GetUrlArray=[[NSMutableArray alloc] init];
        NSDictionary  *SongDic= [request.responseString JSONValue];
        NSMutableArray *AllData=[SongDic objectForKey:@"result"];
        
        for (NSMutableDictionary *Dics in AllData)
        {
            GetData *Data=[[GetData alloc] init];
            
            Data.Premimume_Station_StationurlStr=[Dics objectForKey:@"url"];
            Data.Premimume_Station_StationencodingStr=[Dics objectForKey:@"encoding"];
            Data.Premimume_Station_callsign=[Dics objectForKey:@"callsign"];
            Data.Premimume_Station_websiteurl=[Dics objectForKey:@"websiteurl"];
            Data.Premimume_Station_station_id=[Dics objectForKey:@"station_id"];
            
            [GetUrlArray addObject:Data];
            NSLog(@"Name Is:%@",Data.Premimume_Station_callsign);
            
        }
        [self PlaySong];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // [TitleOfPosting resignFirstResponder];
    [textField resignFirstResponder];
    //      [self.view endEditing:YES];
    return YES;
    // Do the search...
}
- (IBAction)FinalSearch:(id)sender
{
    SearchView.hidden=YES;
    Mal=0;
    if ([SearchTextbox.text isEqualToString:@""]||SearchTextbox.text ==nil||SearchTextbox.text==(id)[NSNull null])
    {
    }
    else
    {
        PeramStr= SearchTextbox.text;
    }
    [self GetService];
}
- (IBAction)ChooseGenreClick:(id)sender
{
    GenrePicker.hidden=YES;
    PekerDataView.hidden=YES;
}
#pragma mark Picker Methods
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
#pragma mark Tableview Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return SearchAllDataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetData *Data =[SearchAllDataArray objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"Cell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=Data.Premimume_callsignStr;
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.detailTextLabel.text=Data.Premimume_genreStr;
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetData *Data =[SearchAllDataArray objectAtIndex:indexPath.row];
    NSLog(@"Id Str is:%@",Data.Premimume_station_idInt);
    SecondServiceStr=Data.Premimume_station_idInt;
    Path=indexPath.row;
    [self PlayStationService];
}
-(void)PlayStationService
{
    //http://api.dar.fm/uberstationurl.php?station_id=15096&partner_token=2787730925
    
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
//    NSLog(@"Path is:%d",Path);
    GetData *Data =[GetUrlArray objectAtIndex:0];
    app=[[UIApplication sharedApplication] delegate];
    app.bottomplayerview.currentSongIndex=0;
    NSLog(@"Name Is:%@",Data.Premimume_Station_callsign);
    app.bottomplayerview.currentSongsNameArray=Data.Premimume_Station_callsign;
    app.bottomplayerview.currentSongsURLArray=Data.Premimume_Station_StationurlStr;
    app.bottomplayerview.currentSongsIdArray=Data.Premimume_Station_station_id;
    NSString *TempImg=@"Icon-40.png";
    app.bottomplayerview.ImageUrlStr=TempImg;
    app.bottomplayerview.SongSubName=Data.Premimume_Station_StationencodingStr;
    app.bottomplayerview.typestr=@"Station";
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
            SearchTBL.frame=CGRectMake(0, 46, 320, 485);
        }
        else
        {
            SearchTBL.frame=CGRectMake(0, 46, 320, 395);
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
            SearchTBL.frame=CGRectMake(0, 46, 320, 485);
        }
        else
        {
            SearchTBL.frame=CGRectMake(0, 46, 320, 395);
        }
    }
}
@end
