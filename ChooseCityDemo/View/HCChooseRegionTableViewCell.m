//
//  HCChooseRegionTableViewCell.m
//  HelperCar
//
//  Created by Jentle on 15/9/1.
//  Copyright © 2015年 Jentle. All rights reserved.
//

#import "HCChooseRegionTableViewCell.h"


@interface HCChooseRegionTableViewCell ()
@property (strong, nonatomic) UILabel *nameLabel;
@end

@implementation HCChooseRegionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 城市名称
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [HCCommonTool colorWithHexColorString:@"#333333"];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(ALD(30));
            make.right.mas_equalTo(-ALD(30));
        }];
        
        // 下分割线
        UIView *separatorLine = [[UIView alloc] init];
        separatorLine.backgroundColor = [HCCommonTool colorWithHexColorString:@"#e2e2e2"];
        [self.contentView addSubview:separatorLine];
        [separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5f);
        }];
    }
    return self;
}

- (void)setModel:(HCCityListModel *)model
{
    _model = model;
    _nameLabel.text = model.region_name;
}


@end
