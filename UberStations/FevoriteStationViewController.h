//
//  FevoriteStationViewController.h
//  JukeBox
//
//  Created by Eric Rosas on 4/27/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FMDB.h>
#import "AppDelegate.h"
#import "RevealController.h"
#import "AsyncImageView.h"
@interface FevoriteStationViewController : UIViewController
{
    AppDelegate *app;
    NSMutableArray *FevoritesStation_TitlenameArray;
    NSMutableArray *FevoritesStation_SubTitlenameArray;
    NSMutableArray *FevoritesStation_SongUrlArray;
    NSMutableArray *FevoriteStation_SongIdArray;
    NSMutableArray *FevoriteStation_ImageUrlArray;
    FMDatabase *db;
    __weak IBOutlet UITableView *FevriteStationTbl;
    AsyncImageView *FeedSearchUserImage;
}
@end
