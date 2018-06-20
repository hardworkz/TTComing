//
//  ZMyTableViewCell.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/5.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZMyTableViewCell.h"

@interface ZMyTableViewCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *icon;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *arrow;

@property (nonatomic, strong) UIView *devider;

@end
@implementation ZMyTableViewCell
- (void)z_setupViews {
    self.backgroundColor = MAIN_LIGHT_LINE_COLOR;
    
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.icon];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.devider];
    [self.bgView addSubview:self.arrow];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)updateConstraints {
    
    WS(weakSelf)
    
    CGFloat paddingEdge = 10;
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView).insets(UIEdgeInsetsMake(0, 10, 0, 10));
    }];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgView).offset(paddingEdge + 5);
        make.bottom.equalTo(weakSelf.bgView).offset(-paddingEdge - 5);
        make.left.equalTo(weakSelf.bgView).offset(paddingEdge);
        make.size.equalTo(CGSizeMake(20, 20));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView).offset(30 + 10);
        make.centerY.equalTo(weakSelf.bgView);
        make.size.equalTo(CGSizeMake(80, 50));
    }];
    [self.devider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.bgView);
        make.left.equalTo(weakSelf.bgView).offset(paddingEdge);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
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

    self.devider.hidden = viewModel.hideDevider;
    
    //设置圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, SCREEN_WIDTH - 20, 50)      byRoundingCorners:self.viewModel.rectCorner    cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH - 20, 50);
    maskLayer.path = maskPath.CGPath;
    self.bgView.layer.mask = maskLayer;
}

#pragma mark - lazyLoad
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = white_color;
    }
    return _bgView;
}
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
        _titleLabel.font = SYSTEM_FONT(17);
    }
    return _titleLabel;
}
- (UIImageView *)arrow
{
    if (!_arrow) {
        _arrow = [[UIImageView alloc] init];
        _arrow.contentMode = UIViewContentModeCenter;
    }
    return _icon;
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
