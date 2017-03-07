//
//  TopSongViewController.h
//  JukeBox
//
//  Created by Eric Rosas on 4/13/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "RevealController.h"
#import "MBProgressHUD.h"

#import "ASIHTTPRequest.h"
#import "SBJSON.h"
#import "JSON.h"

#import "GetData.h"
#import "StationListViewController.h"

#import "AppDelegate.h"
@class AppDelegate;
@interface TopSongViewController : UIViewController<MBProgressHUDDelegate,ASIHTTPRequestDelegate>
{
    MBProgressHUD *HUD;
    
    NSString *PeramStr;
    NSString *encodeing;
    NSURL *url;
    
    NSMutableArray *TopSongArray;
    __weak IBOutlet UITableView *TopSongTable;
    
    __weak IBOutlet UIView *TempView;
    __weak IBOutlet UIToolbar *ToolBar;
    __weak IBOutlet UIBarButtonItem *DoneBtn;
    
    AppDelegate *app;
    
    NSMutableArray *PekerData;
    
    UIButton *GenresBtn;
    NSUInteger path;
    
}
@property (weak, nonatomic) IBOutlet UIPickerView *PekerView;

@property (nonatomic, retain) ASIHTTPRequest *GetSongRequest;
- (IBAction)DoneClick:(id)sender;

@end
