//
//  ZMyOrderTableViewCell.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/25.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZMyOrderTableViewCell.h"

@interface ZMyOrderTableViewCell ()

@property (nonatomic, strong) UIImageView *bgView;

@property (nonatomic, strong) UILabel *orderNum;

@property (nonatomic, strong) UILabel *orderState;

@property (nonatomic, strong) UIView *devider;

@property (nonatomic, strong) UIImageView *productIcon;

@property (nonatomic, strong) UILabel *productName;

@property (nonatomic, strong) UILabel *productDescripton;

@property (nonatomic, strong) UILabel *productPrice;

@property (nonatomic, strong) UILabel *productNum;

@property (nonatomic, strong) UIView *deviderTwo;

@property (nonatomic, strong) UILabel *productPriceTotal;

@property (nonatomic, strong) UIButton *actionBtn;

@end
@implementation ZMyOrderTableViewCell
- (void)z_setupViews {
    
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.orderNum];
    [self.bgView addSubview:self.orderState];
    [self.bgView addSubview:self.devider];
    [self.bgView addSubview:self.productIcon];
    [self.bgView addSubview:self.productName];
    [self.bgView addSubview:self.productDescripton];
    [self.bgView addSubview:self.productPrice];
    [self.bgView addSubview:self.productNum];
    [self.bgView addSubview:self.deviderTwo];
    [self.bgView addSubview:self.productPriceTotal];
    [self.bgView addSubview:self.actionBtn];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)updateConstraints {
    
    WS(weakSelf)
    
    CGFloat paddingEdge = 10;
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView);
        make.height.equalTo(45 + 140 + 80 + 20);
    }];
    [self.orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(paddingEdge);
        make.top.equalTo(weakSelf.bgView);
        make.height.equalTo(45);
    }];
    [self.orderState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.orderNum.mas_trailing).offset(paddingEdge);
        make.trailing.equalTo(- paddingEdge);
        make.top.equalTo(weakSelf.bgView);
        make.height.equalTo(45);
    }];
    [self.devider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgView).offset(45);
        make.trailing.leading.equalTo(0);
        make.height.equalTo(0.5);
    }];
    [self.productIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.devider).offset(0.5 + paddingEdge);
        make.leading.equalTo(paddingEdge);
        make.size.equalTo(CGSizeMake(90, 110));
    }];
    [self.productDescripton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.productIcon);
        make.leading.equalTo(weakSelf.productIcon.mas_trailing).offset(paddingEdge);
        make.height.equalTo(20);
        make.trailing.equalTo(-paddingEdge);
    }];
    [self.productName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.productIcon.mas_trailing).offset(paddingEdge);
        make.trailing.equalTo(-paddingEdge);
        make.centerY.equalTo(weakSelf.productIcon).offset(-30);
        make.height.equalTo(30);
    }];
    [self.productPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.productIcon.mas_trailing).offset(paddingEdge);
        make.centerY.equalTo(weakSelf.productIcon).offset(+30);
        make.height.equalTo(30);
    }];
    [self.productNum mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(weakSelf.productPrice);
    make.leading.equalTo(weakSelf.productPrice.mas_trailing).offset(paddingEdge);
        make.trailing.equalTo(-paddingEdge);
        make.height.equalTo(30);
    }];
    [self.deviderTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.productIcon.mas_bottom).offset(paddingEdge);
        make.leading.trailing.equalTo(0);
        make.height.equalTo(0.5);
    }];
    [self.productPriceTotal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.deviderTwo).offset(paddingEdge + 0.5);
        make.height.equalTo(20);
        make.trailing.leading.equalTo(0);
    }];
    [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.productPriceTotal.mas_bottom).offset(paddingEdge);
        make.size.equalTo(CGSizeMake(70, 30));
        make.centerX.equalTo(weakSelf.bgView);
        make.bottom.equalTo(weakSelf.bgView).offset(-MARGIN_15);
    }];
    
    [super updateConstraints];
    
}
- (void)setViewModel:(ZMyOrderTableViewCellViewModel *)viewModel {
    
    if (!viewModel) {
        return;
    }
    
    _viewModel = viewModel;

    switch (self.orderType) {
        case OrderTypeWaitPay:
            
            break;
        case OrderTypeWaitReceived:
            
            break;
        case OrderTypeWaitComment:
            
            break;
        default:
            break;
    }
}

