//
//  FevoriteStationViewController.m
//  JukeBox
//
//  Created by Eric Rosas on 4/27/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import "FevoriteStationViewController.h"

@interface FevoriteStationViewController ()

@end

@implementation FevoriteStationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    self.title=@"Favorites Station";
    if (floor(NSFoundationVersionNumber)<=NSFoundationVersionNumber_iOS_6_1)
    {
        [self.navigationController.navigationBar setBackgroundImage :[UIImage imageNamed: @"Nav.png"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage :[UIImage imageNamed: @"Nav.png"] forBarMetrics:UIBarMetricsDefault];
        
    }
    
    FevoriteStation_SongIdArray=[[NSMutableArray alloc] init];
    FevoritesStation_TitlenameArray =[[NSMutableArray alloc] init];
    FevoritesStation_SubTitlenameArray=[[NSMutableArray alloc] init];
    FevoritesStation_SongUrlArray =[[NSMutableArray alloc] init];
    FevoriteStation_ImageUrlArray=[[NSMutableArray alloc] init];
    
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
       /* [db executeUpdate:@"create table FevoriteStation(id integer primary key,titlename text,subtitlename text,stationurl text,stationid integer,stationimageurl Text)"];*/
        
        FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"select * from FevoriteStation"]];
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
    [FevriteStationTbl reloadData];
}
#pragma mark Tableview Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return FevoritesStation_TitlenameArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
   /* cell.textLabel.text = [FevoritesStation_TitlenameArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=[FevoritesStation_SubTitlenameArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor clearColor];*/
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 280, 30.0)];
    [nameLabel setTag:1];
    [nameLabel setBackgroundColor:[UIColor clearColor]]; // transparent label background
    nameLabel.textColor=[UIColor whiteColor];
    [nameLabel setFont:[UIFont boldSystemFontOfSize:15]];
    nameLabel.text = [FevoritesStation_TitlenameArray objectAtIndex:indexPath.row];
    // custom views should be added as subviews of the cell's contentView:
    [cell.contentView addSubview:nameLabel];
    
    UILabel *SubnameLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 20, 300.0, 30.0)];
    [SubnameLabel setTag:1];
    [nameLabel setBackgroundColor:[UIColor clearColor]]; // transparent label background
    SubnameLabel.textColor=[UIColor whiteColor];
    [SubnameLabel setFont:[UIFont boldSystemFontOfSize:10]];
    SubnameLabel.text = [FevoritesStation_SubTitlenameArray objectAtIndex:indexPath.row];
    // custom views should be added as subviews of the cell's contentView:
    [cell.contentView addSubview:SubnameLabel];
    
    FeedSearchUserImage=[[AsyncImageView alloc]initWithFrame:CGRectMake(5,8,35,35)];
    FeedSearchUserImage.image=[UIImage imageNamed:@"Icon-40.png"];
    FeedSearchUserImage.imageURL=[NSURL URLWithString:[FevoriteStation_ImageUrlArray objectAtIndex:indexPath.row]];
    FeedSearchUserImage.layer.cornerRadius = FeedSearchUserImage.frame.size.width / 2;
    FeedSearchUserImage.clipsToBounds = YES;
    [cell.contentView addSubview:FeedSearchUserImage];
    
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"SubName is:%@",[FevoritesStation_SubTitlenameArray objectAtIndex:indexPath.row]);
    NSLog(@"Name is:%@",[FevoritesStation_TitlenameArray objectAtIndex:indexPath.row]);
    
    app=[[UIApplication sharedApplication] delegate];
    app.bottomplayerview.currentSongIndex=0;
    app.bottomplayerview.SongSubName=[FevoritesStation_SubTitlenameArray objectAtIndex:indexPath.row];
    app.bottomplayerview.currentSongsNameArray=[FevoritesStation_TitlenameArray objectAtIndex:indexPath.row];
    app.bottomplayerview.currentSongsURLArray=[FevoritesStation_SongUrlArray objectAtIndex:indexPath.row];
    app.bottomplayerview.currentSongsIdArray=[FevoriteStation_SongIdArray objectAtIndex:indexPath.row];
    NSString *TempImg=@"Icon-40.png";
    app.bottomplayerview.ImageUrlStr=[FevoriteStation_ImageUrlArray objectAtIndex:indexPath.row];
    app.bottomplayerview.ImageUrlStr=TempImg;
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
            FevriteStationTbl.frame=CGRectMake(0, 46, 320, 485);
        }
        else
        {
            FevriteStationTbl.frame=CGRectMake(0, 46, 320, 395);
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
            FevriteStationTbl.frame=CGRectMake(0, 46, 320, 485);
        }
        else
        {
            FevriteStationTbl.frame=CGRectMake(0, 46, 320, 395);
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
