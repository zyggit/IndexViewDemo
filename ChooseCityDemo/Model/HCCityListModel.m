//
//  HCCityListModel.m
//  ChooseCityDemo
//
//  Created by Jentle on 15/9/1.
//  Copyright © 2015年 Jentle. All rights reserved.
//

#import "HCCityListModel.h"

@implementation HCCityListModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _city_id = [NSString stringWithFormat:@"%@", value];
    }
}
@end
