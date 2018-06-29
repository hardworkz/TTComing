//
//  ZMyTableViewCell.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/5.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZMyTableViewCell.h"

@interface ZMyTableViewCell ()

@property (nonatomic, strong) UIImageView *icon;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *arrow;

@property (nonatomic, strong) UIView *devider;

@end
@implementation ZMyTableViewCell
- (void)z_setupViews {
    
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.devider];
    [self.contentView addSubview:self.arrow];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)updateConstraints {
    
    WS(weakSelf)
    
    CGFloat paddingEdge = 10;
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.leading.equalTo(weakSelf.contentView).offset(paddingEdge);
        make.size.equalTo(CGSizeMake(20, 20));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.icon.mas_trailing).offset(MARGIN_5);
        make.trailing.equalTo(weakSelf.arrow.mas_leading).offset(-MARGIN_10);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(-MARGIN_5);
        make.centerY.equalTo(weakSelf.contentView);
        make.width.equalTo(20);
    }];
    [self.devider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.titleLabel.mas_leading);
        make.trailing.equalTo(-MARGIN_10);
        make.bottom.equalTo(weakSelf.contentView);
        make.height.equalTo(1);
    }];
    
    [super updateConstraints];
    
}
- (void)setViewModel:(ZMyTableViewCellViewModel *)viewModel {
    
    if (!viewModel) {
        return;
    }
    
    _viewModel = viewModel;
    
    self.titleLabel.text = viewModel.title;
    
    self.icon.image = ImageNamed(viewModel.icon);
}

#pragma mark - lazyLoad
- (UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.contentMode = UIViewContentModeCenter;
    }
    return _icon;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = MAIN_TEXT_COLOR;
        _titleLabel.font = SYSTEM_FONT(15);
    }
    return _titleLabel;
}
- (UIImageView *)arrow
{
    if (!_arrow) {
        _arrow = [[UIImageView alloc] initWithImage:ImageNamed(@"三角箭头")];
        _arrow.contentMode = UIViewContentModeCenter;
    }
    return _arrow;
}
- (UIView *)devider
{
    if (!_devider) {
        _devider = [[UIView alloc] init];
        _devider.backgroundColor = MAIN_LINE_COLOR;
    }
    return _devider;
}
@end
