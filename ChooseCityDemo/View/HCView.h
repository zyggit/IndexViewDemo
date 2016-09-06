//
//  HCView.h
//  HelperCar
//
//  Created by Jentle on 15/9/1.
//  Copyright © 2015年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TouchBeginBlock)(void);
@interface HCView : UIView
@property (copy, nonatomic) TouchBeginBlock touchBeginBlock;
@end
