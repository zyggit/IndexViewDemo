//
//  HCHotCityTableViewCell.h
//  HelperCar
//
//  Created by Jentle on 15/9/1.
//  Copyright © 2015年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCCityListModel.h"
typedef void(^ClickBtnBlock)(HCCityListModel *);
@interface HCHotCityTableViewCell : UITableViewCell
@property (strong, nonatomic) NSArray *hotCityArray; // 热门城市数组
@property (copy, nonatomic) ClickBtnBlock clickBtnBlock; // 点击城市按钮回调
@end
