//
//  HCProvinceModel.m
//  ChooseCityDemo
//
//  Created by Jentle on 15/9/1.
//  Copyright © 2015年 Jentle. All rights reserved.
//

#import "HCProvinceModel.h"

@implementation HCProvinceModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _provinceID = [NSString stringWithFormat:@"%@", value];
    }
}
@end
