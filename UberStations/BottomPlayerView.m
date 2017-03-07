//
//  BottomPlayerView.m
//  JukeBox
//
//  Created by Eric Rosas on 5/7/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "BottomPlayerView.h"
#define ROOTVIEW [[[UIApplication sharedApplication] keyWindow] rootViewController]

@implementation BottomPlayerView
@synthesize label,detailLabel,btnNext,btnPrevious,btnPlay,currentSongIndex,currentSongsIdArray,currentSongsNameArray,currentSongsURLArray,ImageUrlStr,SongSubName,currentPlayImageName;

//static BottomPlayerView *sharedInstance;
//
//-(id)initWithCoder:(NSCoder *)aDecoder{
//    if ((self = [super initWithCoder:aDecoder])){
//        [self addSubview:[[[NSBundle mainBundle] loadNibNamed:@"BottomPlayerView" owner:self options:nil] objectAtIndex:0]];
//    }
//    return self;
//}
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self=[[[NSBundle mainBundle] loadNibNamed:@"BottomPlayerView" owner:nil options:nil] lastObject];
    }
    return self;
}

+ (id)sharedInstance
{
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        CGRect bounds=[[UIScreen mainScreen] bounds];
        _sharedObject = [[self alloc] initWithFrame:CGRectMake(0,bounds.size.height-45,bounds.size.width, 45)];
        
    });
    return _sharedObject;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)dealloc
{
   
}
- (void)startPlaying
{

   /* if (_isRadio==YES)
    {
        
        
        songName = currentSongsNameArray;
        label.text=songName;
//        currentSongsURLArray=[[NSMutableArray alloc]init];
        currentRadioIndex=0;
        songURL = currentSongsURLArray;
        [self setPlayButtonImageNamed:@"play.png"];
        
        [self createStreamer];
    }
    else{
//        currentSongsURLArray=[[NSMutableArray alloc]init];
        
        NSLog(@"Song Array is :%@",currentSongsURLArray);
        
        songName = currentSongsNameArray;
        songURL = currentSongsURLArray;
        
        [self setPlayButtonImageNamed:@"play.png"];
        
        [self createStreamer];
        label.text=songName;
    }*/
    
    if (_isRadio==YES) {
        songName = currentSongsNameArray;
        label.text=songName;
//        currentSongsURLArray=[[NSMutableArray alloc]init];
        NSLog(@"Current Radio : %d",currentSongIndex);
        currentRadioIndex=0;
        songURL = currentSongsURLArray ;
        [self setPlayButtonImageNamed:@"play.png"];
        if ([streamer isPlaying])
        {
            [streamer stop];
            [self destroyStreamer];
        }
        [self createStreamer];
        [streamer start];
    }
    else
    {
        songName = currentSongsNameArray;
        songURL = currentSongsURLArray;
        
        [self setPlayButtonImageNamed:@"play.png"];
        
        if ([streamer isPlaying])
        {
            [streamer stop];
            [self destroyStreamer];
        }
        [self createStreamer];
        [streamer start];
        self.TitleLbl.text=songName;
        
        if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            PlayerSongImage=[[AsyncImageView alloc]initWithFrame:CGRectMake(280,5,35,35)];
        }
        else if ([[UIScreen mainScreen]bounds].size.height==667)
        {
            PlayerSongImage=[[AsyncImageView alloc]initWithFrame:CGRectMake(320,5,35,35)];
        }
        else
        {
            PlayerSongImage=[[AsyncImageView alloc]initWithFrame:CGRectMake(280,5,35,35)];
        }
        
        PlayerSongImage.image=[UIImage imageNamed:@"Icon-40.png"];
        PlayerSongImage.imageURL=[NSURL URLWithString:ImageUrlStr];
//        PlayerSongImage.layer.cornerRadius = PlayerSongImage.frame.size.width / 2;
        PlayerSongImage.clipsToBounds = YES;
        [self addSubview:PlayerSongImage];
    }
}
- (IBAction)openPlayerButtonPressed:(id)sender
{
    if (_isRadio==NO)
    {
        if (_isPlaying)
        {
//            [streamer stop];
//            [self destroyStreamer];
        }
        [self HidePlayer];
        PlayerViewController *vc=[[PlayerViewController alloc]initWithNibName:@"PlayerViewController" bundle:nil];
        vc.songName=songName;
        NSLog(@"Song Name:%@",SongSubName);
        NSLog(@"Sub Name:%@",songName);
//        vc.currentSongsIdArray=currentSongsIdArray;
        vc.ImageUrl=ImageUrlStr;
        vc.currentSongsURLArray=currentSongsURLArray;
        vc.SubName=SongSubName;
        vc.SongId=currentSongsIdArray;
        
//        vc.songURL=[currentSongsURLArray objectAtIndex:currentSongIndex];
//        vc.currentSongIndex=currentSongIndex;
//        vc.currentSongsNameArray=currentSongsNameArray;
        
            [ROOTVIEW.presentedViewController.navigationController pushViewController:vc animated:YES];
            [ROOTVIEW presentViewController:vc animated:YES completion:nil];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        
//        now present this navigation controller modally
        [ROOTVIEW presentViewController:navigationController animated:YES completion:nil];
    }
}
-(void)ShowPlayer
{
    self.PlayerShowStr=@"Yes";
    CGRect rect=self.frame;
//    NSLog(@"First show y is:%f",rect.origin.y);

    rect.origin.y-=45;
    self.frame=rect;
//    NSLog(@"After show y is:%f",rect.origin.y);
}
-(void)HidePlayer
{
    self.PlayerShowStr=@"No";
    CGRect rect=self.frame;
//    NSLog(@"First hide y is:%f",rect.origin.y);

    rect.origin.y+=45;
    self.frame=rect;
//    NSLog(@"hide y is:%f",rect.origin.y);
}
-(void)NewShow
{
    CGRect rect=self.frame;
    NSLog(@"First New show y is:%f",rect.origin.y);
    rect.origin.y=523;
    self.frame=rect;
    NSLog(@"After New show y is:%f",rect.origin.y);
}
- (void)createStreamer
{
    if (streamer)
    {
        return;
    }
    
    [self destroyStreamer];
//    CGRect rect=self.frame;
//    rect.origin.y-=45;
//    self.frame=rect;
    [self ShowPlayer];
    _isPlaying=YES;
    NSString *escapedValue = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil,(CFStringRef)songURL,NULL,NULL,kCFStringEncodingUTF8));
    
    NSURL *url = [NSURL URLWithString:escapedValue];
    
    streamer = [[AudioStreamer alloc] initWithURL:url];
    
    //    progressUpdateTimer =[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackStateChanged:) name:ASStatusChangedNotification object:streamer];
}
- (void)updateProgress:(NSTimer *)updatedTimer
{
    
}
- (IBAction)playButtonPressed:(id)sender {
    if ([currentPlayImageName isEqual:@"play.png"])
    {
        [streamer start];
        [self setPlayButtonImageNamed:@"pause.png"];
    }
    else
    {
        [streamer pause];
        [self setPlayButtonImageNamed:@"play.png"];
    }
}
- (IBAction)previousButtonPressed:(id)sender
{
    
}
- (IBAction)nextButtonPressed:(id)sender
{
   
}
- (void)destroyStreamer
{
    if (streamer)
    {
        [[NSNotificationCenter defaultCenter]
         removeObserver:self
         name:ASStatusChangedNotification
         object:streamer];
//        CGRect rect=self.frame;
//        rect.origin.y+=45;
//        self.frame=rect;
        [self HidePlayer];
        _isPlaying=NO;
        [streamer stop];
//        [streamer release];
        streamer = nil;
    }
}

