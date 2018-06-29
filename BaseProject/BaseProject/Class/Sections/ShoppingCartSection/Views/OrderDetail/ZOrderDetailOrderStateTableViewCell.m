//
//  ZOrderDetailOrderStateTableViewCell.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/25.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZOrderDetailOrderStateTableViewCell.h"

@interface ZOrderDetailOrderStateTableViewCell ()

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UILabel *state;

@property (nonatomic, strong) UILabel *time;

@property (nonatomic, strong) UILabel *price;

@property (nonatomic, strong) UILabel *cancleLabel;

@property (nonatomic, strong) UIImageView *logoIcon;

@end
@implementation ZOrderDetailOrderStateTableViewCell
- (void)z_setupViews {
    
    [self.contentView addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.state];
    [self.bgImageView addSubview:self.time];
    [self.bgImageView addSubview:self.price];
    [self.bgImageView addSubview:self.cancleLabel];
    [self.bgImageView addSubview:self.logoIcon];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)updateConstraints {
    
    WS(weakSelf)
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf.contentView);
        make.height.equalTo(100);
    }];
    [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(MARGIN_10);
        make.top.equalTo(weakSelf.bgImageView).offset(MARGIN_15);
        make.height.equalTo(25);
    }];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(MARGIN_10);
        make.bottom.equalTo(weakSelf.bgImageView).offset(-MARGIN_15);
    }];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.time.mas_trailing).offset(MARGIN_10);
        make.trailing.equalTo(-MARGIN_10);
        make.centerY.equalTo(weakSelf.time);
    }];
    [self.logoIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.equalTo(0);
        make.top.equalTo(weakSelf.bgImageView);
        make.size.equalTo(CGSizeMake(50, 50));
    }];
    [self.cancleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.bgImageView);
        make.centerX.equalTo(weakSelf.bgImageView);
    }];
    [super updateConstraints];
    
}
- (void)setViewModel:(ZOrderDetailCenterTableViewCellViewModel *)viewModel {
    
    if (!viewModel) {
        return;
    }
    
    _viewModel = viewModel;
    
    if (self.hasTimeout/*是否超时*/) {
        self.state.hidden = YES;
        self.time.hidden = YES;
        self.logoIcon.hidden = YES;
        self.price.hidden = YES;
        
        self.cancleLabel.hidden = NO;
        
    }else{
        self.state.hidden = NO;
        self.time.hidden = NO;
        self.logoIcon.hidden = NO;
        self.price.hidden = NO;
        
        self.cancleLabel.hidden = NO;
    }
}

#pragma mark - lazyLoad
- (UILabel *)state {
    
    if (!_state) {
        _state = [[UILabel alloc] init];
        _state.textColor = MAIN_COLOR;
        _state.font = SYSTEM_FONT(16);
        _state.text = @"待付款";
    }
    return _state;
}
- (UILabel *)time {
    
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.textColor = MAIN_COLOR;
        _time.font = SYSTEM_FONT(13);
        _time.text = @"系统将于29.59后自动关闭交易";
    }
    return _time;
}
- (UILabel *)price {
    
    if (!_price) {
        _price = [[UILabel alloc] init];
        _price.textColor = MAIN_COLOR;
        _price.font = SYSTEM_FONT(16);
        _price.textAlignment = NSTextAlignmentRight;
        _price.text = @"¥128";
    }
    return _price;
}
- (UILabel *)cancleLabel {
    
    if (!_cancleLabel) {
        _cancleLabel = [[UILabel alloc] init];
        _cancleLabel.textColor = MAIN_COLOR;
        _cancleLabel.font = SYSTEM_FONT(17);
        _cancleLabel.textAlignment = NSTextAlignmentCenter;
        _cancleLabel.text = @"已取消";
        _cancleLabel.hidden = YES;
    }
    return _cancleLabel;
}
- (UIImageView *)logoIcon
{
    if (!_logoIcon) {
        _logoIcon = [[UIImageView alloc] initWithImage:ImageNamed(@"小形象图")];
        _logoIcon.contentMode = UIViewContentModeCenter;
    }
    return _logoIcon;
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage resizableImage:@"背景外发光"]];
    }
    return _bgImageView;
}
@end
