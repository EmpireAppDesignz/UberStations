//
//  HistorySongViewController.h
//  JukeBox
//
//  Created by Eric Rosas on 4/27/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RevealController.h"
#import <FMDB.h>
#import "AppDelegate.h"

@interface HistorySongViewController : UIViewController
{
    AppDelegate *app;
    FMDatabase *db;
    NSMutableArray *HistoryTitlenameArray;
    NSMutableArray *HistorySubTitlenameArray;
    NSMutableArray *HistorySongUrlArray;
    NSMutableArray *HistorySongIdArray;

    __weak IBOutlet UITableView *HistorySongTbl;
}
@end
