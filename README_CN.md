# 智能血压计蓝牙 SDK-iOS-20240618

# **一、使用范围**

iOS 开发工程师

# **二、方法**

**2.0 sdk 使用步骤：**

导入头文件
#import <BPMBluetooth/LSBluetoothManager.h>

全局命名
@property (strong, nonatomic) LSBluetoothManager *manager;

```
//sdk初始化
     [LSBluetoothManager openBluetoothAdapter] 初始化sdk
```

**2.1.1、蓝牙状态监听: 
// 蓝牙是否打开,需要设置代理 LSBluetoothManagerDelegate//获取蓝牙状态
- (BOOL)getBluetoothAdapterState;

**2.1.2、示例**
   
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
//电量
@property (nonatomic ,assign) NSInteger electricityLevel;
//供电模式
@property (nonatomic ,assign) NSInteger powerSupplyMode;
//蓝牙信号强度
@property (nonatomic ,assign) NSInteger bluetoothSignalStrength;

@end

```

**2.1.3、蓝牙打开状态: getBluetoothAdapterState**

**2.1.3.1、返回参数**

**2.1.3.2、示例**

```
YES 打开 NO 关闭
- (BOOL)getBluetoothAdapterState;
```


 2.1.4 开始扫描,prefix: 只查找某一个前缀开头的设备,传nil默认扫描所有 
- (void)startBluetoothDevicesDiscovery:(NSString *_Nonnull)deviceName;

```
**2.1.5、蓝牙扫描到的蓝牙设备：didDiscoverDeveice（LSBluetoothModel bleDevice）**

**2.1.5.1、返回参数：peripheral**

**2.1.5.2、示例**

- (void)manager:(LSBluetoothManager *_Nullable)manager didDiscoverDeveice:(nonnull LSBluetoothModel *)peripheral error:(nullable NSError *)error;
```

**2.1.6、蓝牙扫描搜索结束：stopBluetoothDevicesDiscovery()**

**2.1.6.1、返回参数：**

**2.1.6.2、示例**

```
// 结束扫描
- (void)stopBluetoothDevicesDiscovery;
```

**2.1.7、蓝牙连接状态通知：onBleConnectedStateChanged(BleDevice bleDevice, int connectState, int reasonState)**

**2.1.7.1、返回参数：state**

**2.1.7.2、示例**

```
state YES 已连接 NO 未连接
- (void)manager:(LSBluetoothManager *_Nonnull)manager connectedDevice:(nonnull CBPeripheral *)peripheral state:(BOOL)state;
```

**2.1.8、启动测量结果通知：onStartMeasurStateChanged(int status)**

**2.1.8.1、返回参数：**

**2.1.8.2、示例**

```
//启动测量 发送1 成功 0失败
- (void)onStartMeasurStateChanged:(int)status;

