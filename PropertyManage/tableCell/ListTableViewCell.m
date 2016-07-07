//
//  ListTableViewCell.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/17.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "ListTableViewCell.h"
#import "repairTableModel.h"
#import "staffDetailModel.h"
#import "PublicDefine.h"
#import "stdCallBtn.h"
#import "attendanceModel.h"
#import "checkListModel.h"
#import "flowListModel.h"
#import "mobileRepairModel.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat CellWidth= self.contentView.frame.size.width-4;
        
        _titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(30,0,CellWidth-30-55,35)];
        _titleLbl.font=[UIFont systemFontOfSize:13];
        [self addSubview:_titleLbl];
        
        
        if ([reuseIdentifier isEqualToString:@"contacts"]) {
            _telBtn=[[stdCallBtn alloc]initWithFrame:CGRectMake(120,2,120,35)];
            [self addSubview:_telBtn];
        }
        else{
            _timeLbl=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-150,2,110,35)];
            _timeLbl.font=[UIFont systemFontOfSize:10];

            [self addSubview:_timeLbl];
        }
        _titleImage=[[UIImageView alloc]initWithFrame:CGRectMake(8,10,15,15)];

        [self addSubview:_titleImage];

        
    }
    return self;
}

-(void)showUiNewsCell:(repairTableModel*)NModel{
    
    _titleLbl.text=NModel.noticeTitle;
    _timeLbl.text=NModel.createTime;
    _titleImage.image=[UIImage imageNamed:@"noticeList"];
    _cellId=NModel.noticeId;
    _noticeContent=NModel.noticeContent;
}
-(void)showUiAttendanceCell:(attendanceModel*)NModel{
    
    _titleLbl.text=NModel.empName;
    _timeLbl.text=NModel.attendanceTime;
    _titleImage.image=[UIImage imageNamed:@"name"];
    _cellId=NModel.attendanceId;
    
}

-(void)showUiCheckListCell:(checkListModel*)NModel{
    
    _titleLbl.text=NModel.checkName;
    _timeLbl.text=NModel.checkTime;
    _titleImage.image=[UIImage imageNamed:@"name"];
    _cellId=NModel.checkId;
    
}

-(void)showUiStaffCell:(staffDetailModel*)NModel{
    
    _titleLbl.text=NModel.staffName;
    [_telBtn setLblText: NModel.staffContact];
    _titleImage.image=[UIImage imageNamed:@"name"];
    _cellId=NModel.staffId;
}

-(void)showUiFlowCell:(flowListModel*)NModel icon_type:(NSString *)iocnName{
    
    _titleLbl.text=NModel.flowTitle;
    _timeLbl.text=NModel.commitTime;
    
    _titleImage.image=[UIImage imageNamed:iocnName];
    _cellId=NModel.flowId;
    _myType=NModel.mendState;
}

-(void)showUiRepairCell:(mobileRepairModel*)NModel icon_type:(NSString *)iocnName{
    
    _titleLbl.text=NModel.mendTitle;
    _timeLbl.text=NModel.reportTime;
    
    _titleImage.image=[UIImage imageNamed:iocnName];
    _cellId=NModel.mendId;
    _myType=NModel.mendState;
}


-(staffDetailModel*)praseContactData:(ListTableViewCell *)LVC{
    staffDetailModel *RTM=[[staffDetailModel alloc]init];
    RTM.staffId=LVC.cellId;
    return RTM;
    
}

-(repairTableModel*)praseNoticeData:(ListTableViewCell *)LVC{
    repairTableModel *RTM=[[repairTableModel alloc]init];
    RTM.noticeId=LVC.cellId;
    return RTM;
    
}

-(attendanceModel*)praseAttendData:(ListTableViewCell *)LVC{
    attendanceModel *RTM=[[attendanceModel alloc]init];
    RTM.attendanceId=LVC.cellId;
    return RTM;
    
}
-(checkListModel*)praseCheckData:(ListTableViewCell *)LVC{
    checkListModel *RTM=[[checkListModel alloc]init];
    RTM.checkId=LVC.cellId;
    RTM.checkName=LVC.titleLbl.text;
    return RTM;
}

-(flowListModel*)praseFlowData:(ListTableViewCell *)LVC{
    flowListModel *RTM=[[flowListModel alloc]init];
    RTM.flowId=LVC.cellId;
    RTM.mendState=LVC.myType;
    return RTM;
}

-(mobileRepairModel*)praseRepairData:(ListTableViewCell *)LVC{
    mobileRepairModel *RTM=[[mobileRepairModel alloc]init];
    RTM.mendId=LVC.cellId;
    RTM.mendState=LVC.myType;
    return RTM;
}
@end
