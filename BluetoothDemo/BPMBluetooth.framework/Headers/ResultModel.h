//
//  ResultModel.h
//  BluetoothDemo
//
//  Created by 肖栋 on 2024/6/7.
//  Copyright © 2024 HSDM10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BPMBluetooth/HistoryModel.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ReturnTesultType) {
    CurrentBatteryLevel = 177, //返回当前电量
    CurrentVolume = 164, //返回当前音量
    CurrentPressure = 211, //返回当前压力
    CurrentResult = 210, //返回测量结果/历史记录
    Other  //其他
};

typedef NS_ENUM(NSInteger, SendCommandType) {
    ACK = 100, //ack命令
    StartMeasuring = 200, //开始测量
    EndSeasurement = 300, //结束测量
    SendingTime = 400, //发送时间
    SetVolume = 500, //设置音量
    GetVolume = 600, //获取音量
    ObtainingPower = 700, //获取电量
    ObtainHistoricalData = 800, //获取历史记录
    DeleteHistoricalData = 900, //删除历史记录
    SetReminders = 1000, //设置提醒
    DeleteReminder = 2000, //删除提醒
    InterruptHistory = 3000,  //中断历史传输
};

@interface ResultModel : NSObject
///当前电量
@property (nonatomic ,assign) NSInteger currentBatteryLevel;
///当前音量
@property (nonatomic ,assign) NSInteger currentVolume;
///当前压力
@property (nonatomic ,assign) NSInteger currentPressure;
///返回结果类型
@property (nonatomic ,assign) ReturnTesultType returnTesultType;
//测量结果
@property (nonatomic ,strong) HistoryModel *resultModel;
//历史记录
@property (nonatomic ,strong) HistoryModel *historyModel;
@end

NS_ASSUME_NONNULL_END
