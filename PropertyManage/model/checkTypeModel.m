//
//  checkTypeModel.m
//  PropertyManage
//
//  Created by tianan-apple on 16/7/5.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "checkTypeModel.h"

@implementation checkTypeModel
- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict{
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        
        for (NSDictionary *dict in dictArray) {
            checkTypeModel *NM=[[checkTypeModel alloc]init];
            NM.checkId = [[dict objectForKey:@"checkTypeId"]stringValue];
            NM.checkTypeName = [dict objectForKey:@"checkTypeName"];
            [arr addObject:NM];
        }
    }
    return arr;
}
@end
