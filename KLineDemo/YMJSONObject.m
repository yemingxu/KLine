//
//  YMJSONObject.m
//  YMCharts_Example
//
//  Created by JoeXu on 2018/5/10.
//  Copyright © 2018年 nightxu. All rights reserved.
//

#import "YMJSONObject.h"

@implementation YMJSONObject

+ (NSArray *)getObjects
{
    //
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JSON" ofType:@"json"];
    NSString *jsonString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    //    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    
    while (YES){
        NSString *t_jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
        t_jsonString = [t_jsonString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        t_jsonString = [t_jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        t_jsonString = [t_jsonString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        t_jsonString = [t_jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = t_jsonString;
        if (t_jsonString.length == jsonString.length)
            break;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSArray *jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    return jsonObj;
}


@end
