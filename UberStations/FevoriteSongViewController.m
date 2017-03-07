//
//  FevoriteSongViewController.m
//  JukeBox
//
//  Created by Eric Rosas on 4/27/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import "FevoriteSongViewController.h"

@interface FevoriteSongViewController ()

@end

@implementation FevoriteSongViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    self.title=@"Favorites Song";
    if (floor(NSFoundationVersionNumber)<=NSFoundationVersionNumber_iOS_6_1)
    {
        [self.navigationController.navigationBar setBackgroundImage :[UIImage imageNamed: @"Nav.png"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage :[UIImage imageNamed: @"Nav.png"] forBarMetrics:UIBarMetricsDefault];
        
    }
    
    FevoriteSongIdArray=[[NSMutableArray alloc] init];
    FevoritesTitlenameArray =[[NSMutableArray alloc] init];
    FevoritesSubTitlenameArray=[[NSMutableArray alloc] init];
    FevoritesSongUrlArray =[[NSMutableArray alloc] init];
    
    [self GetData];
}
-(void)GetData
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
        
        
        
        FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"select * from FevoriteSong"]];
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
    [FevoriteTbl reloadData];
}
#pragma mark Tableview Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return FevoritesTitlenameArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [FevoritesTitlenameArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=[FevoritesSubTitlenameArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"SubName is:%@",[FevoritesSubTitlenameArray objectAtIndex:indexPath.row]);
    NSLog(@"Name is:%@",[FevoritesTitlenameArray objectAtIndex:indexPath.row]);
    
    app=[[UIApplication sharedApplication] delegate];
    app.bottomplayerview.currentSongIndex=0;
    app.bottomplayerview.SongSubName=[FevoritesSubTitlenameArray objectAtIndex:indexPath.row];
    app.bottomplayerview.currentSongsNameArray=[FevoritesTitlenameArray objectAtIndex:indexPath.row];
    app.bottomplayerview.currentSongsURLArray=[FevoritesSongUrlArray objectAtIndex:indexPath.row];
    app.bottomplayerview.currentSongsIdArray=[FevoriteSongIdArray objectAtIndex:indexPath.row];
    NSString *TempImg=@"Icon-40.png";
    app.bottomplayerview.ImageUrlStr=TempImg;
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
            FevoriteTbl.frame=CGRectMake(0, 46, 320, 485);
        }
        else
        {
            FevoriteTbl.frame=CGRectMake(0, 46, 320, 395);
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
            FevoriteTbl.frame=CGRectMake(0, 46, 320, 485);
        }
        else
        {
            FevoriteTbl.frame=CGRectMake(0, 46, 320, 395);
        }
    }
    //    self.PlayerShowStr=@"Yes";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