```

**2.1.9、停止测量结果通知：onStopMeasurStateChanged(int status)**

**2.1.9.1、返回参数：**

**2.1.9.2、示例**

```
//停止测量 发送1 成功 0失败
- (void)onStopMeasurStateChanged:(int)status;
```

**2.1.10、设置音量结果通知：onSetVolumeStateChanged(int status)**

**2.1.10.1、返回参数：**

**2.1.10.2、示例**

```
//设置音量 发送1 成功 0失败
- (void)onSetVolumeStateChanged:(int)status;
```

**2.1.11、查询音量结果通知：onQueryVolumeStateChanged(int status)**

**2.1.11.1、返回参数：**

**2.1.11.2、示例**

```
//查询音量 发送1 成功 0失败
- (void)onQueryVolumeStateChanged:(int)status;
```

**2.1.12、设置时间结果通知：onSendDateStateChanged(int status)**

**2.1.12.1、返回参数：**

**2.1.12.2、示例**

```
//设置时间 发送1 成功 0失败
- (void)onSendDateStateChanged:(int)status;
```

**2.1.13、查询电量结果通知：onQueryBatteryStateChanged(int status)**

**2.1.13.1、返回参数：**

**2.1.13.2、示例**

```
//查询电量 发送1 成功 0失败
- (void)onQueryBatteryStateChanged:(int)status;
```

**2.1.14、查询历史记录结果通知：onQueryHistoryDataStateChanged(int status)**

**2.1.14.1、返回参数：**

**2.1.14.2、示例**

```
//查询历史记录 发送1 成功 0失败
- (void)onQueryHistoryDataStateChanged:(int)status;
```

**2.1.15、清除历史记录结果通知：onClearHistoryDataStateChanged(int status)**

**2.1.15.1、返回参数：**

**2.1.15.2、示例**

```
//清除历史记录 发送1 成功 0失败
- (void)onClearHistoryDataStateChanged:(int)status;
```

**2.1.16、发送 ack 结果通知：onSendAckChanged(int status)**

**2.1.16.1、返回参数：**

**2.1.16.2、示例**

```
//发送ack发送1 成功 0失败
- (void)onSendAckChanged:(int)status;
```

**2.1.17 设置任务提醒结果通知：onUpdateRemindTaskStateChanged(int status)**

**2.1.17.1、返回参数：**

**2.1.17.2、示例**

```
//设置任务提醒发送1 成功  0失败
- (void)onUpdateRemindTaskStateChanged:(int)status;
```

**2.1.18 取消任务提醒结果通知：onCancelRemindTaskStateChanged(int status)**

**2.1.18.1、返回参数：**

**2.1.18.2、示例**

```
//取消任务提醒发送1 成功  0失败
- (void)onCancelRemindTaskStateChanged:(int)status;
```

**2.1.19 请求获取历史记录结果通知：onHistoryData(MeasurBean measurBean)**

**2.1.19.1、返回参数：**

**2.1.19.2、示例**

```
//历史测量数据
- (void)onHistoryData:(HistoryModel *_Nullable)model;
```

**2.1.20 当前测量数据记录结果通知：onMeasurData(MeasurBean measurBean)**

**2.1.0.1、返回参数：**

**2.1.20.2、示例**

```
//当前测量数据
- (void)onMeasurData:(HistoryModel *_Nullable)model;
```

**2.1.21 当前测量压力值结果通知：onMeasurPressureValue(double value)**

**2.1.21.1、返回参数：**

**2.1.21.2、示例**

```
//当前压力值
- (void)onMeasurPressureValue:(int)value;
```

**2.1.2 当前测量压力值结果通知：onBattery(int battery)**

**2.1.22.1、返回参数：**

**2.1.22.2、示例**

```
//当前电量
- (void)onBattery:(int)battery;
```

**2.1.23 当前测量压力值结果通知：onVolume(int volume)**

**2.1.23.1、返回参数：**

**2.1.23.2、示例**

```
//当前音量
- (void)onVolume:(int)volume;
```

**2.1.24 发送指令错误回调：onError(NSError *error)**

**2.1.24.1、返回参数：**

**2.1.24.2、示例**

```
//当前错误信息
- (void)onError:(NSError *_Nullable)error;
```

### **2.2、扫描蓝牙设备**

开始搜寻附近的蓝牙外围设备。此操作比较耗费系统资源，请在搜索并连接到设备后调用 `stopBluetoothDevicesDiscovery` 方法停止搜索。

**2.2.1、方法: startBluetoothDevicesDiscovery**

**2.2.2、参数（指定设备名称）:deviceName**

**2.2.3、返回参数:****无，通过 以下代理方法 监听扫描设备返回**

- (void)manager:(LSBluetoothManager *_Nullable)manager didDiscoverDeveice:(nonnull LSBluetoothModel *)peripheral error:(nullable NSError *)error;


```
- (void)startBluetoothDevicesDiscovery:(NSString *)deviceName;
```

### **2.3、停止扫描蓝牙设备**

停止搜寻附近的蓝牙外围设备。若已经找到需要的蓝牙设备并不需要继续搜索时，建议调用该接口停止蓝牙搜索。

**2.3.1、方法: stopBluetoothDevicesDiscovery**

**2.3.2、参数:****无**

**2.3.3、返回参数:****无

**2.3.4 示例：**

```
- (void)stopBluetoothDevicesDiscovery;
```

### **2.7、监听蓝牙状态**

监听蓝牙适配器状态变化事件

**2.7.1、方法: ****- (BOOL)onBluetoothAdapterStateChange;**

**2.7.2、参数:**

**2.7.5 示例：**

```
    BOOL state = [maanager onBluetoothAdapterStateChange];
    state == yes 打开
    state == no 关闭
```

```

### **2.9、设备连接**

连接低功耗蓝牙设备。

**2.9.1、方法:****createBLEConnect**

**2.9.2、参数:**

