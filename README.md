# Intelligent Blood Pressure Monitor Bluetooth SDK-iOS-20240618

# **I. Scope**

iOS Development Engineers

# **II. Methods**

**2.0 SDK Usage Steps:**

Import header file
#import <BPMBluetooth/LSBluetoothManager.h>

Global Naming
@property (strong, nonatomic) LSBluetoothManager *manager;

```
//SDK initialization
     [LSBluetoothManager openBluetoothAdapter] Initialize SDK.
```

**2.1.1, Bluetooth Status Monitoring:
//Bluetooth is enabled, setting a delegate is required LSBluetoothManagerDelegate//Retrieve Bluetooth status.
- (BOOL)getBluetoothAdapterState;

**2.1.2, Example**
   
@interface HistoryModel : NSObject

//Systolic Pressure
@property (nonatomic ,assign) NSInteger systolicPressure;
//Diastolic Pressure
@property (nonatomic ,assign) NSInteger diastolicPressure;
//Heart Rate
@property (nonatomic ,assign) NSInteger heartRate;
//Atrial Fibrillation Status
@property (nonatomic ,assign) NSInteger atrialFibrillationStatus;
//Irregular Heart Rate State
@property (nonatomic ,assign) NSInteger IrregularHeartRateState;
//Arteriosclerosis Status
@property (nonatomic ,assign) NSInteger arteriosclerosisStatus;
//User ID
@property (nonatomic ,assign) NSInteger userId;
//Year
@property (nonatomic ,assign) NSInteger year;
//Month
@property (nonatomic ,assign) NSInteger month;
//Day
@property (nonatomic ,assign) NSInteger day;
//Hour时
@property (nonatomic ,assign) NSInteger hour;
//Minute
@property (nonatomic ,assign) NSInteger minute;
//Second
@property (nonatomic ,assign) NSInteger second;
//Measurement Status (0x00: Pressurization 0x01: Depressurization 0x02: Dual Mode)
@property (nonatomic ,assign) NSInteger measurementStatus;
//Electricity Level
@property (nonatomic ,assign) NSInteger electricityLevel;
//Power Supply Mode
@property (nonatomic ,assign) NSInteger powerSupplyMode;
//Bluetooth Signal Strength
@property (nonatomic ,assign) NSInteger bluetoothSignalStrength;

@end

```

**2.1.3、Bluetooth On Status: getBluetoothAdapterState**

**2.1.3.1、Return Parameters**

**2.1.3.2、Example**

```
YES On NO Off
- (BOOL)getBluetoothAdapterState;
```


 2.1.4 Start Scanning, prefix: Only search for devices starting with a specific prefix, pass nil to scan all by default
- (void)startBluetoothDevicesDiscovery:(NSString *_Nonnull)deviceName;

```
**2.1.5、Bluetooth Scanned Devices：didDiscoverDeveice（LSBluetoothModel bleDevice）**

**2.1.5.1、 Return Parameters：peripheral**

**2.1.5.2、Example**

- (void)manager:(LSBluetoothManager *_Nullable)manager didDiscoverDeveice:(nonnull LSBluetoothModel *)peripheral error:(nullable NSError *)error;
```

**2.1.6、End Bluetooth Scan：stopBluetoothDevicesDiscovery()**

**2.1.6.1、Return Parameters：**

**2.1.6.2、Example**

```
// End Scan
- (void)stopBluetoothDevicesDiscovery;
```

**2.1.7、Bluetooth Connection Status Notification：onBleConnectedStateChanged(BleDevice bleDevice, int connectState, int reasonState)**

**2.1.7.1、Return Parameters：state**

**2.1.7.2、Example**

```
state YES Connected NO Disconnected
- (void)manager:(LSBluetoothManager *_Nonnull)manager connectedDevice:(nonnull CBPeripheral *)peripheral state:(BOOL)state;
```

**2.1.8、Start Measurement Result Notification: onStartMeasurStateChanged(int status)**

**2.1.8.1、Return Parameters:**

**2.1.8.2、Example**

```
//Start Measurement Send 1 Success 0 Failure
- (void)onStartMeasurStateChanged:(int)status;

