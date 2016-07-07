//
//  flowListModel.m
//  PropertyManage
//
//  Created by tianan-apple on 16/7/5.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "flowListModel.h"
//"flowId":89,
//"commitTime":"2016-07-04 05:00:44",
//"flowStatusType":"提交",
//"flowTitle":"真心很急"
@implementation flowListModel
- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict{
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        
        for (NSDictionary *dict in dictArray) {
            flowListModel *NM=[[flowListModel alloc]init];
            NM.flowId = [[dict objectForKey:@"flowId"]stringValue];
            NM.commitTime = [dict objectForKey:@"commitTime"];
            NM.flowStatusType = [dict objectForKey:@"flowStatusType"];
            NM.flowTitle = [dict objectForKey:@"flowTitle"];
            NM.mendState = [[dict objectForKey:@"mendState"]stringValue];
            [arr addObject:NM];
        }
    }
    return arr;
}
@end