**2.9.3、返回参数:****无，通过
- (void)manager:(LSBluetoothManager *)manager connectedDevice:(CBPeripheral *)peripheral state:(BOOL)state 接口监听连接状态**

**2.9.4 示例：**

```
- (void)manager:(LSBluetoothManager *)manager connectedDevice:(CBPeripheral *)peripheral state:(BOOL)state {
    NSLog(@"connectedDevicestate %d",state);
    NSString *title = @"";
    if (state == YES) {
        connectedperipheral = peripheral;
        title = [NSString stringWithFormat:@"%@ connection successful",peripheral.name];
    } else {
        title = [NSString stringWithFormat:@"%@ connection failed",peripheral.name];
    }

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
    [alert show];
    [self createView];
}
```

### **2.10、断开设备连接**

**2.10.1、方法:****closeBLEConnect**

**2.10.2、参数:**

**2.10.3、返回参数:****无，通过 
- (void)manager:(LSBluetoothManager *)manager connectedDevice:(CBPeripheral *)peripheral state:(BOOL)state 接口监听连接状态**
 接口监听连接状态**

**2.10.4 示例：**

```
- (void)manager:(LSBluetoothManager *)manager connectedDevice:(CBPeripheral *)peripheral state:(BOOL)state {
    NSLog(@"connectedDevicestate %d",state);
    NSString *title = @"";
    if (state == YES) {
        connectedperipheral = peripheral;
        title = [NSString stringWithFormat:@"%@ connection successful",peripheral.name];
    } else {
        title = [NSString stringWithFormat:@"%@ connection failed",peripheral.name];
    }

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
    [alert show];
    [self createView];
}
```

### **2.11、发送时间**

app 连接成功后，主动发送当前时间给设备

**2.11.1、方法:sendDate**

**2.11.2、参数:**

**2.12.3、返回参数:****无，通过以下方法接收发送结果
- (void)onSendDateStateChanged:(int)status
 方法通知是否设置成功，status1 成功，0 失败**

**2.11.5 示例：**

```
//设置时间 发送1 成功 0失败
- (void)onSendDateStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Sending time success"];
    } else {
        [self sendTextAddStr:@"send Sending time fail"];
    }
}
```

### **2.12、开始测量**

发送开始测量指令

**2.12.1、方法:startMeasuring**

**2.12.2、参数:**

**2.12.3、返回参数:****无，通过以下方法接收发送结果
- (void)onStartMeasurStateChanged:(int)status;
status1 成功，0 失败**

**2.12.5 示例：**

```
//启动测量 发送1 成功 0失败
- (void)onStartMeasurStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Start measuring success"];
    } else {
        [self sendTextAddStr:@"send Start measuring fail"];
    }
}
```

### **2.13、结束测量**

在测量的过程中，发送结束（终止）测量指令

**2.13.1、方法:stopMeasuring**

**2.13.2、参数:**