```

**2.1.9、Stop Measurement Result Notification：onStopMeasurStateChanged(int status)**

**2.1.9.1、Return Parameters：**

**2.1.9.2、Example**

```
//Stop Measurement Send 1 Success 0 Failure
- (void)onStopMeasurStateChanged:(int)status;
```

**2.1.10、Set Volume Result Notification：onSetVolumeStateChanged(int status)**

**2.1.10.1、Return Parameters：**

**2.1.10.2、Example**

```
//Set Volume Send 1 Success 0 Failure
- (void)onSetVolumeStateChanged:(int)status;
```

**2.1.11、Query Volume Result Notification：onQueryVolumeStateChanged(int status)**

**2.1.11.1、Return Parameters：**

**2.1.11.2、Example**

```
//Query Volume Send 1 Success 0 Failure
- (void)onQueryVolumeStateChanged:(int)status;
```

**2.1.12、Set Time Result Notification：onSendDateStateChanged(int status)**

**2.1.12.1、Return Parameters：**

**2.1.12.2、Example**

```
//Set Time Send 1 Success 0 Failure
- (void)onSendDateStateChanged:(int)status;
```

**2.1.13、Query Battery Result Notification：onQueryBatteryStateChanged(int status)**

**2.1.13.1、Return Parameters：**

**2.1.13.2、Example**

```
//Query Battery Send 1 Success 0 Failure
- (void)onQueryBatteryStateChanged:(int)status;
```

**2.1.14、Query History Data Result Notification：onQueryHistoryDataStateChanged(int status)**

**2.1.14.1、Return Parameters：**

**2.1.14.2、Example**

```
//Query History Data Send 1 Success 0 Failure
- (void)onQueryHistoryDataStateChanged:(int)status;
```

**2.1.15、Clear History Data Result Notification：onClearHistoryDataStateChanged(int status)**

**2.1.15.1、Return Parameters：**

**2.1.15.2、Example**

```
//Clear History Data Send 1 Success 0 Failure
- (void)onClearHistoryDataStateChanged:(int)status;
```

**2.1.16、Send Ack Result Notification：onSendAckChanged(int status)**

**2.1.16.1、Return Parameters：**

**2.1.16.2、Example**

```
//Send ack send 1 Success 0 Failure
- (void)onSendAckChanged:(int)status;
```

**2.1.17 Set Reminder Task Result Notification：onUpdateRemindTaskStateChanged(int status)**

**2.1.17.1、Return Parameters：**

**2.1.17.2、Example**

```
//Set Reminder Task send 1 Success 0 Failure
- (void)onUpdateRemindTaskStateChanged:(int)status;
```

**2.1.18 Cancel Reminder Task Result Notification：onCancelRemindTaskStateChanged(int status)**

**2.1.18.1、Return Parameters：**

**2.1.18.2、Example**

```
//Cancel Reminder Task send 1 Success 0 Failure
- (void)onCancelRemindTaskStateChanged:(int)status;
```

**2.1.19 Request History Data Result Notification：onHistoryData(MeasurBean measurBean)**

**2.1.19.1、Return Parameters**

**2.1.19.2、Example**

```
//Historical Measurement Data
- (void)onHistoryData:(HistoryModel *_Nullable)model;
```

**2.1.20 Current Measurement Data Record Notification：onMeasurData(MeasurBean measurBean)**

**2.1.0.1、Return Parameters：**

**2.1.20.2、Example**

```
//Current Measurement Data
- (void)onMeasurData:(HistoryModel *_Nullable)model;
```

**2.1.21 Current Measurement Pressure Value Notification：onMeasurPressureValue(double value)**

**2.1.21.1、Return Parameters：**

**2.1.21.2、Example**

```
//Current Pressure Value
- (void)onMeasurPressureValue:(int)value;
```

**2.1.2 Current Measurement Pressure Value Notification：onBattery(int battery)**

**2.1.22.1、Return Parameters：**

**2.1.22.2、Example**

```
//Current Battery
- (void)onBattery:(int)battery;
```

**2.1.23 Current Measurement Pressure Value Notification：onVolume(int volume)**

**2.1.23.1、Return Parameters：**

**2.1.23.2、Example**

```
//Current Volume
- (void)onVolume:(int)volume;
```

**2.1.24 Send Command Error Callback：onError(NSError *error)**

**2.1.24.1、Return Parameters：**

**2.1.24.2、Example**

```
//Current Error Message
- (void)onError:(NSError *_Nullable)error;
```

### **2.2、Scan Bluetooth Devices**

Start searching for nearby Bluetooth peripheral devices. This operation is resource-intensive. After searching and connecting to the device, call the `stopBluetoothDevicesDiscovery` method to stop searching.

**2.2.1、Method: startBluetoothDevicesDiscovery**

**2.2.2、Parameter (specified device name): deviceName**

**2.2.3、Return Parameter:****None, monitor scanned devices through the following delegate method**

- (void)manager:(LSBluetoothManager *_Nullable)manager didDiscoverDeveice:(nonnull LSBluetoothModel *)peripheral error:(nullable NSError *)error;


```
- (void)startBluetoothDevicesDiscovery:(NSString *)deviceName;
```

### **2.3、Stop Scanning Bluetooth Devices**

Stop searching for nearby Bluetooth peripheral devices. If the needed Bluetooth device has been found and there is no need to continue searching, it is recommended to call this interface to stop Bluetooth search.

**2.3.1、Method: stopBluetoothDevicesDiscovery**

**2.3.2、Parameter:****None**

**2.3.3、Return Parameter:****None

**2.3.4 Example：**

```
- (void)stopBluetoothDevicesDiscovery;
```

### **2.7、Monitor Bluetooth Status**

Monitor Bluetooth adapter status change events.

**2.7.1、Method: ****- (BOOL)onBluetoothAdapterStateChange;**

**2.7.2、Parameter:**

**2.7.5 Example：**

```
    BOOL state = [maanager onBluetoothAdapterStateChange];
    state == yes Open
    state == no Close
