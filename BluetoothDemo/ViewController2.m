

#import "ViewController2.h"
#import "UIView+Toast.h"
#import "HistoryViewController.h"
#import "TCDatePickerView.h"
#import "LPPickView.h"

#define kScreenHeight     [UIScreen mainScreen].bounds.size.height
#define kScreenWidth      [UIScreen mainScreen].bounds.size.width
#define kNewNavHeight     (CGFloat)(kIs_iPhoneX?(88.0):(64.0))
#define kIs_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIs_iPhoneX kScreenWidth >=375.0f && kScreenHeight >=812.0f&& kIs_iphone

@interface ViewController2 ()<LSBluetoothManagerDelegate,DateTimePickerViewDelegate>
{
    LSBluetoothManager *manager;
    CBPeripheral * connectedperipheral;
    NSInteger selIndex;  //选择哪一种操作记录下标
    NSMutableArray *historyArr;
    NSString *startTime;
    NSString *endTime;
    NSString *hourMin;
    UITextView   *sendTextView;
    NSString     *sendTextContent;
    UITextView   *textView;
    NSString     *textContent;
}

@property (nonatomic ,strong) LPPickView *pickerView;

@end

@implementation ViewController2

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    manager =  [LSBluetoothManager openBluetoothAdapter];
    manager.delegate = self;
    historyArr = [NSMutableArray array];
   
    if ([manager onBluetoothAdapterStateChange]) {
        NSLog(@"open");
    }else {
        NSLog(@"close");
    }
    [self createView];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [manager closeBLEConnect:self.blueToothModel.peripheral];
}

- (void)createView {
    
    for (UIView *views in self.view.subviews) {
        if ([views isKindOfClass:[UIButton class]] || [views isKindOfClass:[UITextView class]]) {
            [views removeFromSuperview];
        }
    }
    CGFloat width = (kScreenWidth - 75)/2;
    CGFloat height = 50;
    NSArray *arr2 = @[@"Connect"];
    NSArray *arr = @[@"Disconnect",
                     @"Start measuring",
                     @"End measurement",
                     @"Sending time",
                     @"Set volume",
                     @"Get volume",
                     @"Obtaining power",
                     @"Obtain historical data",
                     @"Delete historical data",
                     @"Set reminders",
                     @"Delete reminder",
                     @"Interrupt History"];
    
    if (self.blueToothModel.peripheral.state == CBPeripheralStateConnected) {
        for (int i=0; i<arr.count; i++) {
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15+(width+15)*(i%2), kNewNavHeight + (height + 15)*(i/2), width, height)];
            [button setTitle:arr[i] forState:UIControlStateNormal];
            [button setTintColor:[UIColor blackColor]];
            [button setBackgroundColor:[UIColor orangeColor]];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.tag = 99+i;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
    } else {
        for (int i=0; i<arr2.count; i++) {
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15+(width+15)*(i%2), kNewNavHeight + (height + 15)*(i/2), width, height)];
            [button setTitle:arr2[i] forState:UIControlStateNormal];
            [button setTintColor:[UIColor blackColor]];
            [button setBackgroundColor:[UIColor orangeColor]];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.tag = 98;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
    }
    
    sendTextView = [[UITextView alloc] initWithFrame:CGRectMake(30, kScreenHeight- 180 - 150, kScreenWidth-60, 130)];
    sendTextView.textColor = [UIColor blackColor];
    sendTextView.font = [UIFont systemFontOfSize:14];
    sendTextView.text = textContent;
    sendTextView.layer.borderWidth = 1;
    sendTextView.layer.borderColor = [UIColor blackColor].CGColor;
    sendTextView.layer.cornerRadius = 5;
    sendTextView.layoutManager.allowsNonContiguousLayout = NO;
    [self.view addSubview:sendTextView];
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(30, kScreenHeight- 180, kScreenWidth-60, 130)];
    textView.textColor = [UIColor blackColor];
    textView.font = [UIFont systemFontOfSize:14];
    textView.text = textContent;
    textView.layer.borderWidth = 1;
    textView.layer.borderColor = [UIColor blackColor].CGColor;
    textView.layer.cornerRadius = 5;
    textView.layoutManager.allowsNonContiguousLayout = NO;
    [self.view addSubview:textView];
}

- (void)buttonAction:(UIButton *)button{
    
    if (button.tag == 98) {
        [manager createBLEConnect:self.blueToothModel.peripheral];
    } else if (button.tag == 99) {
        [manager closeBLEConnect:self.blueToothModel.peripheral];
    } else if (button.tag == 100) {
        [self LEDMode:button];
    } else if (button.tag == 101){
        [self getVersion:button];
    } else if (button.tag == 102){
        [self setTime:button];
    } else if (button.tag == 103){
        [self getBattery:button];
    } else if (button.tag == 104){
        [self getCurrentVolume:button];
    } else if (button.tag == 105){
        [self setSentive:button];
    } else if (button.tag == 106){
        [self getSentive:button];
    } else if (button.tag == 107){
        [self getAction:button];
    } else if (button.tag == 108){
        [self setLEDTime:button];
    } else if (button.tag == 109){
        [self clearData:button];
    } else if (button.tag == 110){
        [self clearData:button];
    }
}


