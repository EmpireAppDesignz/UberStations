//
//  PlayerViewController.m
//  JukeBox
//
//  Created by Eric Rosas on 5/7/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()

@end

@implementation PlayerViewController
@synthesize ImageUrl;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    ArtWorkImage=[[AsyncImageView alloc]initWithFrame:CGRectMake(17,290,287,236)];
//    ArtWorkImage=[[AsyncImageView alloc]init];
    
    NSLog(@"Image is:%@",ImageUrl);
    
    
    if ([ImageUrl isEqualToString:@"Icon-40.png"])
    {
        ArtWorkImage.image=[UIImage imageNamed:@"ArtworkImage.png"];
    }
    else
    {
        NSURL *url=[NSURL URLWithString:ImageUrl];
        NSData *data=[NSData dataWithContentsOfURL:url];
        NSLog(@"Data is:%@",data);
        if ( data ==nil|| data ==(id)[NSNull null])
        {
            ArtWorkImage.image=[UIImage imageNamed:@"ArtworkImage.png"];
        }
        else
        {
            ArtWorkImage.imageURL=[NSURL URLWithString:ImageUrl];
        }
    }
    if ([streamer isPaused])
    {
        [PlayPuaseBtn setBackgroundImage:[UIImage imageNamed:@"Player_PlayBtn.png"] forState:UIControlStateNormal];
    }
    else
    {
        [PlayPuaseBtn setBackgroundImage:[UIImage imageNamed:@"Player_PuaseBtn.png"] forState:UIControlStateNormal];
    }
//    ArtWorkImage.imageURL=[NSURL URLWithString:ImageUrlStr];
    //        PlayerSongImage.layer.cornerRadius = PlayerSongImage.frame.size.width / 2;
    ArtWorkImage.clipsToBounds = YES;
