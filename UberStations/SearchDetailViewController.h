//
//  SearchDetailViewController.h
//  JukeBox
//
//  Created by Eric Rosas on 4/29/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RevealController.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "GetData.h"
#import "AppDelegate.h"
@class AppDelegate;
@interface SearchDetailViewController : UIViewController
{
    NSString *SearchEncodingStr;
    NSURL *url;
    NSMutableArray *GetDataArray;
    NSMutableArray *GetUrlArray;
    __weak IBOutlet UITableView *DataTable;
    NSString *SecondServiceStr;
    NSURL *GetUrl;
    NSString *GetUrlStr;
    
    NSUInteger Path;
    AppDelegate *app;
    UITableViewCell *cell;
}
@property(nonatomic,retain)NSString *ServicePeram;
@property (nonatomic, retain) ASIHTTPRequest *GetDataRequest;
@property (nonatomic, retain) ASIHTTPRequest *GetUrlRequest;


@end
