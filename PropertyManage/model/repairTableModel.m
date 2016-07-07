//
//  repairTableModel.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/17.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "repairTableModel.h"

//@property (nonatomic,copy)NSString *noticeId;
//@property (nonatomic,copy)NSString *noticeTitle;
//@property (nonatomic,copy)NSString *noticeContent;
//@property (nonatomic,copy)NSString *createTime;
//@property (nonatomic,copy)NSString *userId;

@implementation repairTableModel
- (NSMutableArray *)asignModelWithDict:(NSDictionary *)dict{
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        
        for (NSDictionary *dict in dictArray) {
            repairTableModel *NM=[[repairTableModel alloc]init];
            NM.noticeId = [[dict objectForKey:@"noticeId"]stringValue];
            NM.noticeTitle = [dict objectForKey:@"noticeTitle"];
            NM.noticeContent = [dict objectForKey:@"noticeContent"];
            NM.createTime =[self stdTimeToStr:[dict objectForKey:@"createTime"]];
            //[dict objectForKey:@"createTime"];
            NM.userId = [[dict objectForKey:@"userId"]stringValue];
            [arr addObject:NM];
        }
    }
    return arr;
}

-(NSString *)stdTimeToStr:(NSString*)intTime{
    return [intTime substringToIndex:10];
}
@end
