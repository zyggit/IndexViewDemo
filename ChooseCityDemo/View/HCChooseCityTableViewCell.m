//
//  HCChooseCityTableViewCell.m
//  HelperCar
//
//  Created by Jentle on 15/9/1.
//  Copyright © 2015年 Jentle. All rights reserved.
//

#import "HCChooseCityTableViewCell.h"
#import "HCCommonTool.h"

@interface HCChooseCityTableViewCell ()
@property (strong, nonatomic) UILabel *nameLabel;
@end

@implementation HCChooseCityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [HCCommonTool colorWithHexColorString:@"#333333"];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ALD(kSpaceHeight));
            make.top.bottom.mas_equalTo(0);
            make.right.mas_equalTo(-ALD(kSpaceHeight));
        }];
        
        _bottomSeparatorLine = [[UIView alloc] init];
        _bottomSeparatorLine.backgroundColor = [HCCommonTool colorWithHexColorString:@"#e2e2e2"];
        [self.contentView addSubview:_bottomSeparatorLine];
        [_bottomSeparatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(_nameLabel);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)setModel:(HCProvinceModel *)model
{
    _model = model;
    _nameLabel.text = model.title;
}

@end
