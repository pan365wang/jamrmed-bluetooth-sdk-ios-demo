
#import "ViewController.h"
#import <BPMBluetooth/LSBluetoothManager.h>
#import "ViewController2.h"

#define kScreenHeight     [UIScreen mainScreen].bounds.size.height
#define kScreenWidth      [UIScreen mainScreen].bounds.size.width
#define kNewNavHeight     (CGFloat)(kIs_iPhoneX?(88.0):(64.0))
#define kIs_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIs_iPhoneX kScreenWidth >=375.0f && kScreenHeight >=812.0f&& kIs_iphone

@interface ViewController ()<LSBluetoothManagerDelegate,UITableViewDelegate,UITableViewDataSource> {
    
    UITextField *contentTextField;
}
@property (strong, nonatomic) LSBluetoothManager *manager;
@property (strong, nonatomic) NSMutableArray<LSBluetoothModel *> *peripheralsArr;
@property (nonatomic ,strong) UITableView  *myCareTab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   self.manager.delegate = self;
    [self.myCareTab reloadData];
}

-(void)initUI {
    self.title = NSLocalizedString(@"捷美瑞血压计Demo", nil);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Refresh_64px"] style:UIBarButtonItemStylePlain target:self action:@selector(refreshDeviceList)];
        
    contentTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 10, kScreenWidth-220, 43)];
    contentTextField.keyboardType = UIKeyboardTypeDefault;
    contentTextField.placeholder = @"search for devices";
//    contentTextField.delegate = self;
    contentTextField.font = [UIFont systemFontOfSize:14];
    contentTextField.textColor = [UIColor blackColor];
    contentTextField.layer.borderWidth = 1;
    contentTextField.layer.borderColor = [UIColor blackColor].CGColor;
    contentTextField.layer.cornerRadius = 43/2;
    contentTextField.textAlignment = NSTextAlignmentCenter;
    contentTextField.text = @"BPM";
//    [contentTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:contentTextField];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-150, 10, 60, 43)];
    [button setTitle:@"search" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor orangeColor]];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-80, 10, 60, 43)];
    [button2 setTitle:@"stop" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 setBackgroundColor:[UIColor orangeColor]];
    button2.titleLabel.font = [UIFont systemFontOfSize:14];
    [button2 addTarget:self action:@selector(stopAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    [self.view addSubview:self.myCareTab];
}


- (void)initData {
    self.peripheralsArr = [NSMutableArray array];
    self.manager =  [LSBluetoothManager openBluetoothAdapter];
    self.manager.delegate = self;
//    [self.manager startBluetoothDevicesDiscovery:contentTextField];
}

-(void)refreshDeviceList {
    [self.peripheralsArr removeAllObjects];
    [self.myCareTab reloadData];
    [self.manager startBluetoothDevicesDiscovery:contentTextField.text.uppercaseString];
}

- (void)searchAction{
    [self stopAction];
    [self.peripheralsArr removeAllObjects];
    [self.myCareTab reloadData];
    [self.manager startBluetoothDevicesDiscovery:contentTextField.text.uppercaseString];
    
}

- (void)stopAction{
    [self.manager stopBluetoothDevicesDiscovery];
    [self.peripheralsArr removeAllObjects];
    [self.myCareTab reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.peripheralsArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSBluetoothModel *model = self.peripheralsArr[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.text = model.peripheral.name;
    if (model.peripheral.state == CBPeripheralStateConnected) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@,Connected, click to disconnect",model.RSSI];
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@,Not connected, click to connect",model.RSSI];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSLog(@"%@",model.advertisementData);
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.manager stopBluetoothDevicesDiscovery];
    LSBluetoothModel *model = self.peripheralsArr[indexPath.row];
    ViewController2 *vc = [[ViewController2 alloc] init];
    vc.blueToothModel = model;
    [self.navigationController pushViewController:vc animated:YES];
//    if (model.peripheral.state != CBPeripheralStateConnected) {
//        [self.manager conect:model.peripheral];
//        [self.navigationController pushViewController:[ViewController2 new] animated:YES];
//    }else if (model.peripheral.state == CBPeripheralStateConnected) {
//        [self.manager disconect:model.peripheral];
//    }
    
    
}


- (void)manager:(LSBluetoothManager *)manager didDiscoverDeveice:(nonnull LSBluetoothModel *)peripheral error:(nullable NSError *)error {
    
    BOOL isSave = false;
    for (LSBluetoothModel *model in self.peripheralsArr) {
        if (model.peripheral.name == peripheral.peripheral.name) {
            isSave = true;
        }
    }
    if (!isSave) {
        [self.peripheralsArr addObject:peripheral];
    }
    [self.myCareTab reloadData];
}

- (void)manager:(LSBluetoothManager *)manager connectedDevice:(CBPeripheral *)peripheral state:(BOOL)state {
    NSLog(@"connectedDevicestate %d",state);
    NSString *title = @"";
    [self.myCareTab reloadData];
    if (state == NO) {
        title = [NSString stringWithFormat:@"%@断开连接",peripheral.name];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
        [alert show];
    } else {
        [self.myCareTab reloadData];
    }
    
    
}

#pragma mark -- Private Methods
#pragma mark -- setter
-(UITableView *)myCareTab{
    if (!_myCareTab) {
        _myCareTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 63, kScreenWidth, kScreenHeight-kNewNavHeight-63) style:UITableViewStyleGrouped];
        _myCareTab.backgroundColor = [UIColor clearColor];
        _myCareTab.delegate = self;
        _myCareTab.dataSource = self;
        _myCareTab.showsVerticalScrollIndicator=NO;
        _myCareTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_myCareTab setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        
    }
    return _myCareTab;
}
@end
