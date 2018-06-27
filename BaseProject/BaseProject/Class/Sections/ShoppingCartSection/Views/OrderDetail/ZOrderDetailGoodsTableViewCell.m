//
//  ZOrderDetailGoodsTableViewCell.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/25.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZOrderDetailGoodsTableViewCell.h"

@interface ZOrderDetailGoodsTableViewCell ()

@property (nonatomic, strong) UILabel *productName;

@property (nonatomic, strong) UILabel *productDescription;

@property (nonatomic, strong) UILabel *productPrice;

@property (nonatomic, strong) UIImageView *productIcon;

@property (nonatomic, strong) UILabel *productNum;

@end
@implementation ZOrderDetailGoodsTableViewCell
- (void)z_setupViews {
    
    [self.contentView addSubview:self.productName];
    [self.contentView addSubview:self.productDescription];
    [self.contentView addSubview:self.productPrice];
    [self.contentView addSubview:self.productIcon];
    [self.contentView addSubview:self.productNum];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)updateConstraints {
    
    WS(weakSelf)
    
    CGFloat paddingEdge = 10;
    CGFloat labelH = 20;
    [self.productIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset(paddingEdge);
        make.top.equalTo(weakSelf.contentView).offset(paddingEdge);
        make.size.equalTo(CGSizeMake(110, 130));
    }];
    [self.productName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(weakSelf.productIcon.mas_trailing).offset(paddingEdge);
        make.centerY.equalTo(weakSelf.productIcon).offset(-labelH - 2*MARGIN_10);
        make.trailing.equalTo(-paddingEdge);
    }];
    [self.productDescription mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(weakSelf.productIcon.mas_trailing).offset(paddingEdge);
        make.top.equalTo(weakSelf.productName).offset(labelH + MARGIN_10);
        make.trailing.equalTo(- paddingEdge);
        make.height.equalTo(30);
    }];
    [self.productPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(weakSelf.productIcon.mas_trailing).offset(paddingEdge);
        make.top.equalTo(weakSelf.productDescription).offset(labelH + 2*MARGIN_10);
        make.trailing.equalTo(-paddingEdge);
    }];
    [self.productNum mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.contentView).offset(-paddingEdge);
        make.bottom.equalTo(weakSelf.contentView).offset(-paddingEdge);
        make.size.equalTo(CGSizeMake(50, 20));
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
- (UILabel *)productName {
    
    if (!_productName) {
        _productName = [[UILabel alloc] init];
        _productName.textColor = MAIN_TEXT_COLOR;
        _productName.font = SYSTEM_FONT(17);
        _productName.text = @"拦精灵";
    }
    return _productName;
}
- (UILabel *)productDescription {
    
    if (!_productDescription) {
        _productDescription = [[UILabel alloc] init];
        _productDescription.textColor = MAIN_TEXT_COLOR;
        _productDescription.font = SYSTEM_FONT(14);
        _productDescription.backgroundColor = MAIN_LIGHT_LINE_COLOR;
        _productDescription.text = @"整装 6 盒 特别推荐";
    }
    return _productDescription;
}
- (UILabel *)productPrice {
    
    if (!_productPrice) {
        _productPrice = [[UILabel alloc] init];
        _productPrice.textColor = MAIN_TEXT_COLOR;
        _productPrice.font = SYSTEM_FONT(17);
        _productPrice.text = @"¥128";
    }
    return _productPrice;
}
- (UIImageView *)productIcon
{
    if (!_productIcon) {
        _productIcon = [[UIImageView alloc] initWithImage:ImageNamed(@"")];
        _productIcon.contentMode = UIViewContentModeScaleAspectFill;
        _productIcon.backgroundColor = gray_color;
    }
    return _productIcon;
}
- (UILabel *)productNum {
    
    if (!_productNum) {
        _productNum = [[UILabel alloc] init];
        _productNum.textColor = MAIN_TEXT_COLOR;
        _productNum.textAlignment = NSTextAlignmentRight;
        _productNum.font = SYSTEM_FONT(14);
        _productNum.text = @"x2";
    }
    return _productNum;
}

@end
