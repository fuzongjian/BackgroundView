//
//  PlayTool.m
//  BackgroundVideo
//
//  Created by 付宗建 on 16/4/8.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "PlayTool.h"

@implementation PlayTool
+(NSDictionary *)PlayTool_getUrlInfo{
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"VideoPlay" ofType:@"plist"];
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    return dic;
}
+(NSString *)PlayTool_getVideoUrl{
    return [[PlayTool PlayTool_getUrlInfo] objectForKey:@"Url"];
}
+(NSString *)PlayTool_getVideoType{
    return [[PlayTool PlayTool_getUrlInfo] objectForKey:@"Type"];
}
+(BOOL)PlayTool_getLoopMode{
    return [[[PlayTool PlayTool_getUrlInfo] objectForKey:@"Mode Loop"] boolValue];
}
@end
