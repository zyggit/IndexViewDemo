//
//  HCChooseCityTableViewCell.h
//  HelperCar
//
//  Created by Jentle on 15/9/1.
//  Copyright © 2015年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCProvinceModel.h"
@interface HCChooseCityTableViewCell : UITableViewCell
@property (strong, nonatomic) HCProvinceModel *model;
@property (strong, nonatomic) UIView *bottomSeparatorLine; // 下分割线
@end
