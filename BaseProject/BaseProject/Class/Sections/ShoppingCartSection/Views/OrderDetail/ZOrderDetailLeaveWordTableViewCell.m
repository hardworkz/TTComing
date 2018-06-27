//
//  ZOrderDetailLeaveWordTableViewCell.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/25.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZOrderDetailLeaveWordTableViewCell.h"

@interface ZOrderDetailLeaveWordTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *Description;

@property (nonatomic, strong) UIView *devider;

@end
@implementation ZOrderDetailLeaveWordTableViewCell
- (void)z_setupViews {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.Description];
    [self.contentView addSubview:self.devider];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)updateConstraints {
    
    WS(weakSelf)
    
    CGFloat paddingEdge = 10;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(paddingEdge);
        make.bottom.equalTo(weakSelf.contentView).offset(- 5);
    }];
    [self.titleLabel
        setContentCompressionResistancePriority:UILayoutPriorityRequired
        forAxis:UILayoutConstraintAxisHorizontal
        ];
    
    [self.Description mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.titleLabel.mas_trailing).offset(paddingEdge);
        make.centerY.equalTo(weakSelf.titleLabel);
        make.trailing.equalTo(-MARGIN_10);
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
- (UILabel *)Description {
    
    if (!_Description) {
        _Description = [[UILabel alloc] init];
        _Description.textColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _Description.font = SYSTEM_FONT(14);
        _Description.textAlignment = NSTextAlignmentRight;
        _Description.text = @"注意隐私保护，不要泄露信息注意隐私保护";
    }
    return _Description;
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