```

```

### **2.9、Device Connection**

Connect to a low-energy Bluetooth device.

**2.9.1、Method:****createBLEConnect**

**2.9.2、Parameter:None**

**2.9.3、Return Parameter:****None，monitor connection status through the following delegate method 
- (void)manager:(LSBluetoothManager *)manager connectedDevice:(CBPeripheral *)peripheral state:(BOOL)state **

**2.9.4 Example：**

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

### **2.10、Disconnect Device**

**2.10.1、Method:****closeBLEConnect**

**2.10.2、Parameter:**

**2.10.3、Return Parameter:****None，monitor connection status through the following delegate method
- (void)manager:(LSBluetoothManager *)manager connectedDevice:(CBPeripheral *)peripheral state:(BOOL)state **


**2.10.4 Example：**

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

### **2.11、Send Time**

After the app successfully connects, actively send the current time to the device.

**2.11.1、Method:sendDate**

**2.11.2、Parameter:**

**2.12.3、Return Parameter:****None, receive the sending result through the following method
- (void)onSendDateStateChanged:(int)status
Method notification if setting was successful, status 1 for success, 0 for failure**

**2.11.5 Example：**

```
//Set time send 1 success 0 failure
- (void)onSendDateStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Sending time success"];
    } else {
        [self sendTextAddStr:@"send Sending time fail"];
    }
}
```

### **2.12、Start Measuring**

Send the start measuring command.

**2.12.1、Method:startMeasuring**

**2.12.2、Parameter:**

**2.12.3、Return Parameter: None, receive the sending result through the following method
- (void)onStartMeasurStateChanged:(int)status;
status 1 for success, 0 for failure**

**2.12.5 Example：**

```
//Start measurement send 1 success 0 failure
- (void)onStartMeasurStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Start measuring success"];
    } else {
        [self sendTextAddStr:@"send Start measuring fail"];
    }
}
```

### **2.13、Stop Measuring**

During the measurement process, send the command to stop (terminate) measuring.

**2.13.1、Method:stopMeasuring**

**2.13.2、Parameter: **

