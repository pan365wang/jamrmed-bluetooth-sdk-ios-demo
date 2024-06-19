//
//  HistoryViewController.m
//  BluetoothDemo
//
//  Created by 肖栋 on 2024/6/14.
//  Copyright © 2024 HSDM10. All rights reserved.
//

#import "HistoryViewController.h"
#import <BPMBluetooth/HistoryModel.h>

#define kScreenHeight     [UIScreen mainScreen].bounds.size.height
#define kScreenWidth      [UIScreen mainScreen].bounds.size.width
#define kNewNavHeight     (CGFloat)(kIs_iPhoneX?(88.0):(64.0))
#define kIs_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIs_iPhoneX kScreenWidth >=375.0f && kScreenHeight >=812.0f&& kIs_iphone

@interface HistoryViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
}

@property (nonatomic ,strong) UITableView  *myCareTab;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测量结果/历史记录";
    
    [self.view addSubview:self.myCareTab];
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier=@"UITableViewCell";
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    HistoryModel *model = self.dataArr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"收缩压:%ld 舒张压:%ld 心率:%ld 房颤状态:%@ 心率不齐状态：%@ 动脉硬化：%@ 用户id:%ld 时间：20%ld-%ld-%ld %ld:%ld:%ld 测量状态:%@ 电量：%ld 蓝牙信号强度：%@    ",model.systolicPressure,model.diastolicPressure,model.heartRate,model.atrialFibrillationStatus==0?@"无":@"有",model.IrregularHeartRateState==0?@"无":@"有",model.arteriosclerosisStatus==0?@"无":@"有",model.userId,model.year,model.month,model.day,model.hour,model.minute,model.second,(model.measurementStatus==0?@"升压":model.measurementStatus==1?@"降压":@"双模"),model.electricityLevel,model.bluetoothSignalStrength==255?@"历史数据":@"测量数据"];
    cell.textLabel.numberOfLines = 0;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.01)];
    return footView;
}

#pragma mark -- Private Methods
#pragma mark -- setter
-(UITableView *)myCareTab{
    if (!_myCareTab) {
        _myCareTab = [[UITableView alloc] initWithFrame:CGRectMake(0, kNewNavHeight, kScreenWidth, kScreenHeight-kNewNavHeight) style:UITableViewStyleGrouped];
        _myCareTab.backgroundColor = [UIColor clearColor];
        _myCareTab.delegate = self;
        _myCareTab.dataSource = self;
        _myCareTab.showsVerticalScrollIndicator=NO;
        _myCareTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_myCareTab setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        
    }
    return _myCareTab;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
