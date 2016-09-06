//
//  HCChooseCityViewController.h
//  ChooseCityDemo
//
//  Created by Jentle on 15/9/1.
//  Copyright © 2015年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HCCityListModel.h"
#import "HCProvinceModel.h"
typedef void(^ChooseCityBlock)(HCCityListModel *);
@interface HCChooseCityViewController : UIViewController
@property (copy, nonatomic) ChooseCityBlock chooseCityBlock;
/** 定位城市的选择 */
@property(copy, nonatomic) void(^chooseLocateCityBlock)(HCProvinceModel *);
@end