//开始测量
- (void)LEDMode:(UIButton *)sender {
    selIndex = 1;
    [manager startMeasuring];
}


//结束测量
- (void)getVersion:(UIButton *)sender {
    selIndex = 2;
    [manager stopMeasuring];
}

//发送时间
- (void)setTime:(UIButton *)sender {
    TCDatePickerView *picker = [[TCDatePickerView alloc] init];
    picker.delegate = self;
    picker.titleL.text = @"Sending time";
    picker.pickerViewMode = DatePickerViewDateTimeMode;
    [self.view addSubview:picker];
    [picker showDateTimePickerView];
    selIndex = 3;
}

-(NSString *)getCurrentDateTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyyMMdd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:date];
    return dateTime;
}

//设置音量
- (void)getBattery:(UIButton *)sender {
    self.pickerView = [[LPPickView alloc]init];
    self.pickerView.type = 2;
    self.pickerView.sexArr = @[@"0",@"1",@"2",@"3"];
    __block ViewController2 *strongBlock = self;
    self.pickerView.config = ^(NSString *name,NSString *idStr) {
        strongBlock->selIndex = 4;
        [strongBlock->manager setVol:idStr.integerValue-1];
    };
    [self.view addSubview:self.pickerView];
}

//获取电量
- (void)setSentive:(UIButton *)sender {
    selIndex = 5;
    [manager getBattery];
}

//获取用户1/用户2历史数据
- (void)getSentive:(UIButton *)sender {
    self.pickerView = [[LPPickView alloc]init];
    self.pickerView.type = 2;
    self.pickerView.sexArr = @[@"user 1",@"user 2"];
    __block ViewController2 *strongBlock = self;
    self.pickerView.config = ^(NSString *name,NSString *idStr) {
        strongBlock->selIndex = 6;
        [strongBlock->manager getHistoryData:idStr.integerValue==1?1:2];
    };
    [self.view addSubview:self.pickerView];
}

//删除历史数据
- (void)getAction:(UIButton *)sender {
    selIndex = 7;
    [manager clearHistoryData];
}

//设置提醒任务
- (void)setLEDTime:(UIButton *)sender {
    selIndex = 8;
    [self selTime];
}

//获取当前音量
- (void)getCurrentVolume:(id)sender {
    selIndex = 9;
    [manager getVol];
}

//取消提醒任务
- (void)clearData:(UIButton *)sender {
    selIndex = 10;
    [manager cancelRemindTask];
}

//APP主动发送历史数据中断指令
- (void)interruptHistory:(UIButton *)sender {
    selIndex = 11;
    [manager InterruptHistory];
}


//启动测量 发送1 成功 0失败
- (void)onStartMeasurStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Start measuring success"];
    } else {
        [self sendTextAddStr:@"send Start measuring fail"];
    }
}

//停止测量 发送1 成功 0失败
- (void)onStopMeasurStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send End measurement success"];
    } else {
        [self sendTextAddStr:@"send End measurement fail"];
    }
}

//设置音量 发送1 成功 0失败
- (void)onSetVolumeStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Set volume success"];
    } else {
        [self sendTextAddStr:@"send Set volume fail"];
    }
}

//查询音量 发送1 成功 0失败
- (void)onQueryVolumeStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Get volume success"];
    } else {
        [self sendTextAddStr:@"send Get volume fail"];
    }
}

//设置时间 发送1 成功 0失败
- (void)onSendDateStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Sending time success"];
    } else {
        [self sendTextAddStr:@"send Sending time fail"];
    }
}

//查询电量 发送1 成功 0失败
- (void)onQueryBatteryStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Obtaining power success"];
    } else {
        [self sendTextAddStr:@"send Obtaining power fail"];
    }
}

//查询历史记录 发送1 成功 0失败
- (void)onQueryHistoryDataStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Obtain historical data success"];
    } else {
        [self sendTextAddStr:@"send Obtain historical data fail"];
    }
}

//清除历史记录 发送1 成功 0失败
- (void)onClearHistoryDataStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Delete historical data success"];
    } else {
        [self sendTextAddStr:@"send Delete historical data fail"];
    }
}

//中断历史记录 发送1 成功 0失败
- (void)onStopHistoryDataStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Interrupt History success"];
    } else {
        [self sendTextAddStr:@"send Interrupt History fail"];
    }
}

//发送ack发送1 成功 0失败
- (void)onSendAckChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send ACK success"];
    } else {
        [self sendTextAddStr:@"send ACK fail"];
    }
}

//设置任务提醒发送1 成功  0失败
- (void)onUpdateRemindTaskStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Set reminders success"];
    } else {
        [self sendTextAddStr:@"send Set reminders fail"];
    }
}