//    [self.view addSubview:ArtWorkImage];
    
    TitelLbl.text=self.songName;
    SubTitleLbl.text=self.SubName;
     float value=0;
    
    [mpVolumeView setShowsVolumeSlider:YES];
    [mpVolumeView setShowsRouteButton:NO];
    for (id current in mpVolumeView.subviews)
    {
        if ([current isKindOfClass:[UISlider class]])
        {
            UISlider *volumeSlide = (UISlider *)current;
            NSLog(@"Volume Slider Is:%@",volumeSlide);
//            volumeSlide.minimumTrackTintColor =[UIColor colorWithRed:84/255.0 green:33/255.0 blue:71/255.0 alpha:1];
        }
    }
    [self ChackFevritesSongBtnImage];//chack BtnImage For Fevorites
    [self ChackHistorySongBtnImage];//chack BtnImage For History
    
    FevoritesTitlenameArray=[[NSMutableArray alloc] init];
    FevoritesSubTitlenameArray=[[NSMutableArray alloc] init];
    FevoritesSongUrlArray=[[NSMutableArray alloc] init];
    FevoriteSongIdArray=[[NSMutableArray alloc] init];
    
    FevoritesStation_TitlenameArray=[[NSMutableArray alloc] init];
    FevoritesStation_SubTitlenameArray=[[NSMutableArray alloc] init];
    FevoritesStation_SongUrlArray=[[NSMutableArray alloc] init];
    FevoriteStation_SongIdArray=[[NSMutableArray alloc] init];
    FevoriteStation_ImageUrlArray=[[NSMutableArray alloc] init];
    
    [self GetFevoritesSong];
    [self GetFevoriteStations];
    
    TempIndex=app.bottomplayerview.TempFevoriteIndex;
    TempStationIndex=app.bottomplayerview.TempFevoriteStationIndex;
    ProcessIndicater.hidden=YES;
    
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(ChckBuffering) userInfo:nil repeats:YES];
}
-(void)ChckBuffering
{
    if ([streamer isWaiting])
    {
        ProcessIndicater.hidden=NO;
        [ProcessIndicater startAnimating];
        NSLog(@"Waitting");
    }
    else if ([streamer isPlaying])
    {
        ProcessIndicater.hidden=YES;
        [ProcessIndicater stopAnimating];
    }
}
-(void)ChackHistorySongBtnImage
{
    app=[[UIApplication sharedApplication] delegate];
    if ([app.bottomplayerview.typestr isEqualToString:@"Song"])
    {
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath=[NSString stringWithFormat:@"%@/%@",documentsDirectory,@"dbJukeBox.db"];
        db = [FMDatabase databaseWithPath:filePath];
        NSLog(@"%@",filePath);
        NSLog(@"Song Name is:%@",self.songName);
        NSLog(@"Song Sub Name is:%@",self.SubName);
        
        if (![db open])
        {
            return;
        }
        else
        {
            FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"select * from SongHistory where titlename='%@' AND subtitlename='%@'",self.songName,self.SubName]];
            NSString *Str;
            while([results next])
            {
                Str=[NSString stringWithFormat:@"%d",[results intForColumn:@"songid"]];
                [HistoryBtn setBackgroundImage:[UIImage imageNamed:@"PlayerHistorySele.png"] forState:UIControlStateNormal];
                ChackHistoryImage=@"Selected";
            }
            NSLog(@"Result is:%@",results);
            NSLog(@"Result is:%@",Str);
        }
    }
    else
    {
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath=[NSString stringWithFormat:@"%@/%@",documentsDirectory,@"dbJukeBox.db"];
        db = [FMDatabase databaseWithPath:filePath];
        NSLog(@"History%@",filePath);
        NSLog(@"History Song Name is:%@",self.songName);
        if (![db open])
        {
            return;
        }
        else
        {
            FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"select * from StationHistory where titlename='%@' AND subtitlename='%@'",self.songName,self.SubName]];
            NSString *Str;
            while([results next])
            {
                Str=[NSString stringWithFormat:@"%d",[results intForColumn:@"songid"]];
                [HistoryBtn setBackgroundImage:[UIImage imageNamed:@"PlayerHistorySele.png"] forState:UIControlStateNormal];
                ChackHistoryImage=@"Selected";
            }
            NSLog(@"History Result is:%@",results);
            NSLog(@"History Result is:%@",Str);
        }
    }
}
-(void)ChackFevritesSongBtnImage
{
     app=[[UIApplication sharedApplication] delegate];
    if ([app.bottomplayerview.typestr isEqualToString:@"Song"])
    {
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath=[NSString stringWithFormat:@"%@/%@",documentsDirectory,@"dbJukeBox.db"];
        db = [FMDatabase databaseWithPath:filePath];
        NSLog(@"%@",filePath);
        NSLog(@"Song Name is:%@",self.songName);
        NSLog(@"Song Sub Name is:%@",self.SubName);

        if (![db open])
        {
            return;
        }
        else
        {
            FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"select * from FevoriteSong where titlename='%@' AND subtitlename='%@'",self.songName,self.SubName]];
            NSString *Str;
            while([results next])
            {
                Str=[NSString stringWithFormat:@"%d",[results intForColumn:@"songid"]];
                [FevoritesBtn setBackgroundImage:[UIImage imageNamed:@"Player_Fevorite_SelBtn.png"] forState:UIControlStateNormal];
                Chackimage=@"Selected";
            }
            NSLog(@"Result is:%@",results);
            NSLog(@"Result is:%@",Str);
        }
    }
    else
    {
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath=[NSString stringWithFormat:@"%@/%@",documentsDirectory,@"dbJukeBox.db"];
        db = [FMDatabase databaseWithPath:filePath];
        NSLog(@"%@",filePath);
        NSLog(@"Song Name is:%@",self.songName);
        if (![db open])
        {
            return;
        }
        else
        {
            FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"select * from FavoriteStation where titlename='%@' AND subtitlename='%@'",self.songName,self.SubName]];
            NSString *Str;
            while([results next])
            {
                Str=[NSString stringWithFormat:@"%d",[results intForColumn:@"songid"]];
                [FevoritesBtn setBackgroundImage:[UIImage imageNamed:@"Player_Fevorite_SelBtn.png"] forState:UIControlStateNormal];
                Chackimage=@"Selected";
            }
            NSLog(@"Result is:%@",results);
            NSLog(@"Result is:%@",Str);
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)CloseBtnClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
//    BottomPlayerView *Bottom =[[BottomPlayerView alloc] init];
    