**2.13.3、Return Parameter:****None，receive the sending result through the following method
- (void)onStopMeasurStateChanged:(int)status{
status 1 for success, 0 for failure**

**2.13.5 Example：**

```

// Stop measurement send 1 success 0 failure
- (void)onStopMeasurStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send End measurement success"];
    } else {
        [self sendTextAddStr:@"send End measurement fail"];
    }
}
```

### **2.14、Set Volume**

(0/1/2/3 levels)

Mute：NUM=0  Default：NUM=2

**2.14.1、Method:****setVolume**

**2.14.2、Parameter:**

**2.14.3、Return Parameter:****None，receive the sending result through the following method
- (void)onSetVolumeStateChanged:(int)status{
status 1 for success, 0 for failure**

**2.14.5 Example：**

```
- (void)onSetVolumeStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Set volume success"];
    } else {
        [self sendTextAddStr:@"send Set volume fail"];
    }
}
```

### **2.15、Get Volume**

(0/1/2/3 levels)

Mute：NUM=0  Default：NUM=2

**2.15.1、Method:getVol****ume**

**2.15.2、Parameter:**

**2.15.3、Return Parameter:****None，receive the sending result through the following method
- (void)onQueryVolumeStateChanged:(int)status{
status 1 for success, 0 for failure**

**2.15.5 Example：**

```
//Query volume send 1 success 0 failure
- (void)onQueryVolumeStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Get volume success"];
    } else {
        [self sendTextAddStr:@"send Get volume fail"];
    }
}

//Current volume
- (void)onVolume:(int)volume{
    [self textAddStr:[NSString stringWithFormat:@"volume：%d",volume]];
}

```

### **2.16、Get Battery Level**

Get the current battery level of the device, unit: %

**2.16.1、Method:getBattery**

**2.16.2、Parameter:**

**2.16.3、
Return Parameter:****None，receive the sending result through the following method
- (void)onQueryBatteryStateChanged:(int)status{
status 1 for success, 0 for failure**

**2.16.5 Example：**

```
//Query battery level send 1 success 0 failure
- (void)onQueryBatteryStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Obtaining power success"];
    } else {
        [self sendTextAddStr:@"send Obtaining power fail"];
    }
}

//Current battery level
- (void)onBattery:(int)battery{
    [self textAddStr:[NSString stringWithFormat:@"Electricity level：%d",battery]];
}

```

### **2.17、Get History Data**

Actively initiate the method to get historical records.

**2.17.1、Method:getHistoryData**

**2.17.2、Parameter:**

**2.17.3、None，receive the sending result through the following method
- (void)onQueryHistoryDataStateChanged:(int)status
status 1 for success, 0 for failure**

**2.17.5 Example：**

```
//Query historical records send 1 success 0 failure
- (void)onQueryHistoryDataStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Obtain historical data success"];
    } else {
        [self sendTextAddStr:@"send Obtain historical data fail"];
    }
}

//Historical measurement data returned
- (void)onHistoryData:(HistoryModel *_Nullable)model{

}
```

### **2.18、Delete History Data**

Actively initiate the deletion of historical data

**2.18.1、Method:clearHistoryData**

**2.18.2、Parameter:**** **

**2.18.3、Return Parameter:****None，receive the sending result through the following method
- (void)onQueryHistoryDataStateChanged:(int)status
status 1 for success, 0 for failure**

**2.18.5 Example：**

```
//Clear historical records send 1 success 0 failure
- (void)onClearHistoryDataStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Delete historical data success"];
    } else {
        [self sendTextAddStr:@"send Delete historical data fail"];
    }
}
```

### **2.19、Set Reminder Task**

Actively initiate setting reminder tasks

**2.19.1、Method:setRemindTask**

**2.19.2、Parameter:**

**2.17.3、Return Parameter:****None，receive the sending result through the following method
- (void)onUpdateRemindTaskStateChanged:(int)status
status 1 for success, 0 for failure**
**2.19.4 Example：**

```
//Set reminder task send 1 success 0 failure
- (void)onUpdateRemindTaskStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Set reminders success"];
    } else {
        [self sendTextAddStr:@"send Set reminders fail"];
    }
}
```

### **2.20、Cancel Reminder Task**

Actively initiate canceling reminder tasks.

**2.20.1、Method:cancelRemindTask**

**2.20.2、Parameter:**Return Parameter:****None，receive the sending result through the following method
- (void)onCancelRemindTaskStateChanged:(int)status
status 1 for success, 0 for failure**

**2.20.5 Example：**

```
//Cancel reminder task send 1 success 0 failure
- (void)onCancelRemindTaskStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Delete reminder success"];
    } else {
        [self sendTextAddStr:@"send Delete reminder fail"];
    }
}
```

### **2.21、Monitor Measurement Data**

Monitor measurement data, including measurement data, pressure data, and error measurement data.

**2.21.1、:****-onMeasurData(HistoryModel *)model Measurement Data**

```
- (void)onMeasurData:(HistoryModel *_Nullable)model；
```

**2.21.2、Parameter:None**

**2.21.3、Return Parameter:****HistoryModel **

**2.21.5 Example：**

```
//Current measurement data
- (void)onMeasurData:(HistoryModel *_Nullable)model{

}

//Current pressure value
- (void)onMeasurPressureValue:(int)value{
    [self textAddStr:[NSString stringWithFormat:@"Current pressure：%d",value]];
    
}
```

### **2.22、Send ACK Data Receipt Confirmation (Required for obtaining historical data or real-time data)**

**2.22.1、Method:sendACK**

**2.22.2、Parameter:**

**2.22.3、Return Parameter:****Return Parameter:****None， receive the sending result through the following method
- (void)onSendAckChanged:(int)status;
status 1 for success, 0 for failure**

**2.22.5 Example：**

```
//Send ACK send 1 success 0 failure
- (void)onSendAckChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send ACK success"];
    } else {
        [self sendTextAddStr:@"send ACK fail"];
    }
}
```