//取消任务提醒发送1 成功  0失败
- (void)onCancelRemindTaskStateChanged:(int)status{
    if (status==1) {
        [self sendTextAddStr:@"send Delete reminder success"];
    } else {
        [self sendTextAddStr:@"send Delete reminder fail"];
    }
}

//历史测量数据
- (void)onHistoryData:(HistoryModel *_Nullable)model{
    NSString *str = [NSString stringWithFormat:@"systolicPressure:%ld diastolicPressure:%ld heartRate:%ld atrialFibrillationStatus:%ld IrregularHeartRateState：%ld arteriosclerosisStatus：%ld user id:%ld time：20%ld-%ld-%ld %ld:%ld:%ld measurementStatus:%ld electricityLevel：%ld bluetoothSignalStrength：%ld    ",model.systolicPressure,model.diastolicPressure,model.heartRate,model.atrialFibrillationStatus,model.IrregularHeartRateState,model.arteriosclerosisStatus,model.userId,model.year,model.month,model.day,model.hour,model.minute,model.second,model.measurementStatus,model.electricityLevel,model.bluetoothSignalStrength];
    [self textAddStr:[NSString stringWithFormat:@"measurement result ：%@",str]];
}

//当前测量数据
- (void)onMeasurData:(HistoryModel *_Nullable)model{
    NSString *str = [NSString stringWithFormat:@"systolicPressure:%ld diastolicPressure:%ld heartRate:%ld atrialFibrillationStatus:%ld IrregularHeartRateState：%ld arteriosclerosisStatus：%ld user id:%ld time：20%ld-%ld-%ld %ld:%ld:%ld measurementStatus:%ld electricityLevel：%ld bluetoothSignalStrength：%ld    ",model.systolicPressure,model.diastolicPressure,model.heartRate,model.atrialFibrillationStatus,model.IrregularHeartRateState,model.arteriosclerosisStatus,model.userId,model.year,model.month,model.day,model.hour,model.minute,model.second,model.measurementStatus,model.electricityLevel,model.bluetoothSignalStrength];
    [self textAddStr:[NSString stringWithFormat:@"History：%@",str]];
}

//当前电量
- (void)onBattery:(int)battery{
    [self textAddStr:[NSString stringWithFormat:@"Electricity level：%d",battery]];
}

//当前音量
- (void)onVolume:(int)volume{
    [self textAddStr:[NSString stringWithFormat:@"volume：%d",volume]];
}

//当前压力值
- (void)onMeasurPressureValue:(int)value{
    [self textAddStr:[NSString stringWithFormat:@"Current pressure：%d",value]];
    
}

//当前错误信息
- (void)onError:(NSError *_Nullable)error{
    
}

- (void)sendTextAddStr:(NSString *)str {
    
    if (sendTextContent.length>0) {
        sendTextContent = [NSString stringWithFormat:@"%@\n%@",sendTextContent,str];
    } else {
        sendTextContent = str;
    }
    sendTextView.text = sendTextContent;
    [sendTextView scrollRangeToVisible:NSMakeRange(sendTextView.text.length, 1)];
}

- (void)textAddStr:(NSString *)str {
    
    if (textContent.length>0) {
        textContent = [NSString stringWithFormat:@"%@\n%@",textContent,str];
    } else {
        textContent = str;
    }
    textView.text = textContent;
    [textView scrollRangeToVisible:NSMakeRange(textView.text.length, 1)];
}



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


#pragma mark -- DateTimePickerViewDelegate
- (void)didClickFinishDateTimePickerView:(NSString *)date{
    if (selIndex == 3) {
        NSString *dateTime = date;
        [manager sendDate:dateTime];
    } else {
        if (selIndex == 100) {
            startTime = date;
            [self selTime2];
        } else if (selIndex == 200) {
            endTime = date;
            [self selTime3];
        } else {
            hourMin = date;
            [manager setRemindTask:startTime endTime:endTime hourTime:hourMin];
        }
    }

}

//发送时间
- (void)selTime {
    TCDatePickerView *picker = [[TCDatePickerView alloc] init];
    picker.delegate = self;
    picker.titleL.text = @"start time";
    picker.pickerViewMode = DatePickerViewDateMode;
    [self.view addSubview:picker];
    [picker showDateTimePickerView];
    selIndex = 100;
}

- (void)selTime2 {
    TCDatePickerView *picker = [[TCDatePickerView alloc] init];
    picker.delegate = self;
    picker.titleL.text = @"end time";
    picker.pickerViewMode = DatePickerViewDateMode;
    [self.view addSubview:picker];
    [picker showDateTimePickerView];
    selIndex = 200;
}

- (void)selTime3 {
    TCDatePickerView *picker = [[TCDatePickerView alloc] init];
    picker.delegate = self;
    picker.titleL.text = @"hour";
    picker.pickerViewMode = DatePickerViewTimeMode;
    [self.view addSubview:picker];
    [picker showDateTimePickerView];
    selIndex = 300;
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
