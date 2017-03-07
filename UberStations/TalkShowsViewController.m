//
//  TalkShowsViewController.m
//  JukeBox
//
//  Created by Eric Rosas on 4/13/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//


#import "TalkShowsViewController.h"
#import "ALSdk.h"
#import "ALInterstitialAd.h"

@interface TalkShowsViewController ()

@end

@implementation TalkShowsViewController

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
    
    //http://api.dar.fm/uberguide.php?partner_token=2787730925&callback=json
    
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
    self.title=@"Talk Shows";
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
    NSString *Track=[NSString stringWithFormat:@"http://api.dar.fm/uberguide.php?partner_token=2787730925&callback=json"];
    encodeing=[[NSString alloc]init];
    encodeing =[Track stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    url = [NSURL URLWithString:encodeing];
    self.GetTalkShowRequest = [ASIHTTPRequest requestWithURL:url];
    [self.GetTalkShowRequest setTimeOutSeconds:60];
    [self.GetTalkShowRequest setDelegate:self];
    [self.GetTalkShowRequest startAsynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    if (request==self.GetTalkShowRequest)
    {
        TalkShowArray =[[NSMutableArray alloc] init];

        NSDictionary  *SongDic= [request.responseString JSONValue];
        NSMutableArray *AllData=[SongDic objectForKey:@"stations"];
        
        for (NSMutableDictionary *Dics in AllData)
        {
            GetData *Data=[[GetData alloc] init];
            
            Data.TalkShow_showgenreStr=[Dics objectForKey:@"showgenre"];
            Data.TalkShow_showid=[Dics objectForKey:@"showid"];
            Data.TalkShow_showname=[Dics objectForKey:@"showname"];
            Data.TalkShow_imageurl=[Dics objectForKey:@"imageurl"];
            
            [TalkShowArray addObject:Data];
        }
        NSLog(@"Talk Show Array is :%@",TalkShowArray);
        [TalkShowTable reloadData];
    }
    else if(request==self.GetTalkShowUrlRequest)
    {
        ShowUrlArray=[[NSMutableArray alloc] init];

        NSDictionary  *UrlDic= [request.responseString JSONValue];
        NSMutableArray *UrlAllData=[UrlDic objectForKey:@"result"];
        
        for (NSMutableDictionary *Dics in UrlAllData)
        {
            GetData *Data=[[GetData alloc] init];
            
            Data.TalkShow_StreamUrl=[Dics objectForKey:@"url"];
            Data.TalkShow_StreamEncoding=[Dics objectForKey:@"encoding"];
            Data.TalkShow_StreamCallsign=[Dics objectForKey:@"callsign"];
            Data.TalkShow_StreamWebsiteurl=[Dics objectForKey:@"websiteurl"];
            
            [ShowUrlArray addObject:Data];
            [self Test];
        }
        NSLog(@"Show Url Array is :%@",ShowUrlArray);
    }
    [HUD hide:YES];
}
#pragma mark Tableview Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return TalkShowArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetData *Data =[TalkShowArray objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSUInteger temp=indexPath.row;
    NSLog(@"Data is:%lu",(unsigned long)temp);
    if ([Data.TalkShow_showname isEqualToString:@""]||Data.TalkShow_showname==nil||Data.TalkShow_showname==(id)[NSNull null])
    {
        cell.textLabel.text = @"No Title";
    }
    else
    {
        cell.textLabel.text=Data.TalkShow_showname;
    }
    cell.detailTextLabel.text=Data.TalkShow_showgenreStr;
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
    
    //http://api.dar.fm/uberurl.php?showinfo_id=RSS_24502&partner_token=2787730925&callback=json
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetData *Data=[TalkShowArray objectAtIndex:indexPath.row];
    path=indexPath.row;
    ServicePeram=Data.TalkShow_showid;
    [self GetTalkShowUrl];
}
-(void)GetTalkShowUrl
{
    NSString *GetStream=[NSString stringWithFormat:@"http://api.dar.fm/uberurl.php?showinfo_id=%@&partner_token=2787730925&callback=json",ServicePeram];
    ShowEncodeing=[[NSString alloc]init];
    ShowEncodeing =[GetStream stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    url = [NSURL URLWithString:ShowEncodeing];
    self.GetTalkShowUrlRequest = [ASIHTTPRequest requestWithURL:url];
    [self.GetTalkShowUrlRequest setTimeOutSeconds:60];
    [self.GetTalkShowUrlRequest setDelegate:self];
    [self.GetTalkShowUrlRequest startAsynchronous];
}
-(void)Test
{
    GetData *Data=[ShowUrlArray objectAtIndex:0];
    GetData *Data1=[TalkShowArray objectAtIndex:path];
    NSLog(@"Url Is:%@",Data.TalkShow_StreamUrl);
    NSLog(@"Url Is:%@",Data.TalkShow_StreamWebsiteurl);
    NSLog(@"Show name Is:%@",Data1.TalkShow_showname);
    
    app=[[UIApplication sharedApplication] delegate];
    app.bottomplayerview.currentSongIndex=0;
    app.bottomplayerview.currentSongsURLArray=Data.TalkShow_StreamUrl;
    app.bottomplayerview.isRadio=NO;
    app.bottomplayerview.currentSongsNameArray=Data1.TalkShow_showname;
    NSString *TempImg=@"Icon-40.png";
    app.bottomplayerview.typestr=@"Station";
    app.bottomplayerview.ImageUrlStr=TempImg;
    app.bottomplayerview.SongSubName=Data1.TalkShow_showgenreStr;
    app.bottomplayerview.currentSongsIdArray=Data1.TalkShow_showid;
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
            TalkShowTable.frame=CGRectMake(0, 46, 320, 485);
        }
        else
        {
            TalkShowTable.frame=CGRectMake(0, 46, 320, 395);
        }
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [ALInterstitialAd isReadyForDisplay];
    
    if([ALInterstitialAd isReadyForDisplay])
    {
        [ALInterstitialAd show];
    }
    else
    {
        // No interstitial ad is currently available.  Perform failover logic...
        NSLog(@"Fail");
    }

    
    
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
            TalkShowTable.frame=CGRectMake(0, 46, 320, 485);
        }
        else
        {
            TalkShowTable.frame=CGRectMake(0, 46, 320, 395);
        }
    }
    //    self.PlayerShowStr=@"Yes";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
