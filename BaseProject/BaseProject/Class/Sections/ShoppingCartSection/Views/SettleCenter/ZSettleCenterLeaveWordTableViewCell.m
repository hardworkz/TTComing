//
//  ZSettleCenterLeaveWordTableViewCell.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/21.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZSettleCenterLeaveWordTableViewCell.h"

@interface ZSettleCenterLeaveWordTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITextField *leaveWordTextField;

@property (nonatomic, strong) UIView *devider;

@end
@implementation ZSettleCenterLeaveWordTableViewCell
- (void)z_setupViews {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.leaveWordTextField];
    [self.contentView addSubview:self.devider];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)updateConstraints {
    
    WS(weakSelf)
    
    CGFloat paddingEdge = 10;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(paddingEdge);
//        make.bottom.equalTo(weakSelf.contentView).offset(- 5);
        make.centerY.equalTo(weakSelf.leaveWordTextField);
    }];
    [self.leaveWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.titleLabel.mas_trailing).offset(paddingEdge);
        make.bottom.equalTo(weakSelf.contentView);
        make.trailing.equalTo(-paddingEdge);
        make.height.equalTo(30);
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
        _titleLabel.text = @"买家留言";
    }
    return _titleLabel;
}
- (UITextField *)leaveWordTextField {
    
    if (!_leaveWordTextField) {
        _leaveWordTextField = [[UITextField alloc] init];
        _leaveWordTextField.textColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        [_leaveWordTextField setValue:lightGray_color forKeyPath:@"_placeholderLabel.textColor"];
        _leaveWordTextField.font = SYSTEM_FONT(14);
        _leaveWordTextField.placeholder = @"请填写您的留言...";
    }
    return _leaveWordTextField;
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
