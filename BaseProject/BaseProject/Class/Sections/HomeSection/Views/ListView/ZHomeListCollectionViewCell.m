//
//  ZHomeListCollectionViewCell.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/13.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZHomeListCollectionViewCell.h"

@interface ZHomeListCollectionViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end
@implementation ZHomeListCollectionViewCell
- (void)z_setupViews {
    
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.backgroundColor = green_color;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)updateConstraints {
    
    WS(weakSelf)
    
//    CGFloat paddingEdge = 10;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.contentView);
        make.size.equalTo(CGSizeMake(100, 100));
    }];
    
    [super updateConstraints];
    
}
- (void)setViewModel:(ZHomeListCollectionViewCellViewModel *)viewModel {
    
    if (!viewModel) {
        return;
    }
    
    _viewModel = viewModel;
    
    self.titleLabel.text = @"haha";
}

#pragma mark - lazyLoad
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = MAIN_TEXT_COLOR;
        _titleLabel.font = SYSTEM_FONT(14);
        _titleLabel.text = @"haha";
    }
    
    return _titleLabel;
}
@end
