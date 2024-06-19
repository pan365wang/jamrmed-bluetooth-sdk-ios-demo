

#import <UIKit/UIKit.h>
#import <BPMBluetooth/LSBluetoothManager.h>

@interface ViewController2 : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *readLabel;

@property (nonatomic, strong) LSBluetoothModel *blueToothModel;

@end
