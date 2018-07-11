//
//  ZSettleCenterTipTableViewCell.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/22.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZSettleCenterTipTableViewCell.h"

@interface ZSettleCenterTipTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *Description;

@property (nonatomic, strong) UIImageView *tipIcon;

@end
@implementation ZSettleCenterTipTableViewCell
- (void)z_setupViews {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.tipIcon];
    [self.contentView addSubview:self.Description];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)updateConstraints {
    
    WS(weakSelf)
    
    CGFloat paddingEdge = 10;
    [self.tipIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.contentView).offset(paddingEdge);
        make.leading.equalTo(paddingEdge);
        make.size.equalTo(CGSizeMake(20, 20));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.tipIcon.mas_trailing);
        make.trailing.equalTo(- paddingEdge);
        make.centerY.equalTo(weakSelf.tipIcon);
    }];
    [self.Description mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.tipIcon.mas_trailing);
        make.top.equalTo(weakSelf.tipIcon).offset(3 * paddingEdge);
        make.trailing.equalTo(-2*paddingEdge);
        make.bottom.equalTo(weakSelf.contentView).offset(-MARGIN_10);
    }];
    
    [super updateConstraints];
    
}
- (void)setViewModel:(ZSettleCenterTipTableViewCellViewModel *)viewModel {
    
    if (!viewModel) {
        return;
    }
    
    _viewModel = viewModel;
    
    self.titleLabel.text = viewModel.title;
    self.Description.text = viewModel.content;
    
    // 自动适配并重新布局
    [self.Description sizeToFit];// 可以得到label的正确高度
    [self layoutIfNeeded];//会重新调用一次LayoutSubViews
}

/**
 根绝数据计算cell的高度
 */
- (CGFloat)cellHeightForViewModel:(ZSettleCenterTipTableViewCellViewModel *)viewModel {
    [self setViewModel:viewModel];
    [self layoutIfNeeded];
    
    CGFloat cellHeight = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return cellHeight;
}
#pragma mark - lazyLoad
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = MAIN_TEXT_COLOR;
        _titleLabel.font = SYSTEM_FONT(15);
    }
    return _titleLabel;
}
- (UILabel *)Description {
    
    if (!_Description) {
        _Description = [[UILabel alloc] init];
        _Description.textColor = gray_color;
        _Description.font = SYSTEM_FONT(14);
        _Description.numberOfLines = 0;
        //设置该属性，让label撑开cell的高度，否则只会计算一行高度
        _Description.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 2*MARGIN_10 - 30;
    }
    return _Description;
}
- (UIImageView *)tipIcon
{
    if (!_tipIcon) {
        _tipIcon = [[UIImageView alloc] initWithImage:ImageNamed(@"说明-点")];
        _tipIcon.contentMode = UIViewContentModeCenter;
    }
    return _tipIcon;
}
@end
