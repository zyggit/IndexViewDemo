//
//  HCProvinceModel.h
//  ChooseCityDemo
//
//  Created by Jentle on 15/9/1.
//  Copyright © 2015年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCProvinceModel : NSObject
@property (strong, nonatomic) NSString *firstname; // 省份首字母
@property (strong, nonatomic) NSString *provinceID; // 省份ID
@property (strong, nonatomic) NSArray *list; // 市区列表
@property (strong, nonatomic) NSString *title; // 省份名
@end
