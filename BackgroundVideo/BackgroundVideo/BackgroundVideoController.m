//
//  BackgroundVideoController.m
//  BackgroundVideo
//
//  Created by fuzongjian on 16/4/8.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "BackgroundVideoController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import "PlayTool.h"
@interface BackgroundVideoController ()
@property (nonatomic,strong) MPMoviePlayerController * player;
@property (nonatomic,assign) BOOL  isLoop;
@end

@implementation BackgroundVideoController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.player pause];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self registerPlayerNotification];
    [self.player play];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([PlayTool PlayTool_getUrlInfo] != nil) {
        self.isLoop = [PlayTool PlayTool_getLoopMode];
        [self prepareToPlay];
    }
}
#pragma mark --- 准备
- (void)prepareToPlay{
    if (self.player == nil) {
        NSURL * url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[PlayTool PlayTool_getVideoUrl] ofType:[PlayTool PlayTool_getVideoType]]];
        self.player = [[MPMoviePlayerController alloc] initWithContentURL:url];
        self.player.controlStyle = MPMovieControlStyleNone;
        self.player.view.frame = self.view.frame;
        [self.view addSubview:self.player.view];
        //将self.player.view放在self.view的背后
        [self.view sendSubviewToBack:self.player.view];
        self.player.scalingMode = MPMovieScalingModeAspectFill;
    }
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --- 播放器消息注册、消息处理、通知销毁
- (void)registerPlayerNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerStateChangeNotification:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
}
- (void)playerStateChangeNotification:(NSNotification *)notify{
    MPMoviePlayerController * player = notify.object;
    MPMoviePlaybackState playerState = player.playbackState;
    switch (playerState) {
        case MPMoviePlaybackStatePaused:
        case MPMoviePlaybackStateStopped:
        case MPMoviePlaybackStateInterrupted:
            if (self.isLoop) {//循环播放
                player.controlStyle = MPMovieControlStyleNone;
                [self.player play];
            }
            break;
        default:
            break;
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"video"]) {
        NSLog(@"fuzongjian");
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