- (void)playbackStateChanged:(NSNotification *)aNotification
{
    if ([streamer isWaiting])
    {
        [self setPlayButtonImageNamed:@"sync.png"];
    }
    else if ([streamer isPlaying])
    {
        [self setPlayButtonImageNamed:@"pause.png"];
    }
    else if ([streamer isIdle])
    {
        if (_isRadio==NO) {
//            if (currentSongIndex<([currentSongsNameArray count]-1)) {
                [streamer stop];
                [self destroyStreamer];
                currentSongIndex=currentSongIndex+1;
//                songName=[currentSongsNameArray objectAtIndex:currentSongIndex];
//                songURL=[currentSongsURLArray objectAtIndex:currentSongIndex];
                NSLog(@"%@",songURL);
                label.text=songName;
                [self createStreamer];
                [streamer start];
//            }
        }
        else{
//            if (currentRadioIndex<([currentSongsURLArray count]-1)) {
                [streamer stop];
                [self destroyStreamer];
                currentRadioIndex=currentRadioIndex+1;
//                songURL=[currentSongsURLArray objectAtIndex:currentRadioIndex];
                NSLog(@"%@",songURL);
                [self createStreamer];
                [streamer start];
//            }
        }
        [self setPlayButtonImageNamed:@"play.png"];
    }
}
- (void)setPlayButtonImageNamed:(NSString *)imageName
{
    if (!imageName)
    {
        imageName = @"play.png";
    }
    UIImage *image = [UIImage imageNamed:imageName];
    currentPlayImageName = imageName;
    
    [btnPlay.layer removeAllAnimations];
    [btnPlay setImage:image forState:0];
    
    if ([imageName isEqual:@"sync.png"])
    {
        [self spinButton];
    }
}
- (void)spinButton
{
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    CGRect frame = [btnPlay frame];
    btnPlay.layer.anchorPoint = CGPointMake(0.5, 0.5);
    btnPlay.layer.position = CGPointMake(frame.origin.x + 0.5 * frame.size.width, frame.origin.y + 0.5 * frame.size.height);
    [CATransaction commit];
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
    [CATransaction setValue:[NSNumber numberWithFloat:2.0] forKey:kCATransactionAnimationDuration];
    
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    animation.delegate = self;
    [btnPlay.layer addAnimation:animation forKey:@"rotationAnimation"];
    
    [CATransaction commit];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)finished
{
    if (finished)
    {
        [self spinButton];
    }
}
@end
