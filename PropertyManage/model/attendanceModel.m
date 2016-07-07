//
//  attendanceModel.m
//  PropertyManage
//
//  Created by tianan-apple on 16/7/4.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "attendanceModel.h"
//"attendanceId":90,
//"empName":"测试用户",
//"attendanceTime":"2016-06-28 09:44:38"
@implementation attendanceModel
- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict{
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        
        for (NSDictionary *dict in dictArray) {
            attendanceModel *NM=[[attendanceModel alloc]init];
            NM.attendanceId = [[dict objectForKey:@"attendanceId"]stringValue];
            NM.empName = [dict objectForKey:@"empName"];
            NM.attendanceTime = [dict objectForKey:@"attendanceTime"];
            [arr addObject:NM];
        }
    }
    return arr;
}
@end
