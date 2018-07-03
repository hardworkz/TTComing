//
//  ZUserCenterCell.m
//  BaseProject
//
//  Created by 泡果 on 2018/7/3.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZUserCenterCell.h"

@interface ZUserCenterCell ()

@property (nonatomic, strong) UIImageView *bgView;

@property (nonatomic, strong) UIImageView *icon;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *arrow;

@property (nonatomic, strong) UIView *devider;

@end
@implementation ZUserCenterCell
- (void)z_setupViews {
    
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.icon];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.contentLabel];
    [self.bgView addSubview:self.devider];
    [self.bgView addSubview:self.arrow];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)updateConstraints {
    
    WS(weakSelf)
    
    CGFloat paddingEdge = 10;
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView);
    }];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.leading.equalTo(weakSelf.contentView).offset(MARGIN_20);
        make.size.equalTo(CGSizeMake(20, 20));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.icon.mas_trailing).offset(MARGIN_5);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(-MARGIN_20);
        make.centerY.equalTo(weakSelf.contentView);
        make.width.equalTo(20);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(weakSelf.arrow.mas_leading).offset(-MARGIN_5);
        make.centerY.equalTo(weakSelf.contentView);
        make.leading.equalTo(weakSelf.titleLabel.mas_trailing).offset(MARGIN_10);
    }];
    [self.devider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.titleLabel.mas_leading);
        make.trailing.equalTo(-MARGIN_10);
        make.bottom.equalTo(weakSelf.contentView);
        make.height.equalTo(1);
    }];
    
    [super updateConstraints];
    
}
- (void)setViewModel:(ZUserCenterCellViewModel *)viewModel {
    
    if (!viewModel) {
        return;
    }
    
    _viewModel = viewModel;
    
    self.titleLabel.text = viewModel.title;
    
    self.contentLabel.text = viewModel.content;

    self.icon.image = ImageNamed(viewModel.icon);
}

#pragma mark - lazyLoad
- (UIImageView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIImageView alloc] initWithImage:[UIImage resizableImage:@""]];
        _bgView.userInteractionEnabled = YES;
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
        _titleLabel.font = SYSTEM_FONT(15);
    }
    return _titleLabel;
}
- (UILabel *)contentLabel {
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _contentLabel.font = SYSTEM_FONT(15);
        _contentLabel.textAlignment = NSTextAlignmentRight;
    }
    return _contentLabel;
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
