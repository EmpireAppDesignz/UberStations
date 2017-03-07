//
//  MainSearchViewController.m
//  JukeBox
//
//  Created by Eric Rosas on 4/29/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import "MainSearchViewController.h"


@interface MainSearchViewController ()

@end

@implementation MainSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    SearchTable.hidden=YES;
    SearchArray=[[NSMutableArray alloc] init];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark Searchbar Delegate Methods
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    MainSearchBar.showsCancelButton = YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    Home *home=[[Home alloc] init];
    [self.navigationController pushViewController:home animated:YES];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if([searchBar.text isEqualToString:@""] || searchBar.text==nil)
    {
        NSLog(@"Search bar is Empty...");
        SearchArray=[[NSMutableArray alloc] init];
        SearchTable.hidden=YES;
    }
    else
    {
        SearchTable.hidden=NO;
        [self ServicePass];
    }
}
-(void)ServicePass
{
    //http://api.dar.fm/playlist.php?q=@callsign%20abc*&partner_token=2787730925&callback=json
    //http://api.dar.fm/playlist.php?q=@callsign%20Chill*&callback=json
    
    NSString *GetStream=[NSString stringWithFormat:@"http://api.dar.fm/playlist.php?q=@callsign %@*&partner_token=2787730925&callback=json",MainSearchBar.text];
    SearchEncodingStr=[[NSString alloc]init];
    SearchEncodingStr =[GetStream stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    url = [NSURL URLWithString:SearchEncodingStr];
    self.SearchRequest = [ASIHTTPRequest requestWithURL:url];
    [self.SearchRequest setTimeOutSeconds:60];
    [self.SearchRequest setDelegate:self];
    [self.SearchRequest startAsynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    if (request ==self.SearchRequest)
    {
        NSDictionary  *SearchDics= [request.responseString JSONValue];
        NSMutableArray *AllData=[SearchDics objectForKey:@"result"];
        
        for (NSMutableDictionary *Dics in AllData)
        {
            GetData *Data=[[GetData alloc] init];
            Data.Search_callsignStr=[Dics objectForKey:@"callsign"];
            Data.Search_genreStr=[Dics objectForKey:@"genre"];
            Data.Search_artistStr=[Dics objectForKey:@"artist"];
            Data.Search_titleStr=[Dics objectForKey:@"title"];
            Data.Search_songstampStr=[Dics objectForKey:@"songstamp"];
            Data.Search_seconds_remainingStr=[Dics objectForKey:@"seconds_remaining"];
            Data.Search_station_idStr=[Dics objectForKey:@"station_id"];
            [SearchArray addObject:Data];
        }
        [SearchTable reloadData];
    }
}
#pragma mark Tableview Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return SearchArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetData *Data =[SearchArray objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"Cell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=Data.Search_callsignStr;
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
     GetData *Data =[SearchArray objectAtIndex:indexPath.row];
    NSLog(@"Data is:%@",Data.Search_callsignStr);
    
    SearchDetailViewController *Detail = [[SearchDetailViewController alloc] init] ;
    Detail.ServicePeram=Data.Search_callsignStr;
    [self.navigationController pushViewController:Detail animated:YES];
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
            SearchTable.frame=CGRectMake(0, 46, 320, 485);
        }
        else
        {
            SearchTable.frame=CGRectMake(0, 46, 320, 395);
        }
    }
}
@end
