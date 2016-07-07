//
//  staffGroupModel.m
//  PropertyManage
//
//  Created by tianan-apple on 16/6/30.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "staffGroupModel.h"
#import "staffDetailModel.h"

//"staffId":1,
//"staffName":"马三一",
//"staffContact":"13555951990",
//"staffJobstype":"保安"

@implementation staffGroupModel
-(NSMutableArray *)assignWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        
        
        for (NSDictionary *dict1 in dictArray) {
            staffGroupModel *GAH=[[staffGroupModel alloc]init];
            GAH.layerName=[dict1 objectForKey:@"layerName"];
            
            NSArray *arrtmp=[dict1 objectForKey:@"layerContent"];
            NSMutableArray *subarr = [[NSMutableArray alloc]init];
            for (NSDictionary *mydict in arrtmp) {
                staffDetailModel *GH=[[staffDetailModel alloc]init];
                GH.staffId=[[mydict objectForKey:@"staffId"]stringValue];
                GH.staffName=[mydict objectForKey:@"staffName"];
                GH.staffContact=[mydict objectForKey:@"staffContact"];
                GH.staffJobstype=[mydict objectForKey:@"staffJobstype"];
 
                [subarr addObject:GH];
                
            }
            
            if (arrtmp.count>0) {
                GAH.layerContent=subarr;
                [arr addObject:GAH];
            }
        }
        
    }
    return arr;
}
@end