**2.13.3、返回参数:****无，通过以下方法接收发送结果
- (void)onStopMeasurStateChanged:(int)status{
status1 成功，0 失败**

**2.13.5 示例：**

```

//停止测量 发送1 成功 0失败
- (void)onStopMeasurStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send End measurement success"];
    } else {
        [self sendTextAddStr:@"send End measurement fail"];
    }
}
```

### **2.14、设置音量**

(0/1/2/3 档）

静音：NUM=0  默认：NUM=2

**2.14.1、方法:****setVolume**

**2.14.2、参数:**

**2.14.3、返回参数:****无，通过以下方法接收发送结果
- (void)onSetVolumeStateChanged:(int)status{
status1 成功，0 失败**

**2.14.5 示例：**

```
- (void)onSetVolumeStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Set volume success"];
    } else {
        [self sendTextAddStr:@"send Set volume fail"];
    }
}
```

### **2.15、获取音量**

(0/1/2/3 档）

静音：NUM=0  默认：NUM=2

**2.15.1、方法:getVol****ume**

**2.15.2、参数:**

**2.15.3、返回参数:****无，通过以下方法接收发送结果
- (void)onQueryVolumeStateChanged:(int)status{
status1 成功，0 失败**

**2.15.5 示例：**

```
//查询音量 发送1 成功 0失败
- (void)onQueryVolumeStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Get volume success"];
    } else {
        [self sendTextAddStr:@"send Get volume fail"];
    }
}

//当前音量
- (void)onVolume:(int)volume{
    [self textAddStr:[NSString stringWithFormat:@"volume：%d",volume]];
}

```

### **2.16、获取电量**

获取设备当前电量，单位：%

**2.16.1、方法:getBattery**

**2.16.2、参数:**

**2.16.3、
返回参数:****无，通过以下方法接收发送结果
- (void)onQueryBatteryStateChanged:(int)status{
status1 成功，0 失败**

**2.16.5 示例：**

```
//查询电量 发送1 成功 0失败
- (void)onQueryBatteryStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Obtaining power success"];
    } else {
        [self sendTextAddStr:@"send Obtaining power fail"];
    }
}

//当前电量
- (void)onBattery:(int)battery{
    [self textAddStr:[NSString stringWithFormat:@"Electricity level：%d",battery]];
}

```

### **2.17、获取历史数据**

主动发起获取历史记录的方法

**2.17.1、方法:getHistoryData**

**2.17.2、参数:**

**2.17.3、无，通过以下方法接收发送结果
- (void)onQueryHistoryDataStateChanged:(int)status
status1 成功，0 失败**

**2.17.5 示例：**

```
//查询历史记录 发送1 成功 0失败
- (void)onQueryHistoryDataStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Obtain historical data success"];
    } else {
        [self sendTextAddStr:@"send Obtain historical data fail"];
    }
}

//历史测量数据返回
- (void)onHistoryData:(HistoryModel *_Nullable)model{

}
```

### **2.18、删除历史数据**

主动发起删除历史数据

**2.18.1、方法:clearHistoryData**

**2.18.2、参数:**** **

**2.18.3、返回参数:****无，通过以下方法接收发送结果
- (void)onQueryHistoryDataStateChanged:(int)status
status1 成功，0 失败**

**2.18.5 示例：**

```
//清除历史记录 发送1 成功 0失败
- (void)onClearHistoryDataStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Delete historical data success"];
    } else {
        [self sendTextAddStr:@"send Delete historical data fail"];
    }
}
```

### **2.19、设置提醒任务**

主动发起删除历史数据

**2.19.1、方法:setRemindTask**

**2.19.2、参数:**

**2.17.3、返回参数:****无，通过以下方法接收发送结果
- (void)onUpdateRemindTaskStateChanged:(int)status
status1 成功，0 失败**
**2.19.4 示例：**

```
//设置任务提醒发送1 成功  0失败
- (void)onUpdateRemindTaskStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Set reminders success"];
    } else {
        [self sendTextAddStr:@"send Set reminders fail"];
    }
}
```

### **2.20、取消提醒任务**

主动发起取消提醒

**2.20.1、方法:cancelRemindTask**

**2.20.2、参数:**返回参数:****无，通过以下方法接收发送结果
- (void)onCancelRemindTaskStateChanged:(int)status
status1 成功，0 失败**

**2.20.5 示例：**

```
//取消任务提醒发送1 成功  0失败
- (void)onCancelRemindTaskStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Delete reminder success"];
    } else {
        [self sendTextAddStr:@"send Delete reminder fail"];
    }
}
```

### **2.21、监听测量数据**

监听测量数据，包括测量数据，压力数据，错误测量数据

**2.21.1、:****-onMeasurData(HistoryModel *)model 测量数据**

```
- (void)onMeasurData:(HistoryModel *_Nullable)model；
```

**2.21.2、参数:无**

**2.21.3、返回参数:****HistoryModel **

**2.21.5 示例：**

```
//当前测量数据
- (void)onMeasurData:(HistoryModel *_Nullable)model{

}

//当前压力值
- (void)onMeasurPressureValue:(int)value{
    [self textAddStr:[NSString stringWithFormat:@"Current pressure：%d",value]];
    
}
```

### **2.22、发送 ack 数据接收确认（获取历史数或者实时数据都需要发送 ack 指令确认）**

**2.22.1、方法:sendACK**

**2.22.2、参数:**

**2.22.3、返回参数:****返回参数:****无，通过以下方法接收发送结果
- (void)onSendAckChanged:(int)status;
status1 成功，0 失败**

**2.22.5 示例：**

```
//发送ack发送1 成功 0失败
- (void)onSendAckChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send ACK success"];
    } else {
        [self sendTextAddStr:@"send ACK fail"];
    }
}
```
