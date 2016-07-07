//
//  mendTypeModel.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/28.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "mendTypeModel.h"

@implementation mendTypeModel
- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict{
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        for (NSDictionary *dict in dictArray) {
            mendTypeModel *NM=[[mendTypeModel alloc]init];
            NM.mendTypeId = [[dict objectForKey:@"mendTypeId"]stringValue];
            NM.mendTypeName = [dict objectForKey:@"mendTypeName"];
            [arr addObject:NM];
        }
        
    }
    return arr;
}

@end
