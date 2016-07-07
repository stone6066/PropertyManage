//
//  mobileRepairModel.m
//  PropertyManage
//
//  Created by tianan-apple on 16/7/6.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "mobileRepairModel.h"

@implementation mobileRepairModel

//"mendId":76,
//"reportTime":1467622965000,
//"mendTitle":"1",
//"mendState":"提交"
- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict{
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        
        for (NSDictionary *dict in dictArray) {
            mobileRepairModel *NM=[[mobileRepairModel alloc]init];
            NM.mendId = [[dict objectForKey:@"mendId"]stringValue];
            NM.mendTitle = [dict objectForKey:@"mendTitle"];
            NM.mendState = [dict objectForKey:@"mendState"];
            NM.reportTime =[self stdTimeToStr:[[dict objectForKey:@"reportTime"]stringValue]];
            
            [arr addObject:NM];
        }
    }
    return arr;
}

-(NSString *)stdTimeToStr:(NSString*)intTime{
    NSTimeInterval interval=[[intTime substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    return [objDateformat stringFromDate: date];
}
@end
