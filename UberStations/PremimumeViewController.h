//
//  PremimumeViewController.h
//  JukeBox
//
//  Created by Eric Rosas on 5/7/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RevealController.h"
#import "ASIHTTPRequest.h"
#import "AsyncImageView.h"

#import "GetData.h"
#import "JSON.h"
#import "SBJSON.h"
#import "AppDelegate.h"

@class AppDelegate;
@interface PremimumeViewController : UIViewController
{
    UIButton *SearchBtn;
    __weak IBOutlet UIView *SearchView;
    __weak IBOutlet UIPickerView *GenrePicker;
    __weak IBOutlet UITextField *SearchTextbox;
    __weak IBOutlet UIButton *SearchClick;
    int Mal;
    
    NSMutableArray *PekerData;
    NSString *PeramStr;
    __weak IBOutlet UIView *PekerDataView;
    NSString *Chack;
    NSString *SearchEncodingStr;
    NSURL *url;
    __weak IBOutlet UITableView *SearchTBL;
    
    NSMutableArray *SearchAllDataArray;
    NSString *GetUrlStr;
    NSURL *GetUrl;
    NSString *SecondServiceStr;
    NSUInteger Path;
    NSMutableArray *GetUrlArray;
    AppDelegate *app;
    UITableViewCell *cell;
}
- (IBAction)FinalSearch:(id)sender;
- (IBAction)ChooseGenreClick:(id)sender;
@property (nonatomic, retain) ASIHTTPRequest *GetSearchRequest;
@property (nonatomic, retain) ASIHTTPRequest *GetUrlRequest;


@end
