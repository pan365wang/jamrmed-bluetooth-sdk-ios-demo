
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <BPMBluetooth/ResultModel.h>

@interface LSBluetoothModel : NSObject
@property(nonatomic, strong) CBPeripheral * _Nullable peripheral;
@property(nonatomic, strong) NSDictionary<NSString *,id> * _Nullable advertisementData;
@property(nonatomic, strong) NSNumber * _Nullable RSSI;

@end

@class LSBluetoothManager;

@protocol LSBluetoothManagerDelegate <NSObject>

@optional
// 获取设备,会调用多次，需要先调用- (void)startScanDevices;
//peripheral 获取到的蓝牙设备
- (void)manager:(LSBluetoothManager *_Nullable)manager didDiscoverDeveice:(nonnull LSBluetoothModel *)peripheral error:(nullable NSError *)error;

//连接某一台设备是否成功的结果，需要先调用- (void)conect:(CBPeripheral *)peripheral;
//state == NO 断开连接 yes 连接成功
- (void)manager:(LSBluetoothManager *_Nonnull)manager connectedDevice:(nonnull CBPeripheral *)peripheral state:(BOOL)state;


//启动测量 发送1 成功 0失败
- (void)onStartMeasurStateChanged:(int)status;

//停止测量 发送1 成功 0失败
- (void)onStopMeasurStateChanged:(int)status;

//设置音量 发送1 成功 0失败
- (void)onSetVolumeStateChanged:(int)status;

//查询音量 发送1 成功 0失败
- (void)onQueryVolumeStateChanged:(int)status;

//设置时间 发送1 成功 0失败
- (void)onSendDateStateChanged:(int)status;

//查询电量 发送1 成功 0失败
- (void)onQueryBatteryStateChanged:(int)status;

//查询历史记录 发送1 成功 0失败
- (void)onQueryHistoryDataStateChanged:(int)status;

//清除历史记录 发送1 成功 0失败
- (void)onClearHistoryDataStateChanged:(int)status;

//中断历史记录 发送1 成功 0失败
- (void)onStopHistoryDataStateChanged:(int)status;

//发送ack发送1 成功 0失败
- (void)onSendAckChanged:(int)status;

//设置任务提醒发送1 成功  0失败
- (void)onUpdateRemindTaskStateChanged:(int)status;

//取消任务提醒发送1 成功  0失败
- (void)onCancelRemindTaskStateChanged:(int)status;

//历史测量数据
- (void)onHistoryData:(HistoryModel *_Nullable)model;

//当前测量数据
- (void)onMeasurData:(HistoryModel *_Nullable)model;

//当前电量
- (void)onBattery:(int)battery;

//当前音量
- (void)onVolume:(int)volume;

//当前压力值
- (void)onMeasurPressureValue:(int)value;

//当前错误信息
- (void)onError:(NSError *_Nullable)error;

////接收设备端发送的数据
//- (void)manager:(LSBluetoothManager *_Nullable)manager didUpdateValueForCharacteristic:(nonnull CBCharacteristic *)characteristic receiveData:(ResultModel *_Nullable)resultModel error:(nullable NSError *)error;
//
//// 发送命令结束是否成功结果回传
//- (void)manager:(LSBluetoothManager *_Nullable)manager CommandType:(SendCommandType)commandtype error:(nullable NSError *)error;

@end

@interface LSBluetoothManager : NSObject

@property (nonatomic, weak, nullable) id <LSBluetoothManagerDelegate> delegate;

// 初始化蓝牙
+ (instancetype _Nonnull )openBluetoothAdapter;

// 蓝牙是否打开,需要设置代理//获取蓝牙状态
- (BOOL)onBluetoothAdapterStateChange;

// 开始扫描,prefix: 只查找某一个前缀开头的设备,传nil默认扫描所有
- (void)startBluetoothDevicesDiscovery:(NSString *_Nonnull)deviceName;

// 结束扫描
- (void)stopBluetoothDevicesDiscovery;

// 连接某一台设备
- (void)createBLEConnect:(CBPeripheral *_Nonnull)peripheral;

// 判断获取某一台设备是否在线
- (BOOL)isOnLine:(CBPeripheral *_Nonnull)peripheral ServiceUUID:(NSString *_Nonnull)ServiceUUID;

// 断开某一台设备
- (void)closeBLEConnect:(CBPeripheral *_Nullable)peripheral;

// 写入数据
- (void)writeWithPeripheral:(CBPeripheral *_Nonnull)peripheral CMD:(NSData *_Nullable)CMDString;

// 开始测量
- (void)startMeasuring;

// 结束测量
- (void)stopMeasuring;

// 发送时间
- (void)sendDate:(NSString *_Nullable)time;

// 设置音量
- (void)setVol:(NSInteger)volIndex;

//获取当前音量
- (void)getVol;

// 获取电量
- (void)getBattery;

// 获取历史数据
//user == 1 用户1
//user == 2 用户2
- (void)getHistoryData:(NSInteger)user;

// 删除历史数据
- (void)clearHistoryData;

// APP主动发送历史数据中断指令
- (void)InterruptHistory;

// 设置提醒任务
- (void)setRemindTask:(NSString *_Nullable)startTime endTime:(NSString *_Nullable)endTime  hourTime:(NSString *_Nullable)hours;

// 取消提醒任务
- (void)cancelRemindTask;

// APP主动发送数据上传成功ACK确认指令
- (void)sendAckSure;

// NSData转器16进制
- (NSString *_Nullable)hexStringFromData:(NSData *_Nullable)data;

@end