//    [self.view addSubview:Bottom];
    app=[[UIApplication sharedApplication] delegate];
    [app.bottomplayerview ShowPlayer];
//    [Bottom NewShow];
}
#pragma mark Next And Prevouse Methods
- (IBAction)NextClick:(id)sender
{
    app=[[UIApplication sharedApplication] delegate];
    if ([app.bottomplayerview.typestr isEqualToString:@"Song"])
    {
        if (FevoriteSongIdArray.count)
        {
            app=[[UIApplication sharedApplication] delegate];
//            app.bottomplayerview.currentSongIndex=0;
            app.bottomplayerview.currentSongsNameArray=[FevoritesTitlenameArray objectAtIndex:TempIndex];
            app.bottomplayerview.currentSongsURLArray=[FevoritesSongUrlArray objectAtIndex:TempIndex];
            app.bottomplayerview.currentSongsIdArray=[FevoriteSongIdArray objectAtIndex:TempIndex];
            NSString *TempImg=@"Icon-40.png";
            app.bottomplayerview.ImageUrlStr=TempImg;
            app.bottomplayerview.SongSubName=[FevoritesSubTitlenameArray objectAtIndex:TempIndex];
            app.bottomplayerview.typestr=@"Song";
            NSLog(@"Type is:%@",app.bottomplayerview.typestr);
            app.bottomplayerview.isRadio=NO;
            
            TitelLbl.text=[FevoritesTitlenameArray objectAtIndex:TempIndex];
            SubTitleLbl.text=[FevoritesSubTitlenameArray objectAtIndex:TempIndex];
            [app.bottomplayerview startPlaying];
            NSUInteger myCount = [FevoriteSongIdArray count];

            if (myCount -1 ==TempIndex)
            {
                NSLog(@"Last Objects");
                
//                UIAlertView *Alert=[[UIAlertView alloc] initWithTitle:@"Last Song" message:@"No More Song in The Fevorites" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//                [Alert show];
                NSUInteger Temp= FevoriteSongIdArray.count;
                app.bottomplayerview.TempFevoriteIndex=(int)Temp;
            }
            else
            {
                TempIndex=TempIndex+1;
                app.bottomplayerview.TempFevoriteIndex=TempIndex;
            }
           
        }
        else
        {
            UIAlertView *Alert=[[UIAlertView alloc] initWithTitle:@"Request" message:@"Please Add 2 Or More Song In The Favorite Section" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [Alert show];
        }
    }
    else
    {
        if (FevoriteStation_SongIdArray.count)
        {
            /*FevoritesStation_TitlenameArray;
             FevoritesStation_SubTitlenameArray;
             FevoritesStation_SongUrlArray;
             FevoriteStation_SongIdArray;
             FevoriteStation_ImageUrlArray;*/
            
            //TempStationIndex
//            TempFevoriteStationIndex
            
            app=[[UIApplication sharedApplication] delegate];
            //            app.bottomplayerview.currentSongIndex=0;
            app.bottomplayerview.currentSongsNameArray=[FevoritesStation_TitlenameArray objectAtIndex:TempStationIndex];
            app.bottomplayerview.currentSongsURLArray=[FevoritesStation_SongUrlArray objectAtIndex:TempStationIndex];
            app.bottomplayerview.currentSongsIdArray=[FevoriteStation_SongIdArray objectAtIndex:TempStationIndex];
//            NSString *TempImg=@"Icon-40.png";
            app.bottomplayerview.ImageUrlStr=[FevoriteStation_ImageUrlArray objectAtIndex:TempStationIndex];
            app.bottomplayerview.SongSubName=[FevoritesStation_SubTitlenameArray objectAtIndex:TempStationIndex];
            app.bottomplayerview.typestr=@"Station";
            NSLog(@"Type is:%@",app.bottomplayerview.typestr);
            app.bottomplayerview.isRadio=NO;
            
            TitelLbl.text=[FevoritesStation_TitlenameArray objectAtIndex:TempStationIndex];
            SubTitleLbl.text=[FevoritesStation_SubTitlenameArray objectAtIndex:TempStationIndex];
            ArtWorkImage.imageURL=[NSURL URLWithString:[FevoriteStation_ImageUrlArray objectAtIndex:TempStationIndex]];
            [app.bottomplayerview startPlaying];
            NSUInteger myCount = [FevoriteStation_SongIdArray count];
            
            if (myCount -1 ==TempStationIndex)
            {
                NSLog(@"Last Objects");
                
                //                UIAlertView *Alert=[[UIAlertView alloc] initWithTitle:@"Last Song" message:@"No More Song in The Fevorites" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                //                [Alert show];
                NSUInteger Temp= FevoriteStation_SongIdArray.count;
                app.bottomplayerview.TempFevoriteStationIndex=(int)Temp;
            }
            else
            {
                TempStationIndex=TempStationIndex+1;
                app.bottomplayerview.TempFevoriteStationIndex=TempStationIndex;
            }
        }
        else
        {
            UIAlertView *Alert=[[UIAlertView alloc] initWithTitle:@"Request" message:@"Please Add 2 Or More Song In The Favorite Section" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [Alert show];
        }
    }
}
- (IBAction)PrevouseClick:(id)sender
{
    app=[[UIApplication sharedApplication] delegate];
    if ([app.bottomplayerview.typestr isEqualToString:@"Song"])
    {
        if (FevoriteSongIdArray.count)
        {
            //            TempIndex=app.bottomplayerview.TempFevoriteIndex;
            
            app=[[UIApplication sharedApplication] delegate];
            app.bottomplayerview.currentSongIndex=0;
            app.bottomplayerview.currentSongsNameArray=[FevoritesTitlenameArray objectAtIndex:TempIndex];
            app.bottomplayerview.currentSongsURLArray=[FevoritesSongUrlArray objectAtIndex:TempIndex];
            app.bottomplayerview.currentSongsIdArray=[FevoriteSongIdArray objectAtIndex:TempIndex];
            NSString *TempImg=@"Icon-40.png";
            app.bottomplayerview.ImageUrlStr=TempImg;
            app.bottomplayerview.SongSubName=[FevoritesSubTitlenameArray objectAtIndex:TempIndex];
            app.bottomplayerview.typestr=@"Song";
            NSLog(@"Type is:%@",app.bottomplayerview.typestr);
            app.bottomplayerview.isRadio=NO;
            
            TitelLbl.text=[FevoritesTitlenameArray objectAtIndex:TempIndex];
            SubTitleLbl.text=[FevoritesSubTitlenameArray objectAtIndex:TempIndex];
            //            TempIndex=TempIndex-1;
            //            app.bottomplayerview.TempFevoriteIndex=TempIndex;
            [app.bottomplayerview startPlaying];
//            NSUInteger myCount = [FevoriteSongIdArray count];
            
            if (TempIndex==0)
            {
                NSLog(@"Last Objects");
                TempIndex=0;
                app.bottomplayerview.TempFevoriteIndex=TempIndex;
                
            }
            else
            {
                TempIndex=TempIndex-1;
                app.bottomplayerview.TempFevoriteIndex=TempIndex;
            }
        }
        else
        {
            UIAlertView *Alert=[[UIAlertView alloc] initWithTitle:@"Request" message:@"Please Add 2 Or More Song In The Favorite Section" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [Alert show];
        }
    }
    else
    {
        if (FevoriteStation_SongIdArray.count)
        {
            //TempStationIndex
            //            TempFevoriteStationIndex

            
            app=[[UIApplication sharedApplication] delegate];
            app.bottomplayerview.currentSongIndex=0;
            app.bottomplayerview.currentSongsNameArray=[FevoritesStation_TitlenameArray objectAtIndex:TempStationIndex];
            app.bottomplayerview.currentSongsURLArray=[FevoritesStation_SongUrlArray objectAtIndex:TempStationIndex];
            app.bottomplayerview.currentSongsIdArray=[FevoriteStation_SongIdArray objectAtIndex:TempStationIndex];
//            NSString *TempImg=@"Icon-40.png";
            app.bottomplayerview.ImageUrlStr=[FevoriteStation_ImageUrlArray objectAtIndex:TempStationIndex];
            app.bottomplayerview.SongSubName=[FevoritesStation_SubTitlenameArray objectAtIndex:TempStationIndex];
            app.bottomplayerview.ImageUrlStr=[FevoriteStation_ImageUrlArray objectAtIndex:TempStationIndex];
            app.bottomplayerview.typestr=@"Station";
            NSLog(@"Type is:%@",app.bottomplayerview.typestr);
            app.bottomplayerview.isRadio=NO;
            
            TitelLbl.text=[FevoritesStation_TitlenameArray objectAtIndex:TempStationIndex];
            SubTitleLbl.text=[FevoritesStation_SubTitlenameArray objectAtIndex:TempStationIndex];
            ArtWorkImage.imageURL=[NSURL URLWithString:[FevoriteStation_ImageUrlArray objectAtIndex:TempStationIndex]];
            //            TempIndex=TempIndex-1;
            //            app.bottomplayerview.TempFevoriteIndex=TempIndex;
            [app.bottomplayerview startPlaying];
//            NSUInteger myCount = [FevoriteStation_SongIdArray count];
            
            if (TempStationIndex==0)
            {
                NSLog(@"Last Objects");
                TempIndex=0;
                app.bottomplayerview.TempFevoriteStationIndex=TempStationIndex;
                
            }
            else
            {
                TempStationIndex=TempStationIndex-1;
                app.bottomplayerview.TempFevoriteStationIndex=TempStationIndex;
            }
        }
        else
        {
            UIAlertView *Alert=[[UIAlertView alloc] initWithTitle:@"Request" message:@"Please Add 2 Or More Song In The Favorite Section" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [Alert show];
        }
    }
}
-(void)GetFevoritesSong
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",documentsDirectory,@"dbJukeBox.db"];
    db = [FMDatabase databaseWithPath:filePath];
    NSLog(@"%@",filePath);
    if (![db open])
    {
        return;
    }
    else
    {
        /* [db executeUpdate:@"create table FevoriteSong(id integer primary key,titlename text,subtitlename text,songurl Text,songid integer)"];*/
        
        FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"select * from FavoriteSong"]];
        while([results next])
        {
            [FevoriteSongIdArray addObject:[NSString stringWithFormat:@"%d",[results intForColumn:@"songid"]]];
            
            NSString *GetNameValue=[NSString stringWithFormat:@"%@",[results stringForColumn:@"titlename"]];
            NSString *ConcatName  = [GetNameValue stringByReplacingOccurrencesOfString:@"%27" withString:@"'"];
            [FevoritesTitlenameArray addObject:ConcatName];
            
            NSString *GetSubNameValue=[NSString stringWithFormat:@"%@",[results stringForColumn:@"subtitlename"]];
            NSString *ConactSubName  = [GetSubNameValue stringByReplacingOccurrencesOfString:@"%27" withString:@"'"];
            [FevoritesSubTitlenameArray addObject:ConactSubName];
            
            [FevoritesSongUrlArray addObject:[NSString stringWithFormat:@"%@",[results stringForColumn:@"songurl"]]];
        }
        NSLog(@"Result is:%@",results);
    }
}

-(void)GetFevoriteStations
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",documentsDirectory,@"dbJukeBox.db"];
    db = [FMDatabase databaseWithPath:filePath];
    NSLog(@"%@",filePath);
    if (![db open])
    {
        return;
    }
    else
    {
        /* [db executeUpdate:@"create table FevoriteStation(id integer primary key,titlename text,subtitlename text,stationurl text,stationid integer,stationimageurl Text)"];*/
        
        FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"select * from FavoriteStation"]];
        while([results next])
        {
            [FevoriteStation_SongIdArray addObject:[NSString stringWithFormat:@"%d",[results intForColumn:@"stationid"]]];
            
            NSString *GetNameValue=[NSString stringWithFormat:@"%@",[results stringForColumn:@"titlename"]];
            NSString *ConcatName  = [GetNameValue stringByReplacingOccurrencesOfString:@"%27" withString:@"'"];
            [FevoritesStation_TitlenameArray addObject:ConcatName];
            
            
            NSString *GetSubNameValue=[NSString stringWithFormat:@"%@",[results stringForColumn:@"subtitlename"]];
            NSString *ConactSubName  = [GetSubNameValue stringByReplacingOccurrencesOfString:@"%27" withString:@"'"];
            [FevoritesStation_SubTitlenameArray addObject:ConactSubName];
            
            
            [FevoritesStation_SongUrlArray addObject:[NSString stringWithFormat:@"%@",[results stringForColumn:@"stationurl"]]];
            
            [FevoriteStation_ImageUrlArray addObject:[NSString stringWithFormat:@"%@",[results stringForColumn:@"stationimageurl"]]];
            
        }
        NSLog(@"Result is:%@",results);
    }
}
#pragma mark History Methods
- (IBAction)HistoryClick:(id)sender
{
    app=[[UIApplication sharedApplication] delegate];
    if ([ChackHistoryImage isEqualToString:@"Selected"])
    {
        if ([app.bottomplayerview.typestr isEqualToString:@"Song"])
        {
            [self DeleteHistorySong];
            ChackHistoryImage=@"";
            [HistoryBtn setBackgroundImage:[UIImage imageNamed:@"PlayerHistoryUnSele.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self DeleteHistoryStation];
            ChackHistoryImage=@"";
            [HistoryBtn setBackgroundImage:[UIImage imageNamed:@"PlayerHistoryUnSele.png"] forState:UIControlStateNormal];
        }
    }
    else
    {
        if ([app.bottomplayerview.typestr isEqualToString:@"Song"])
        {
            [self AddHistorySong];
            ChackHistoryImage=@"Selected";
            [HistoryBtn setBackgroundImage:[UIImage imageNamed:@"PlayerHistorySele.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self AddHistoryStation];
            ChackHistoryImage=@"Selected";
            [HistoryBtn setBackgroundImage:[UIImage imageNamed:@"PlayerHistorySele.png"] forState:UIControlStateNormal];
        }
    }
   
}
-(void)DeleteHistoryStation
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",documentsDirectory,@"dbJukeBox.db"];
    db = [FMDatabase databaseWithPath:filePath];
    NSLog(@"%@",filePath);
    if (![db open])
    {
        return;
    }
    else
    {
        UIAlertView *Alert=[[UIAlertView alloc] initWithTitle:@"Success.." message:@"History Station Removed SuccessFully"delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [Alert show];
        
        NSString *ConcatName;
        ConcatName = [self.songName stringByReplacingOccurrencesOfString:@"%27" withString:@"'"];
        
        NSString *ConactSubName;
        ConactSubName = [self.SubName stringByReplacingOccurrencesOfString:@"%27" withString:@"'"];
        
        
        NSString *query = [NSString stringWithFormat:@"delete from StationHistory where titlename='%@' AND subtitlename='%@'",ConcatName,ConactSubName];
        [db executeUpdate:query];
    }
}
-(void)DeleteHistorySong
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",documentsDirectory,@"dbJukeBox.db"];
    db = [FMDatabase databaseWithPath:filePath];
    NSLog(@"%@",filePath);
    if (![db open])
    {
        return;
    }
    else
    {
        UIAlertView *Alert=[[UIAlertView alloc] initWithTitle:@"Success.." message:@"History Song Removed SuccessFully"delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [Alert show];
        
        NSString *ConcatName;
        ConcatName = [self.songName stringByReplacingOccurrencesOfString:@"%27" withString:@"'"];
        
        NSString *ConactSubName;
        ConactSubName = [self.SubName stringByReplacingOccurrencesOfString:@"%27" withString:@"'"];
        
        NSString *query = [NSString stringWithFormat:@"delete from SongHistory where titlename='%@' AND subtitlename='%@'",ConcatName,ConactSubName];
        [db executeUpdate:query];
    }
}
-(void)AddHistorySong
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",documentsDirectory,@"dbJukeBox.db"];
    db = [FMDatabase databaseWithPath:filePath];
    NSLog(@"%@",filePath);
    if (![db open])
    {
        return;
    }
    else
    {
        /*[db executeUpdate:@"create table SongHistory(id integer primary key,titlename text,subtitlename text,songurl Text,songid integer)"];*/
        
        UIAlertView *Alert=[[UIAlertView alloc] initWithTitle:@"Success.." message:@"History Song Added SuccessFully"delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [Alert show];
        
        NSString *ConcatName;
        ConcatName = [self.songName stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
        
        NSString *ConactSubName;
        ConactSubName = [self.SubName stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
        
        NSString *query = [NSString stringWithFormat:@"insert into SongHistory(titlename,subtitlename,songurl,songid) values ('%@','%@','%@',%@)",ConcatName,ConactSubName,self.currentSongsURLArray,self.SongId];
        [db executeUpdate:query];
    }
}
-(void)AddHistoryStation
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",documentsDirectory,@"dbJukeBox.db"];
    db = [FMDatabase databaseWithPath:filePath];
    NSLog(@"%@",filePath);
    if (![db open])
    {
        return;
    }
    else
    {
       /*[db executeUpdate:@"create table StationHistory(id integer primary key,titlename text,subtitlename text,stationurl text,stationid integer,stationimageurl Text)"];*/
        
        UIAlertView *Alert=[[UIAlertView alloc] initWithTitle:@"Success.." message:@"History Station Added SuccessFully"delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [Alert show];
        
        NSLog(@"Image Is:%@",self.ImageUrl);
        
        NSString *ConcatName;
        ConcatName = [self.songName stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
        
        NSString *ConactSubName;
        ConactSubName = [self.SubName stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
        
        NSString *query = [NSString stringWithFormat:@"insert into StationHistory(titlename,subtitlename,stationurl,stationimageurl,stationid) values ('%@','%@','%@','%@','%@')",ConcatName,ConactSubName,self.currentSongsURLArray,self.ImageUrl,self.SongId];
        [db executeUpdate:query];
    }
}
- (IBAction)PlayPuaseClick:(id)sender
{
    app=[[UIApplication sharedApplication] delegate];
    [app.bottomplayerview playButtonPressed:self];
    if( [app.bottomplayerview.currentPlayImageName isEqualToString:@"play.png"])
    {
        [PlayPuaseBtn setBackgroundImage:[UIImage imageNamed:@"Player_PlayBtn.png"] forState:UIControlStateNormal];
    }
    else
    {
        [PlayPuaseBtn setBackgroundImage:[UIImage imageNamed:@"Player_PuaseBtn.png"] forState:UIControlStateNormal];
    }
//     [streamer start];
}
#pragma mark Fevorites Methods
- (IBAction)FevritesClick:(id)sender
{
    app=[[UIApplication sharedApplication] delegate];
    if ([Chackimage isEqualToString:@"Selected"])
    {
        NSLog(@"%@",app.bottomplayerview.typestr);
        if ([app.bottomplayerview.typestr isEqualToString:@"Song"])
        {
            [self DeleteFevoritesSong];
            Chackimage=@"";
            [FevoritesBtn setBackgroundImage:[UIImage imageNamed:@"Player_Fevrite_UnBtn.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self DeleteFevoritesStations];
            Chackimage=@"";
            [FevoritesBtn setBackgroundImage:[UIImage imageNamed:@"Player_Fevrite_UnBtn.png"] forState:UIControlStateNormal];
        }
    }
    else
    {
        NSLog(@"%@",app.bottomplayerview.typestr);
        if ([app.bottomplayerview.typestr isEqualToString:@"Song"])
        {
            [self AddFevoritesSong];
            Chackimage=@"Selected";
            [FevoritesBtn setBackgroundImage:[UIImage imageNamed:@"Player_Fevorite_SelBtn.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self AddFevoritesStation];
            Chackimage=@"Selected";
            [FevoritesBtn setBackgroundImage:[UIImage imageNamed:@"Player_Fevorite_SelBtn.png"] forState:UIControlStateNormal];
        }
    }
}
-(void)AddFevoritesSong
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",documentsDirectory,@"dbJukeBox.db"];
    db = [FMDatabase databaseWithPath:filePath];
    NSLog(@"%@",filePath);
    if (![db open])
    {
        return;
    }
    else
    {
        UIAlertView *Alert=[[UIAlertView alloc] initWithTitle:@"Success.." message:@"Favorite Song Added SuccessFully"delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [Alert show];
        
        NSString *ConcatName;
        ConcatName = [self.songName stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
        
        NSString *ConactSubName;
        ConactSubName = [self.SubName stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
        
        NSString *query = [NSString stringWithFormat:@"insert into FavoriteSong(titlename,subtitlename,songurl,songid) values ('%@','%@','%@',%@)",ConcatName,ConactSubName,self.currentSongsURLArray,self.SongId];
        [db executeUpdate:query];
    }
}
-(void)AddFevoritesStation
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",documentsDirectory,@"dbJukeBox.db"];
    db = [FMDatabase databaseWithPath:filePath];
    NSLog(@"%@",filePath);
    if (![db open])
    {
        return;
    }
    else
    {
        // [db executeUpdate:@"create table FevoriteStation(id integer primary key,titlename text,subtitlename text,stationurl text,dateofadd text,stationid integer,stationimageurl Text)"];
        
        UIAlertView *Alert=[[UIAlertView alloc] initWithTitle:@"Success.." message:@"Favorite Station Added SuccessFully"delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [Alert show];
        
        NSLog(@"Image Is:%@",self.ImageUrl);
        
        NSString *ConcatName;
        ConcatName = [self.songName stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
        
        NSString *ConactSubName;
        ConactSubName = [self.SubName stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];

        
        NSString *query = [NSString stringWithFormat:@"insert into FavoriteStation(titlename,subtitlename,stationurl,stationimageurl,stationid) values ('%@','%@','%@','%@','%@')",ConcatName,ConactSubName,self.currentSongsURLArray,self.ImageUrl,self.SongId];
        [db executeUpdate:query];
    }
}
-(void)DeleteFevoritesStations
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",documentsDirectory,@"dbJukeBox.db"];
    db = [FMDatabase databaseWithPath:filePath];
    NSLog(@"%@",filePath);
    if (![db open])
    {
        return;
    }
    else
    {
        UIAlertView *Alert=[[UIAlertView alloc] initWithTitle:@"Success.." message:@"Favorite Station Remove SuccessFully"delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [Alert show];
        
        NSString *ConcatName;
        ConcatName = [self.songName stringByReplacingOccurrencesOfString:@"%27" withString:@"'"];
        
        NSString *ConactSubName;
        ConactSubName = [self.SubName stringByReplacingOccurrencesOfString:@"%27" withString:@"'"];

        NSString *query = [NSString stringWithFormat:@"delete from FavoriteStation where titlename='%@' AND subtitlename='%@'",ConcatName,ConactSubName];
        [db executeUpdate:query];
    }
}
-(void)DeleteFevoritesSong
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",documentsDirectory,@"dbJukeBox.db"];
    db = [FMDatabase databaseWithPath:filePath];
    NSLog(@"%@",filePath);
    if (![db open])
    {
        return;
    }
    else
    {
        UIAlertView *Alert=[[UIAlertView alloc] initWithTitle:@"Success.." message:@"Favorite Song Remove SuccessFully"delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [Alert show];
        
        NSString *ConcatName;
        ConcatName = [self.songName stringByReplacingOccurrencesOfString:@"%27" withString:@"'"];
        
        NSString *ConactSubName;
        ConactSubName = [self.SubName stringByReplacingOccurrencesOfString:@"%27" withString:@"'"];
        
        NSString *query = [NSString stringWithFormat:@"delete from FavoriteSong where titlename='%@' AND subtitlename='%@'",ConcatName,ConactSubName];
        [db executeUpdate:query];
    }
}
@end
