//
//  ZGoodsDetailCommentCell.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/26.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZGoodsDetailCommentCell.h"

@interface ZGoodsDetailCommentCell ()

@property (nonatomic, strong) UIImageView *userIcon;

@property (nonatomic, strong) UILabel *name;

@property (nonatomic, strong) UILabel *time;

@property (nonatomic, strong) UILabel *content;

@property (nonatomic, strong) UIView *devider;

@end
@implementation ZGoodsDetailCommentCell
- (void)z_setupViews {
    
    [self.contentView addSubview:self.userIcon];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.content];
    [self.contentView addSubview:self.devider];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)updateConstraints {
    
    WS(weakSelf)
    
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(MARGIN_15);
        make.top.equalTo(weakSelf.contentView).offset(MARGIN_10);
        make.size.equalTo(CGSizeMake(30, 30));
    }];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.userIcon.mas_trailing).offset(MARGIN_10);
        make.centerY.equalTo(weakSelf.userIcon);
    }];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.name.mas_trailing).offset(MARGIN_10);
        make.centerY.equalTo(weakSelf.userIcon);
        make.trailing.equalTo(-MARGIN_10);
    }];
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.name);
        make.trailing.equalTo(-MARGIN_10);
        make.top.equalTo(weakSelf.name.mas_bottom).offset(MARGIN_15);
    }];
    [self.devider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.userIcon.mas_leading);
        make.trailing.equalTo(weakSelf.time.mas_trailing);
        make.bottom.equalTo(weakSelf.contentView);
        make.height.equalTo(1);
    }];
    
    [super updateConstraints];
    
}
- (void)setViewModel:(ZGoodsDetailCommentCellViewModel *)viewModel {
    
    if (!viewModel) {
        return;
    }
    
    _viewModel = viewModel;
    
}

#pragma mark - lazyLoad
- (UIImageView *)userIcon
{
    if (!_userIcon) {
        _userIcon = [[UIImageView alloc] init];
        _userIcon.contentMode = UIViewContentModeScaleAspectFill;
        _userIcon.backgroundColor = randomColor;
        _userIcon.layer.cornerRadius = 15;
    }
    return _userIcon;
}
- (UILabel *)name {
    
    if (!_name) {
        
        _name = [[UILabel alloc] init];
        _name.textColor = MAIN_TEXT_COLOR;
        _name.font = BOLD_SYSTEM_FONT(15);
        _name.text = @"盒子";
    }
    return _name;
}
- (UILabel *)time {
    
    if (!_time) {
        
        _time = [[UILabel alloc] init];
        _time.textColor = MAIN_TEXT_COLOR;
        _time.font = SYSTEM_FONT(12);
        _time.text = @"2018/06/22 16.56";
    }
    return _time;
}
- (UILabel *)content {
    
    if (!_content) {
        
        _content = [[UILabel alloc] init];
        _content.textColor = MAIN_TEXT_COLOR;
        _content.font = SYSTEM_FONT(15);
        _content.text = @"哈哈哈，隐私性超好！";
    }
    return _content;
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
