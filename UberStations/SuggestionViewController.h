//
//  SuggestionViewController.h
//  JukeBox
//
//  Created by Eric Rosas on 5/7/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RevealController.h"
#import "AppDelegate.h"

#import "JSON.h"
#import "ASIHTTPRequest.h"
@class AppDelegate;
@interface SuggestionViewController : UIViewController<UITextFieldDelegate>
{
    UIButton *SuggestBtn;
    NSString *encodeing;
    NSURL *url;
    
     IBOutlet UITextField *SuggestSearchbar;
//    __weak IBOutlet UISearchBar *SuggestSearchbar;
    __weak IBOutlet UIView *Suggestview;
    
    NSMutableArray *SuggestionArray;
    __weak IBOutlet UITableView *SuggestTbl;
    
    NSUInteger path;
    AppDelegate *app;
    
    int Mal;
    
    UIButton *convertButtonTitle;
}
@property (nonatomic, retain) ASIHTTPRequest *GetSongRequest;
- (IBAction)SuggestClick:(id)sender;

@end
