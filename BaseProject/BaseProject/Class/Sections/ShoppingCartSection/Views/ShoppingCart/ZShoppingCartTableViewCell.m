//
//  ZShoppingCartTableViewCell.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/20.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZShoppingCartTableViewCell.h"

@interface ZShoppingCartTableViewCell ()

@property (nonatomic, strong) UIImageView *productIcon;

@property (nonatomic, strong) UILabel *productName;

@property (nonatomic, strong) UILabel *productDescripton;

@property (nonatomic, strong) UILabel *productPrice;

@property (nonatomic, strong) UIButton *productNumAdd;

@property (nonatomic, strong) UIButton *productNumReduce;

@property (nonatomic, strong) UILabel *productNum;

@property (nonatomic, strong) UIView *devider;

@end
@implementation ZShoppingCartTableViewCell
- (void)z_setupViews {
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    self.tintColor = red_color;
    
    [self.contentView addSubview:self.productIcon];
    [self.contentView addSubview:self.productName];
    [self.contentView addSubview:self.productDescripton];
    [self.contentView addSubview:self.productPrice];
    [self.contentView addSubview:self.productNumAdd];
    [self.contentView addSubview:self.productNumReduce];
    [self.contentView addSubview:self.productNum];
    [self.contentView addSubview:self.devider];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)updateConstraints {
    
    WS(weakSelf)
    CGFloat paddingEdge = 10;
    [self.productIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(paddingEdge);
        make.top.equalTo(weakSelf.contentView).offset(paddingEdge);
        make.size.equalTo(CGSizeMake(90, 120));
    }];
    [self.productDescripton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.productIcon.mas_trailing).offset(paddingEdge);
        make.trailing.equalTo(-paddingEdge);
        make.centerY.equalTo(weakSelf.productIcon);
        make.height.equalTo(30);
    }];
    [self.productName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.productIcon.mas_trailing).offset(paddingEdge);
        make.trailing.equalTo(-paddingEdge);
        make.centerY.equalTo(weakSelf.productIcon).offset(-30);
        make.height.equalTo(30);
    }];
    [self.productPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.productIcon.mas_trailing).offset(paddingEdge);
        make.trailing.equalTo(-paddingEdge);
        make.centerY.equalTo(weakSelf.productIcon).offset(30);
        make.height.equalTo(30);
    }];
    [self.productNumReduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(-paddingEdge);
        make.bottom.equalTo(weakSelf.productIcon);
        make.size.equalTo(CGSizeMake(20, 20));
    }];
    [self.productNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(weakSelf.productNumReduce.mas_leading).offset(-MARGIN_5);
        make.bottom.equalTo(weakSelf.productIcon);
        make.size.equalTo(CGSizeMake(20, 20));
    }];
    [self.productNumAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(weakSelf.productNum.mas_leading).offset(-MARGIN_5);
        make.bottom.equalTo(weakSelf.productIcon);
        make.size.equalTo(CGSizeMake(20, 20));
    }];
    
    [super updateConstraints];
    
}
- (void)setViewModel:(ZShoppingCartTableViewCellViewModel *)viewModel {
    
    if (!viewModel) {
        return;
    }
    
    _viewModel = viewModel;
}

#pragma mark - lazyLoad
- (UIImageView *)productIcon
{
    if (!_productIcon) {
        _productIcon = [[UIImageView alloc] init];
        _productIcon.contentMode = UIViewContentModeScaleAspectFill;
        _productIcon.backgroundColor = red_color;
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
        _productDescripton.font = SYSTEM_FONT(14);
        _productDescripton.backgroundColor = MAIN_LIGHT_LINE_COLOR;
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
        _productNum.layer.borderColor = MAIN_LINE_COLOR.CGColor;
        _productNum.layer.borderWidth = 0.5;
        _productNum.textColor = MAIN_TEXT_COLOR;
        _productNum.font = SYSTEM_FONT(14);
        _productNum.textAlignment = NSTextAlignmentCenter;
        _productNum.text = @"2";
    }
    return _productNum;
}
- (UIButton *)productNumAdd {
    if (!_productNumAdd) {
        _productNumAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        _productNumAdd.layer.borderColor = MAIN_LINE_COLOR.CGColor;
        _productNumAdd.layer.borderWidth = 0.5;
        [_productNumAdd setImage:ImageNamed(@"加号") forState:UIControlStateNormal];
        _productNumAdd.imageView.contentMode = UIViewContentModeCenter;
        [[_productNumAdd rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
        }];
    }
    return _productNumAdd;
}
- (UIButton *)productNumReduce {
    if (!_productNumReduce) {
        _productNumReduce = [UIButton buttonWithType:UIButtonTypeCustom];
        _productNumReduce.layer.borderColor = MAIN_LINE_COLOR.CGColor;
        _productNumReduce.layer.borderWidth = 0.5;
        [_productNumReduce setImage:ImageNamed(@"减号") forState:UIControlStateNormal];
        _productNumReduce.imageView.contentMode = UIViewContentModeCenter;
        [[_productNumReduce rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
        }];
    }
    return _productNumReduce;
}
#pragma mark - 设置选中状态的左边选中图片
-(void)layoutSubviews
{
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (self.selected) {
                        img.image=[UIImage imageNamed:@"选中"];
                    }else
                    {
                        img.image=[UIImage imageNamed:@"未选中"];
                    }
                }
            }
        }
    }
    [super layoutSubviews];
}


//适配第一次图片为空的情况
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (!self.selected) {
                        img.image=[UIImage imageNamed:@"未选中"];
                    }
                }
            }
        }
    }
    
}
@end
