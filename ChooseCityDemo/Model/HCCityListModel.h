//
//  HCCityListModel.h
//  ChooseCityDemo
//
//  Created by Jentle on 15/9/1.
//  Copyright © 2015年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCCityListModel : NSObject
@property (strong, nonatomic) NSString *city_id; // 城市ID
@property (strong, nonatomic) NSString *parent_id; // 省份ID
@property (strong, nonatomic) NSString *region_name; // 区域名字
@property (strong, nonatomic) NSString *region_type; // 区域类型
@end
