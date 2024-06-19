//
//  LPPickView.m
//  LearningPlatform
//
//  Created by a on 2020/11/29.
//  Copyright © 2020 a. All rights reserved.
//

#import "LPPickView.h"

static CGFloat bgViewHeith = 240;
static CGFloat cityPickViewHeigh = 200;
static CGFloat toolsViewHeith = 40;
static CGFloat animationTime = 0.25;
#define kScreenHeight     [UIScreen mainScreen].bounds.size.height
#define kScreenWidth      [UIScreen mainScreen].bounds.size.width
#define kNewNavHeight     (CGFloat)(kIs_iPhoneX?(88.0):(64.0))
#define kIs_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIs_iPhoneX kScreenWidth >=375.0f && kScreenHeight >=812.0f&& kIs_iphone
#define APP_FONT(f)                 [UIFont boldSystemFontOfSize:f]

@interface LPPickView()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIButton *sureButton;        /** 确认按钮 */
@property (nonatomic, strong) UIButton *canselButton;      /** 取消按钮 */
@property (nonatomic, strong) UIView *toolsView;           /** 自定义标签栏 */
@property (nonatomic, strong) UIView *bgView;              /** 背景view */
@property (nonatomic ,strong) UILabel *titleLab;           /** 标题  **/
@property (nonatomic ,strong) NSString *sel_id;


@end

@implementation LPPickView

- (instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.toolsView];
    [self.toolsView addSubview:self.canselButton];
    [self.toolsView addSubview:self.sureButton];
    [self.toolsView addSubview:self.titleLab];
    
    [self.bgView addSubview:self.bankPickerView];
    
    [self showPickView];
}


#pragma event menthods
- (void)canselButtonClick{
    [self hidePickView];
 
}

- (void)sureButtonClick{
    [self hidePickView];
    if (self.config) {
        self.config(self.bankStr,self.sel_id);
    }
}

#pragma mark private methods
- (void)showPickView{
    [UIView animateWithDuration:animationTime animations:^{
        self.bgView.frame = CGRectMake(0, self.frame.size.height - bgViewHeith, self.frame.size.width, bgViewHeith);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidePickView{
    
    [UIView animateWithDuration:animationTime animations:^{
        self.bgView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, bgViewHeith);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - pickerViewDatasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.type==1) {
        return self.applyArr1.count;
    } else if (self.type==2){
        return self.sexArr.count;
    } else if (self.type==3){
        return self.applyArr2.count;
    } else if (self.type==4){
        return self.kdArr.count;
    }
    return 0;
}

#pragma mark - pickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/3.0, 30)];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    if (self.type==1) {
        label.text = [self.applyArr1[row] objectForKey:@"label"];
        self.bankStr = [self.applyArr1[0] objectForKey:@"label"];
        self.sel_id = [self.applyArr1[0] objectForKey:@"value"];
    } else if (self.type==2){
        label.text = self.sexArr[row];
        self.bankStr = self.sexArr[0];
        self.sel_id = [NSString stringWithFormat:@"%ld",(long)(row + 1)];
    } else if (self.type==3){
        label.text = [self.applyArr2[row] objectForKey:@"label"];
        self.bankStr = [self.applyArr2[0] objectForKey:@"label"];
        self.sel_id = [self.applyArr2[0] objectForKey:@"value"];
    }  else if (self.type==4){
        label.text = [self.kdArr[row] objectForKey:@"name"];
        self.bankStr = [self.kdArr[0] objectForKey:@"name"];
        self.sel_id = [self.kdArr[0] objectForKey:@"id"];
    }
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.type==1) {
        self.bankStr = [self.applyArr1[row] objectForKey:@"label"];
        self.sel_id = [self.applyArr1[row] objectForKey:@"value"];
    } else if (self.type==2){
        self.bankStr = self.sexArr[row];
        self.sel_id = [NSString stringWithFormat:@"%ld",(long)(row + 1)];
    } else if (self.type==3){
        self.bankStr = [self.applyArr2[row] objectForKey:@"label"];
        self.sel_id = [self.applyArr2[row] objectForKey:@"value"];
    } else if (self.type==4){
        self.bankStr = [self.kdArr[row] objectForKey:@"name"];
        self.sel_id = [self.kdArr[row] objectForKey:@"id"];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([touches.anyObject.view isKindOfClass:[self class]]) {
        [self hidePickView];
    }
}

#pragma mark - lazy

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, bgViewHeith)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UIPickerView *)bankPickerView{
    if (!_bankPickerView) {
        _bankPickerView = ({
            UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, toolsViewHeith, self.frame.size.width, cityPickViewHeigh)];
            pickerView.backgroundColor = [UIColor whiteColor];
            pickerView.delegate = self;
            pickerView.dataSource = self;
            pickerView;
        });
    }
    return _bankPickerView;
}

- (UIView *)toolsView{
    
    if (!_toolsView) {
        _toolsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, toolsViewHeith)];
        _toolsView.layer.borderWidth = 0.5;
    }
    return _toolsView;
}
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, kScreenWidth - 100, 20)];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.font = APP_FONT(14);
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}
- (UIButton *)canselButton{
    if (!_canselButton) {
        _canselButton = ({
            UIButton *canselButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, 70, toolsViewHeith)];
            [canselButton setTitle:@"取消" forState:UIControlStateNormal];
            [canselButton setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
            [canselButton addTarget:self action:@selector(canselButtonClick) forControlEvents:UIControlEventTouchUpInside];
            canselButton;
        });
    }
    return _canselButton;
}

- (UIButton *)sureButton{
    if (!_sureButton) {
        _sureButton = ({
            UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 20 - 50, 0, 50, toolsViewHeith)];
            [sureButton setTitle:@"确定" forState:UIControlStateNormal];
            [sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
            sureButton;
        });
    }
    return _sureButton;
}

@end
