//
//  LPPickView.h
//  LearningPlatform
//
//  Created by a on 2020/11/29.
//  Copyright © 2020 a. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^sureButtonClick) (NSString *name,NSString *idStr);

@interface LPPickView : UIView

@property (nonatomic ,strong)NSString *bankStr;

///售后类型
@property (nonatomic, strong) NSArray *applyArr1;
///sex
@property (nonatomic, strong) NSArray *sexArr;
///退款原因
@property (nonatomic, strong) NSArray *applyArr2;
///快递类型
@property (nonatomic, strong) NSArray *kdArr;
/// 1:售后类型 2.性别  3.退款原因 4.快递类型
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) UIPickerView *bankPickerView;/** 银行选择器 */

@property (nonatomic, copy) sureButtonClick config;

@end

NS_ASSUME_NONNULL_END
