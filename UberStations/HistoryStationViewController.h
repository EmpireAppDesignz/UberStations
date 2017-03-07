//
//  HistoryStationViewController.h
//  JukeBox
//
//  Created by Eric Rosas on 4/27/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RevealController.h"
#import "AppDelegate.h"
#import "AsyncImageView.h"
#import <FMDB.h>
@interface HistoryStationViewController : UIViewController
{
    AppDelegate *app;
    NSMutableArray *HistoryStation_TitlenameArray;
    NSMutableArray *HistoryStation_SubTitlenameArray;
    NSMutableArray *HistoryStation_SongUrlArray;
    NSMutableArray *HistoryStation_SongIdArray;
    NSMutableArray *HistoryStation_ImageUrlArray;
    FMDatabase *db;
    __weak IBOutlet UITableView *HistoryStationTbl;
    AsyncImageView *FeedSearchUserImage;
}
@end