#pragma mark - lazyLoad
- (UIImageView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIImageView alloc] initWithImage:[UIImage resizableImage:@"订单列表背景外发光"]];
    }
    return _bgView;
}
- (UILabel *)orderNum {
    
    if (!_orderNum) {
        
        _orderNum = [[UILabel alloc] init];
        _orderNum.textColor = MAIN_TEXT_COLOR;
        _orderNum.font = SYSTEM_FONT(13);
        _orderNum.text = @"订单号：888888888888888";
    }
    return _orderNum;
}
- (UILabel *)orderState {
    
    if (!_orderState) {
        
        _orderState = [[UILabel alloc] init];
        _orderState.textColor = MAIN_COLOR;
        _orderState.font = SYSTEM_FONT(15);
        _orderState.textAlignment = NSTextAlignmentRight;
        _orderState.text = @"待留言";
    }
    return _orderState;
}
- (UIView *)devider
{
    if (!_devider) {
        _devider = [[UIView alloc] init];
        _devider.backgroundColor = lightGray_color;
    }
    return _devider;
}
- (UIImageView *)productIcon
{
    if (!_productIcon) {
        _productIcon = [[UIImageView alloc] init];
        _productIcon.contentMode = UIViewContentModeScaleAspectFill;
        _productIcon.backgroundColor = yellow_color;
    }
    return _productIcon;
}
- (UILabel *)productName {
    
    if (!_productName) {
        
        _productName = [[UILabel alloc] init];
        _productName.textColor = MAIN_TEXT_COLOR;
        _productName.font = SYSTEM_FONT(17);
        _productName.text = @"拦精灵";
    }
    return _productName;
}
- (UILabel *)productDescripton {
    
    if (!_productDescripton) {
        
        _productDescripton = [[UILabel alloc] init];
        _productDescripton.textColor = MAIN_TEXT_COLOR;
        _productDescripton.font = SYSTEM_FONT(13);
        _productDescripton.text = @"整装6盒 特别推荐...";
    }
    return _productDescripton;
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
- (UILabel *)productNum {
    
    if (!_productNum) {
        
        _productNum = [[UILabel alloc] init];
        _productNum.textColor = MAIN_TEXT_COLOR;
        _productNum.font = SYSTEM_FONT(13);
        _productNum.text = @"x2";
        _productNum.textAlignment = NSTextAlignmentRight;
    }
    return _productNum;
}

- (UIView *)deviderTwo
{
    if (!_deviderTwo) {
        _deviderTwo = [[UIView alloc] init];
        _deviderTwo.backgroundColor = lightGray_color;
    }
    return _deviderTwo;
}
- (UILabel *)productPriceTotal {
    
    if (!_productPriceTotal) {
        
        _productPriceTotal = [[UILabel alloc] init];
        _productPriceTotal.textColor = MAIN_TEXT_COLOR;
        _productPriceTotal.font = SYSTEM_FONT(13);
        _productPriceTotal.textAlignment = NSTextAlignmentCenter;
        _productPriceTotal.text = @"订单金额：¥256";
    }
    return _productPriceTotal;
}
- (UIButton *)actionBtn
{
    if (!_actionBtn) {
        _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_actionBtn setTitle:@"去留言" forState:UIControlStateNormal];
        [_actionBtn setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
        _actionBtn.titleLabel.font = SYSTEM_FONT(15);
        _actionBtn.layer.cornerRadius = 15;
        _actionBtn.backgroundColor = MAIN_COLOR;
    }
    return _actionBtn;
}
/**
 根绝数据计算cell的高度
 */
- (CGFloat)cellHeightForViewModel:(ZMyOrderTableViewCellViewModel *)viewModel {
    [self setViewModel:viewModel];
    [self layoutIfNeeded];
    
    CGFloat cellHeight = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return cellHeight;
}
@end
