//
//  HCHotCityTableViewCell.m
//  HelperCar
//
//  Created by Jentle on 15/9/1.
//  Copyright © 2015年 Jentle. All rights reserved.
//

#import "HCHotCityTableViewCell.h"

@interface HCHotCityTableViewCell()

/** 按钮背景 */
@property(weak, nonatomic) UIView *btnBg;

@end

@implementation HCHotCityTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self basicConfig];
        [self initCellComponents];
        [self setNeedsUpdateConstraints];
        
    }
    return self;
}

- (void)basicConfig{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

/**
 *  初始化子控件
 */
- (void)initCellComponents{
    UIView *btnBg = [[UIView alloc] init];
    btnBg.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:btnBg];
    _btnBg = btnBg;
}

/**
 *  布局子控件
 */
- (void)updateConstraints{
    [super updateConstraints];
    [_btnBg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(ALD(kSpaceHeight));
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-ALD(20));
        make.bottom.equalTo(self.contentView).offset(-ALD(30));
    }];
}

- (void)setHotCityArray:(NSArray *)hotCityArray
{
    if (_hotCityArray == nil) { // 防止按钮多次添加
        _hotCityArray = hotCityArray;
        // 计算按钮间隔
        CGFloat width = ALD(120);
        CGFloat estimite = (kScreenWidth - ALD(20) - 5 * width) / 4;
        
        for (int i = 0; i < _hotCityArray.count; i++) {
            HCCityListModel *model = _hotCityArray[i];
            UILabel *hotAreaLabel = [[UILabel alloc] init];
            hotAreaLabel.userInteractionEnabled = YES;
            hotAreaLabel.textAlignment = NSTextAlignmentCenter;
            hotAreaLabel.textColor = HCHexColor(@"#333333");
            hotAreaLabel.tag = 1000 + i;
            hotAreaLabel.font = [UIFont systemFontOfSize:15];
            hotAreaLabel.text = model.region_name;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [hotAreaLabel addGestureRecognizer:tap];
            NSInteger number = i / 5;
            CGFloat hotAreaLabelX = (i % 5) * (estimite + width);
            CGFloat hotAreaLabelY = number * 2*ALDHeight(30);
            CGFloat hotAreaLabelW = width;
            CGFloat hotAreaLabelH = ALD(30);
            hotAreaLabel.frame = CGRectMake(hotAreaLabelX, hotAreaLabelY, hotAreaLabelW, hotAreaLabelH);
            
            [self.btnBg addSubview:hotAreaLabel];
        }
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    HCCityListModel *model = self.hotCityArray[tap.view.tag - 1000];
    if (self.clickBtnBlock) {
        self.clickBtnBlock(model);
    }
}

@end
