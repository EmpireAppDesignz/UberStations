//
//  MainSearchViewController.h
//  JukeBox
//
//  Created by Eric Rosas on 4/29/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Home.h"
#import "RevealController.h"
#import "ASIHTTPRequest.h"
#import "SearchDetailViewController.h"

#import "AppDelegate.h"
@class AppDelegate;

@interface MainSearchViewController : UIViewController<UISearchBarDelegate>
{
    
    __weak IBOutlet UISearchBar *MainSearchBar;
    __weak IBOutlet UITableView *SearchTable;
    NSString *SearchEncodingStr;
    NSURL *url;

    NSMutableArray *SearchArray;
    AppDelegate *app;
    UITableViewCell *cell;
}
@property (nonatomic, retain) ASIHTTPRequest *SearchRequest;
@end
