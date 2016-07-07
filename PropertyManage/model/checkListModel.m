//
//  checkListModel.m
//  PropertyManage
//
//  Created by tianan-apple on 16/7/5.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "checkListModel.h"

//"checkId":7,
//"checkTime":"2016-03-12 22:52:31",
//"checkName":"超级管理员"
@implementation checkListModel
- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict{
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        
        for (NSDictionary *dict in dictArray) {
            checkListModel *NM=[[checkListModel alloc]init];
            NM.checkId = [[dict objectForKey:@"checkId"]stringValue];
            NM.checkTime = [dict objectForKey:@"checkTime"];
            NM.checkName = [dict objectForKey:@"checkName"];
            [arr addObject:NM];
        }
    }
    return arr;
}
@end
