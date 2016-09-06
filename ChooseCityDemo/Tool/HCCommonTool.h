//
//  HCCommonTool.h
//  HelperCar
//
//  Created by Jentle on 15/9/1.
//  Copyright © 2015年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCCommonTool : NSObject

/**
 *  字符串转色值
 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString;
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString alpha:(float)alpha;

@end
