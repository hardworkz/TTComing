//
//  ZOrderDetailAddressTableViewCell.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/25.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZOrderDetailAddressTableViewCell.h"

@interface ZOrderDetailAddressTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *name;

@property (nonatomic, strong) UILabel *phone;

@property (nonatomic, strong) UILabel *address;

@property (nonatomic, strong) UIView *devider;

@end
@implementation ZOrderDetailAddressTableViewCell
- (void)z_setupViews {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.phone];
    [self.contentView addSubview:self.address];
    [self.contentView addSubview:self.devider];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)updateConstraints {
    
    WS(weakSelf)
    
    CGFloat paddingEdge = 10;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(paddingEdge);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(-MARGIN_10);
        make.centerY.equalTo(weakSelf.titleLabel);
    }];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.contentView);
        make.centerY.equalTo(weakSelf.titleLabel);
    }];
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(-MARGIN_10);
        make.bottom.equalTo(weakSelf.contentView).offset(-MARGIN_10);
    }];
    [self.devider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(paddingEdge);
        make.trailing.equalTo(0);
        make.bottom.equalTo(weakSelf.contentView);
        make.height.equalTo(0.5);
    }];
    
    [super updateConstraints];
    
}
- (void)setViewModel:(ZOrderDetailCenterTableViewCellViewModel *)viewModel {
    
    if (!viewModel) {
        return;
    }
    
    _viewModel = viewModel;
    
}

#pragma mark - lazyLoad
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = MAIN_TEXT_COLOR;
        _titleLabel.font = SYSTEM_FONT(15);
        _titleLabel.text = @"买家留言";
    }
    return _titleLabel;
}
- (UILabel *)name {
    
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.textColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _name.font = SYSTEM_FONT(13);
        _name.textAlignment = NSTextAlignmentCenter;
        _name.text = @"哈哈哈";
    }
    return _name;
}
- (UILabel *)phone {
    
    if (!_phone) {
        _phone = [[UILabel alloc] init];
        _phone.textColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _phone.font = SYSTEM_FONT(13);
        _phone.textAlignment = NSTextAlignmentRight;
        _phone.text = @"18888888888";
    }
    return _phone;
}
- (UILabel *)address {
    
    if (!_address) {
        _address = [[UILabel alloc] init];
        _address.textColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _address.font = SYSTEM_FONT(13);
        _address.textAlignment = NSTextAlignmentRight;
        _address.text = @"福建省厦门市思明区哈哈哈哈哈哈哈哈哈哈哈";
    }
    return _address;
}
- (UIView *)devider
{
    if (!_devider) {
        _devider = [[UIView alloc] init];
        _devider.backgroundColor = lightGray_color;
    }
    return _devider;
}

@end
