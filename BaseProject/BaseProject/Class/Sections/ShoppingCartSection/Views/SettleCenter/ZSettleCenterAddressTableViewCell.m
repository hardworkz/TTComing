//
//  ZSettleCenterAddressTableViewCell.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/21.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZSettleCenterAddressTableViewCell.h"

@interface ZSettleCenterAddressTableViewCell ()

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UILabel *name;

@property (nonatomic, strong) UILabel *phone;

@property (nonatomic, strong) UILabel *address;

@property (nonatomic, strong) UIImageView *rightArrow;

@property (nonatomic, strong) UIImageView *logoIcon;

@property (nonatomic, strong) UILabel *addressAddTip;

@property (nonatomic, strong) UIImageView *logoIconTip;

@end
@implementation ZSettleCenterAddressTableViewCell
- (void)z_setupViews {
    
    [self.contentView addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.name];
    [self.bgImageView addSubview:self.phone];
    [self.bgImageView addSubview:self.address];
    [self.bgImageView addSubview:self.rightArrow];
    [self.bgImageView addSubview:self.logoIcon];
    [self.bgImageView addSubview:self.logoIconTip];
    [self.bgImageView addSubview:self.addressAddTip];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)updateConstraints {
    
    WS(weakSelf)
    
    CGFloat paddingEdge = 10;
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf.contentView);
    }];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.bgImageView).offset(paddingEdge);
        make.top.equalTo(weakSelf.bgImageView).offset(20);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 20));
        make.trailing.equalTo(-paddingEdge-20);
    }];
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.bgImageView).offset(paddingEdge);
        make.top.equalTo(weakSelf.name).offset(20);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 20));
        make.trailing.equalTo(-paddingEdge-20);
    }];
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(paddingEdge);
        make.top.equalTo(weakSelf.phone).offset(20);
        make.trailing.equalTo(-paddingEdge-20);
    }];
    
    [self.rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.equalTo(-MARGIN_10);
        make.bottom.equalTo(weakSelf.address.mas_bottom).offset(MARGIN_5);
        make.size.equalTo(CGSizeMake(20, 20));
    }];
    [self.logoIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.equalTo(0);
        make.top.equalTo(weakSelf.bgImageView);
        make.size.equalTo(CGSizeMake(50, 50));
    }];
    
    //无地址界面约束
    [self.logoIconTip mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf.bgImageView);
        make.top.equalTo(weakSelf.bgImageView);
        make.size.equalTo(CGSizeMake(50, 50));
    }];
    [self.addressAddTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(0);
        make.top.equalTo(weakSelf.logoIconTip.mas_bottom);
    }];
    [super updateConstraints];
    
}
- (void)setViewModel:(ZSettleCenterContentCellViewModel *)viewModel {
    
    if (!viewModel) {
        return;
    }
    
    _viewModel = viewModel;
    
    if (self.hasAddress/*有地址*/) {
        self.addressAddTip.hidden = YES;
        self.logoIconTip.hidden = YES;
        
        self.logoIcon.hidden = NO;
        self.address.hidden = NO;
        self.name.hidden = NO;
        self.phone.hidden = NO;
        
    }else{
        self.addressAddTip.hidden = NO;
        self.logoIconTip.hidden = NO;
        
        self.logoIcon.hidden = YES;
        self.address.hidden = YES;
        self.name.hidden = YES;
        self.phone.hidden = YES;
    }
}

#pragma mark - lazyLoad
- (UILabel *)name {
    
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.textColor = MAIN_TEXT_COLOR;
        _name.font = SYSTEM_FONT(17);
        _name.text = @"黄三岁";
    }
    return _name;
}
- (UILabel *)phone {
    
    if (!_phone) {
        _phone = [[UILabel alloc] init];
        _phone.textColor = MAIN_TEXT_COLOR;
        _phone.font = SYSTEM_FONT(15);
        _phone.text = @"18888888888";
    }
    return _phone;
}
- (UILabel *)address {
    
    if (!_address) {
        _address = [[UILabel alloc] init];
        _address.textColor = MAIN_TEXT_COLOR;
        _address.font = SYSTEM_FONT(14);
        _address.text = @"[默认地址]福建省厦门市思明区水晶国际71号#88";
        _address.numberOfLines = 2;
    }
    return _address;
}
- (UIImageView *)rightArrow
{
    if (!_rightArrow) {
        _rightArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"三角箭头")];
        _rightArrow.contentMode = UIViewContentModeCenter;
    }
    return _rightArrow;
}
- (UIImageView *)logoIcon
{
    if (!_logoIcon) {
        _logoIcon = [[UIImageView alloc] initWithImage:ImageNamed(@"小形象图")];
        _logoIcon.contentMode = UIViewContentModeCenter;
    }
    return _logoIcon;
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage resizableImage:@"背景外发光"]];
    }
    return _bgImageView;
}
//无地址界面控件
- (UIImageView *)logoIconTip
{
    if (!_logoIconTip) {
        _logoIconTip = [[UIImageView alloc] initWithImage:ImageNamed(@"请添加您的地址哦小形象图")];
        _logoIconTip.contentMode = UIViewContentModeCenter;
    }
    return _logoIconTip;
}
- (UILabel *)addressAddTip {
    
    if (!_addressAddTip) {
        _addressAddTip = [[UILabel alloc] init];
        _addressAddTip.textColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _addressAddTip.font = SYSTEM_FONT(15);
        _addressAddTip.textAlignment = NSTextAlignmentCenter;
        _addressAddTip.text = @"请添加您的地址哦！";
    }
    return _addressAddTip;
}
@end
