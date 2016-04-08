//
//  PlayTool.h
//  BackgroundVideo
//
//  Created by 付宗建 on 16/4/8.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayTool : NSObject
+(NSDictionary *)PlayTool_getUrlInfo;
+(NSString *)PlayTool_getVideoUrl;
+(NSString *)PlayTool_getVideoType;
+(BOOL)PlayTool_getLoopMode;
@end
