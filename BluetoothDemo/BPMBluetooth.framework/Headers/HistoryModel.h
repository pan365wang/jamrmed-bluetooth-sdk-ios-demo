//
//  HistoryModel.h
//  BluetoothDemo
//
//  Created by 肖栋 on 2024/6/15.
//  Copyright © 2024 HSDM10. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryModel : NSObject

//收缩压值
@property (nonatomic ,assign) NSInteger systolicPressure;
//舒张压
@property (nonatomic ,assign) NSInteger diastolicPressure;
//心率
@property (nonatomic ,assign) NSInteger heartRate;
//房颤状态
@property (nonatomic ,assign) NSInteger atrialFibrillationStatus;
//心率不齐状态
@property (nonatomic ,assign) NSInteger IrregularHeartRateState;
//动脉硬化状态
@property (nonatomic ,assign) NSInteger arteriosclerosisStatus;
//用户ID
@property (nonatomic ,assign) NSInteger userId;
//年份
@property (nonatomic ,assign) NSInteger year;
//月份
@property (nonatomic ,assign) NSInteger month;
//天数
@property (nonatomic ,assign) NSInteger day;
//小时
@property (nonatomic ,assign) NSInteger hour;
//分钟
@property (nonatomic ,assign) NSInteger minute;
//秒
@property (nonatomic ,assign) NSInteger second;
//测量状态（0x00：升压  0x01：降压 0x02：双模 ）
@property (nonatomic ,assign) NSInteger measurementStatus;
//电量 255 代表NONE 充电模式下无电量返回
@property (nonatomic ,assign) NSInteger electricityLevel;
//供电模式
@property (nonatomic ,assign) NSInteger powerSupplyMode;
//蓝牙信号强度 255 代表NONE 无蓝牙信号。
@property (nonatomic ,assign) NSInteger bluetoothSignalStrength;

@end

NS_ASSUME_NONNULL_END
