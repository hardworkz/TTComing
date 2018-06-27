//
//  ZSettleCenterDistributionTableViewCell.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/21.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZSettleCenterDistributionTableViewCell.h"

@interface ZSettleCenterDistributionTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *Description;

@property (nonatomic, strong) UIImageView *rightArrow;

@property (nonatomic, strong) UIView *devider;

@end
@implementation ZSettleCenterDistributionTableViewCell
- (void)z_setupViews {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.rightArrow];
    [self.contentView addSubview:self.Description];
    [self.contentView addSubview:self.devider];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)updateConstraints {
    
    WS(weakSelf)
    
    CGFloat paddingEdge = 10;
    CGFloat labelH = 20;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(paddingEdge);
        make.bottom.equalTo(weakSelf.contentView).offset(- 5);
    }];
    [self.rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.contentView);
        make.bottom.equalTo(weakSelf.contentView);
        make.size.equalTo(CGSizeMake(20, labelH));
    }];
    [self.Description mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.titleLabel.mas_trailing).offset(paddingEdge);
        make.bottom.equalTo(weakSelf.contentView).offset(- 5);
        make.trailing.equalTo(weakSelf.rightArrow.mas_leading).offset(-paddingEdge);
    }];
    [self.devider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(paddingEdge);
        make.trailing.equalTo(0);
        make.bottom.equalTo(weakSelf.contentView);
        make.height.equalTo(0.5);
    }];
    
    [super updateConstraints];
    
}
- (void)setViewModel:(ZSettleCenterContentCellViewModel *)viewModel {
    
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
        _titleLabel.text = @"配送方式";
    }
    return _titleLabel;
}
- (UILabel *)Description {
    
    if (!_Description) {
        _Description = [[UILabel alloc] init];
        _Description.textColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _Description.font = SYSTEM_FONT(15);
        _Description.textAlignment = NSTextAlignmentRight;
        _Description.text = @"快递 无包邮";
    }
    return _Description;
}
- (UIImageView *)rightArrow
{
    if (!_rightArrow) {
        _rightArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"三角箭头")];
        _rightArrow.contentMode = UIViewContentModeCenter;
    }
    return _rightArrow;
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
