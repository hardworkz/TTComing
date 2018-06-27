//
//  ZCommentTableViewCell.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/27.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZCommentTableViewCell.h"

@interface ZCommentTableViewCell ()

@property (nonatomic, strong) UIImageView *userIcon;

@property (nonatomic, strong) UILabel *name;

@property (nonatomic, strong) UILabel *time;

@property (nonatomic, strong) UILabel *content;

@end
@implementation ZCommentTableViewCell
- (void)z_setupViews {
    
    [self.contentView addSubview:self.userIcon];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.content];
    
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
        make.bottom.equalTo(weakSelf.contentView).offset(-MARGIN_15);
    }];
    
    [super updateConstraints];
    
}
- (void)setViewModel:(ZCommentTableViewCellViewModel *)viewModel {
    
    if (!viewModel) {
        return;
    }
    
    _viewModel = viewModel;
    
}
/**
 根绝数据计算cell的高度
 */
- (CGFloat)cellHeightForViewModel:(ZCommentTableViewCellViewModel *)viewModel {
    [self setViewModel:viewModel];
    [self layoutIfNeeded];
    
    CGFloat cellHeight = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return cellHeight;
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
        _name.text = @"盒子精灵";
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
        _content.numberOfLines = 0;
        _content.text = @"哈哈哈，隐私性超好！哈哈哈，隐私性超好！哈哈哈，隐私性超好！哈哈哈，隐私性超好！哈哈哈，隐私性超好！哈哈哈，隐私性超好！哈哈哈，隐私性超好！";
        _content.preferredMaxLayoutWidth = SCREEN_WIDTH - 65;
    }
    return _content;
}

@end
