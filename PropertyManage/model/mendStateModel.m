//
//  mendStateModel.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/28.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "mendStateModel.h"

@implementation mendStateModel
- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict{
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        for (NSDictionary *dict in dictArray) {
            mendStateModel *NM=[[mendStateModel alloc]init];
            NM.mendLevelId = [[dict objectForKey:@"mendLevelId"]stringValue];
            NM.mendLevelName = [dict objectForKey:@"mendLevelName"];
            [arr addObject:NM];
        }
        
    }
    return arr;
}
@end
