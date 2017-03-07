//
//  FevoriteSongViewController.h
//  JukeBox
//
//  Created by Eric Rosas on 4/27/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <FMDB.h>
#import "RevealController.h"
#import "AppDelegate.h"
@interface FevoriteSongViewController : UIViewController
{
    AppDelegate *app;
    FMDatabase *db;
    NSMutableArray *FevoritesTitlenameArray;
    NSMutableArray *FevoritesSubTitlenameArray;
    NSMutableArray *FevoritesSongUrlArray;
    NSMutableArray *FevoriteSongIdArray;
    
    __weak IBOutlet UITableView *FevoriteTbl;
}
@end
