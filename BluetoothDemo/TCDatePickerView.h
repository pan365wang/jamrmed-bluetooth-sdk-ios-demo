//
//  TCDatePickerView.h
//  TonzeCloud
//
//  Created by vision on 17/3/1.
//  Copyright © 2017年 tonze. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    DatePickerViewDateTimeMode,//年月日,时分
    DatePickerViewDateMode,//年月日
    DatePickerViewTimeMode,//时分
    DatePickerViewDateTimeModeSecond,//年月日,时分秒

} DatePickerViewMode;


@protocol DateTimePickerViewDelegate <NSObject>

@optional

/**

 * 确定按钮

 */

-(void)didClickFinishDateTimePickerView2:(NSString*)date;

/**

 * 取消按钮

 */

-(void)didClickCancelDateTimePickerView;


@end



@interface TCDatePickerView : UIView

/**

 * 设置当前时间

 */

@property(nonatomic, strong)NSDate*currentDate;

/**

 * 设置中心标题文字

 */

@property(nonatomic, strong)UILabel *titleL;


@property(nonatomic, strong)id<DateTimePickerViewDelegate>delegate;

/**

 * 模式

 */

@property (nonatomic, assign) DatePickerViewMode pickerViewMode;



/**

 * 掩藏

 */

- (void)hideDateTimePickerView;

/**

 * 显示

 */

- (void)showDateTimePickerView;



@end
