//
//  ZHomeListCollectionViewCell.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/13.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZHomeListCollectionViewCell.h"

@interface ZHomeListCollectionViewCell ()

@property (nonatomic, strong) UIImageView *productImage;

@property (nonatomic, strong) UILabel *name;

@property (nonatomic, strong) UILabel *Description;

@property (nonatomic, strong) UILabel *price;
@end
@implementation ZHomeListCollectionViewCell
- (void)z_setupViews {
    
    [self.contentView addSubview:self.productImage];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.Description];
    [self.contentView addSubview:self.price];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)updateConstraints {
    
    WS(weakSelf)
    [self.productImage mas_makeConstraints:^(MASConstraintMaker *make) {

        make.leading.trailing.equalTo(0);
        make.top.equalTo(weakSelf.contentView);
        make.height.equalTo(SCREEN_WIDTH * 0.5 - 5);
    }];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.productImage.mas_bottom).offset(MARGIN_10);
        make.leading.equalTo(MARGIN_10);
        make.trailing.equalTo(-MARGIN_10);
    }];
    [self.Description mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.name.mas_bottom);
        make.leading.equalTo(MARGIN_10);
        make.trailing.equalTo(-MARGIN_10);
    }];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.Description.mas_bottom).offset(MARGIN_10);
        make.leading.equalTo(MARGIN_10);
        make.trailing.equalTo(-MARGIN_10);
        make.bottom.equalTo(weakSelf.contentView).offset(-MARGIN_15);
    }];
    [super updateConstraints];
    
}
- (void)setViewModel:(ZHomeListCollectionViewCellViewModel *)viewModel {
    
    if (!viewModel) {
        return;
    }
    
    _viewModel = viewModel;

    self.productImage.image = ImageNamed(viewModel.image);
}
/**
 根绝数据计算cell的高度
 */
- (CGFloat)cellHeightForViewModel:(ZHomeListCollectionViewCellViewModel *)viewModel {
    [self setViewModel:viewModel];
    [self layoutIfNeeded];
    
    CGFloat cellHeight = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return cellHeight;
}
#pragma mark - lazyLoad
- (UIImageView *)productImage
{
    if (!_productImage) {
        _productImage = [[UIImageView alloc] init];
        _productImage.clipsToBounds = YES;
        _productImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _productImage;
}
- (UILabel *)name {
    
    if (!_name) {
        
        _name = [[UILabel alloc] init];
        _name.textColor = MAIN_TEXT_COLOR;
        _name.font = SYSTEM_FONT(15);
        _name.text = @"拦精灵";
    }
    return _name;
}
- (UILabel *)Description {
    
    if (!_Description) {
        
        _Description = [[UILabel alloc] init];
        _Description.textColor = MAIN_TEXT_COLOR;
        _Description.font = SYSTEM_FONT(13);
        _Description.text = @"整装 6 盒 特别推荐";
    }
    return _Description;
}
- (UILabel *)price {
    
    if (!_price) {
        
        _price = [[UILabel alloc] init];
        _price.textColor = MAIN_TEXT_COLOR;
        _price.font = BOLD_SYSTEM_FONT(17);
        _price.text = @"¥128";
    }
    return _price;
}
@end
