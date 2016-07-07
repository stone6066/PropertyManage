//
//  ListTableViewCell.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/17.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class repairTableModel,staffDetailModel,stdCallBtn,attendanceModel,checkListModel,flowListModel,mobileRepairModel;

@interface ListTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLbl;
@property(nonatomic,strong)UILabel *timeLbl;
@property(nonatomic,strong)UIImageView *titleImage;
@property(nonatomic,strong)stdCallBtn *telBtn;
@property(nonatomic,copy)NSString *cellId;
@property(nonatomic,copy)NSString *noticeContent;
@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSString *myType;

-(void)showUiNewsCell:(repairTableModel*)NModel;
-(void)showUiStaffCell:(staffDetailModel*)NModel;
-(void)showUiCheckListCell:(checkListModel*)NModel;
-(void)showUiAttendanceCell:(attendanceModel*)NModel;
-(void)showUiFlowCell:(flowListModel*)NModel icon_type:(NSString *)iocnName;
-(void)showUiRepairCell:(mobileRepairModel*)NModel icon_type:(NSString *)iocnName;

-(repairTableModel*)praseNoticeData:(ListTableViewCell *)LVC;
-(staffDetailModel*)praseContactData:(ListTableViewCell *)LVC;
-(attendanceModel*)praseAttendData:(ListTableViewCell *)LVC;
-(checkListModel*)praseCheckData:(ListTableViewCell *)LVC;
-(flowListModel*)praseFlowData:(ListTableViewCell *)LVC;
-(mobileRepairModel*)praseRepairData:(ListTableViewCell *)LVC;
@end
