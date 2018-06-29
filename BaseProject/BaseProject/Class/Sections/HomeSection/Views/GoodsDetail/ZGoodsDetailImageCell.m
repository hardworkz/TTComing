//
//  ZGoodsDetailImageCell.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/26.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZGoodsDetailImageCell.h"

@interface ZGoodsDetailImageCell ()

@property (nonatomic, strong) UIImageView *contentImageView;

@end
@implementation ZGoodsDetailImageCell
- (void)z_setupViews {
    
    [self.contentView addSubview:self.contentImageView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)updateConstraints {
    
    WS(weakSelf)
    
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView);
    }];
    
    [super updateConstraints];
    
}
- (void)setViewModel:(ZGoodsDetailImageCellViewModel *)viewModel {
    
    if (!viewModel) {
        return;
    }
    
    _viewModel = viewModel;
    
    self.contentImageView.image = ImageNamed(viewModel.image);
}

#pragma mark - lazyLoad
- (UIImageView *)contentImageView
{
    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc] init];
        _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _contentImageView;
}
@end
